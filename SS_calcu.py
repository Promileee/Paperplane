import pandas as pd
import numpy as np

pre_experiment_result_df = pd.read_excel("pre_experiment.xlsx")
effect_result_df = pd.read_excel("effects_results.xlsx")

pre_experiment_result = pre_experiment_result_df.to_numpy()
effect_result = effect_result_df.to_numpy()

score_mean = np.mean(pre_experiment_result[:,6])
print(score_mean)
SST = 0
for score in pre_experiment_result[:,6]:
    SST_temp = ( (score - score_mean) / 2)** 2
    SST = SST + SST_temp
print("total SS [SST]",SST)
SS_sum = 0
for SS in effect_result[:,3]:
    SS_sum = SS_sum + SS
print("sum of SS_factors",SS_sum)
SSE = SST - SS_sum
print("error SS [SSE]:", SSE)

result_df = pd.DataFrame(
    (["SST", SST],
     ["SS_sum", SS_sum],
     ["SSE", SSE]),
    columns=["Name", "Value"]
)
result_df.to_excel("SS_result.xlsx")