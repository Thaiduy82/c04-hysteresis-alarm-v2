name: OpenLane / LibreLane RTL-to-GDSII Flow

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]
  workflow_dispatch:

env:
  MA_DE: C04
  DESIGN_NAME: threshold_alarm_hysteresis
  CONFIG: config.json

jobs:
  mo-phong:
    name: 1 - Mo phong RTL (Icarus Verilog)
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Cai Icarus Verilog
        run: |
          sudo apt-get update
          sudo apt-get install -y iverilog

      - name: Bien dich va chay testbench
        run: |
          iverilog -g2012 -o sim.vvp rtl/*.v tb/*.v
          vvp sim.vvp | tee simulation.log

      - name: Kiem tra log mo phong (phai co PASS)
        run: |
          if grep -qiE "FATAL|mismatch|\bFAIL\b" simulation.log; then
            echo "::error::Testbench bao loi!"
            exit 1
          fi
          if ! grep -qi "PASS" simulation.log; then
            echo "::error::Khong tim thấy dong PASS trong log mô phong!"
            exit 1
          fi
          echo "Mo phong thanh cong!"

      - uses: actions/upload-artifact@v4
        if: always()
        with:
          name: mo-phong-${{ env.MA_DE }}
          path: |
            simulation.log
            *.vcd

  rtl2gds:
    name: 2 - RTL-to-GDSII (LibreLane + sky130A)
    runs-on: ubuntu-latest
    needs: mo-phong
    steps:
      - uses: actions/checkout@v4

      - name: Cai Nix kem bộ nho dem nhi phan FOSSi
        uses: cachix/install-nix-action@v27
        with:
          extra_nix_config: |
            extra-substituters = https://nix-cache.fossi-foundation.org
            extra-trusted-public-keys = nix-cache.fossi-foundation.org:3+K59iFwXqKsL7BNu6Guy0v+uTlwsxYQxjspXzqLYQs=
            extra-experimental-features = nix-command flakes

      - name: Thiet lap Nix channel
        run: |
          nix-channel --add https://channels.nixos.org/nixpkgs-unstable nixpkgs
          nix-channel --update

      - name: Lay LibreLane
        run: git clone --depth 1 https://github.com/librelane/librelane ~/librelane

      - name: Chay LibreLane Flow
        run: |
          cp config.json ~/librelane/
          cp -r rtl ~/librelane/
          cd ~/librelane
          nix-shell --run "python3 -m librelane config.json"

      - name: Kiem tra san pham GDS va ghi nhan Metrics
        run: |
          cd ~/librelane
          GDS=$(find . -name "*.gds" | head -1)
          MJ=$(find . -name "metrics.json" | head -1)
          if [ -z "$GDS" ]; then echo "::error::Khong sinh duoc file GDS"; exit 1; fi
          if [ -z "$MJ" ];  then echo "::error::Khong tim thay file metrics.json"; exit 1; fi
          
          cp -r runs "$GITHUB_WORKSPACE/"
          cp "$MJ" "$GITHUB_WORKSPACE/metrics.json"
          find . -name "*.gds" -exec cp {} "$GITHUB_WORKSPACE/" \;

          cd "$GITHUB_WORKSPACE"
          echo "GDS File Path: $GDS"
          python3 .github/doc_metrics.py metrics.json

      - name: Upload GDSII Artifacts
        uses: actions/upload-artifact@v4
        if: always()
        with:
          name: rtl2gds-${{ env.MA_DE }}
          path: |
            **/runs/**/final/**
            **/runs/**/*.log
            **/metrics.json
            **/*.gds