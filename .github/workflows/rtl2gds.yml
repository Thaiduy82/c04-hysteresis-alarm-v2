name: OpenLane RTL-to-GDSII Flow

on:
  push:
    branches: [ "main" ]
  pull_request:
    branches: [ "main" ]
  workflow_dispatch:

jobs:
  openlane:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v4

      - name: Set up Python
        uses: actions/setup-python@v5
        with:
          python-version: '3.x'

      - name: Run OpenLane Flow
        uses: efabless/openlane-action@v1
        with:
          pdk: sky130A
          design_dir: .

      - name: Extract & Document Metrics
        run: |
          python .github/workflows/doc_metrics.py

      - name: Upload GDSII Artifacts
        uses: actions/upload-artifact@v4
        with:
          name: gdsii-layout-and-reports
          path: |
            runs/
            README.md