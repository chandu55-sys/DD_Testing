import pandas as pd

def read_names(csv_path):
    try:
        df = pd.read_csv(csv_path, encoding="utf-16")
    except UnicodeDecodeError:
        df = pd.read_csv(csv_path, encoding="utf-8")

    return [str(x).strip().lower() for x in df["name"].tolist()]

def save_results(results, output_path):
    df = pd.DataFrame(results)
    df.to_csv(output_path, index=False, encoding="utf-8-sig")
