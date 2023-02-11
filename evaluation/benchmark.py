import os
import subprocess
import pandas as pd
import json

def get_stats(command):
    try:
        output = subprocess.run(command, stdout=subprocess.PIPE, stderr=subprocess.PIPE, shell=True)
        json_output = json.loads(output.stdout)
        time_stats = json_output["Time"]
        return time_stats["Total"], time_stats["Solve"], time_stats["Unsat"], time_stats["CPU"]
    except:
        return "", "", "", ""

def main(folder_path):
    final_array = []
    step = 0
    for subdir, dirs, files in os.walk(folder_path):
        for file in files:
            file_path = os.path.join(subdir, file)
            print(str(step) + ": " + str(file_path))
            command1 = f"clingo {file_path} encodings/encoding.lp --outf=2 | jq '.'"
            command2 = f"clingo {file_path} encodings/encoding_pruning.lp --outf=2 | jq '.'"
            print("Working normaly")
            command1_stats = get_stats(command1)
            print("Working with pruning")
            command2_stats = get_stats(command2)
            final_array.append([file_path] + list(command1_stats) + list(command2_stats))
            step += 1
    df = pd.DataFrame(final_array, columns=["File", "Normal Total", "Normal Solve", "Normal Unsat", "Normal CPU", "Pruning Total", "Pruning Solve", "Pruning Unsat", "Pruning CPU"])
    return df

folder_path = "instances"
main(folder_path).to_csv('evaluation/output.csv')
