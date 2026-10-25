import json
import sys

def main():
    if len(sys.argv) < 2:
        print("Usage: python3 doc_metrics.py <metrics.json>")
        sys.exit(1)
    
    metrics_file = sys.argv[1]
    try:
        with open(metrics_file, 'r') as f:
            data = json.load(f)
        
        print("=== SYNTHESIS METRICS ===")
        if isinstance(data, dict):
            for k, v in list(data.items())[:15]:
                print(f"{k}: {v}")
        else:
            print(data)
    except Exception as e:
        print(f"Error reading metrics file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()