import sys, json

if len(sys.argv) < 2:
    sys.exit(0)

with open(sys.argv[1]) as f:
    data = json.load(f)

print("=== CHI SO THIEU KET RTL-TO-GDSII ===")
for k, v in data.items():
    if any(x in k.lower() for x in ['area', 'wire', 'slack', 'power', 'vias', 'drc']):
        print(f"{k}: {v}")