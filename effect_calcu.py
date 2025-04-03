import pandas as pd
import itertools

# 读取数据
df = pd.read_excel("pre_experiment.xlsx")

# 数据预处理：将前6列编码为-1和+1
for i in range(64):
    if df.iloc[i, 0] == 'A':
        df.iloc[i, 0] = -1
    else:
        df.iloc[i, 0] = 1
    if df.iloc[i, 1] == 20:
        df.iloc[i, 1] = -1
    else:
        df.iloc[i, 1] = 1
    if df.iloc[i, 2] == 20:
        df.iloc[i, 2] = -1
    else:
        df.iloc[i, 2] = 1
    if df.iloc[i, 3] == 'ON':
        df.iloc[i, 3] = 1
    else:
        df.iloc[i, 3] = -1
    if df.iloc[i, 4] == 15:
        df.iloc[i, 4] = -1
    else:
        df.iloc[i, 4] = 1
    if df.iloc[i, 5] == 40:
        df.iloc[i, 5] = -1
    else:
        df.iloc[i, 5] = 1

df.columns = ["A", "B", "C", "D", "E", "F", "score"]

k = 6  # 因素数量

# 初始化结果字典
effects = {}

# 计算所有可能的交互效应
factors = ["A", "B", "C", "D", "E", "F"]
for r in range(1, k + 1):  # r 表示交互效应的阶数（从1到6）
    for combination in itertools.combinations(factors, r):
        # 构造交互项的名称
        effect_name = "".join(combination)

        # 计算交互项的符号向量
        interaction_vector = df[list(combination)].prod(axis=1)
        print(f"interaction_vector[{r}][{combination}]:", interaction_vector)

        # 计算效应值
        effect_value = (interaction_vector * df["score"]).mean()

        #计算 Costrast 值
        costrast = effect_value * (2 ** 5)

        #计算离均方差
        SS = costrast * costrast / (2 ** 6)

        effects[effect_name] = (effect_value, costrast, SS)

# 将结果转换为DataFrame
results_df = pd.DataFrame(
    [
        (effect_name, value[0], value[1], value[2])  # 拆分元组为三个元素
        for effect_name, value in effects.items()
    ],
    columns=["Effect", "Value", "Costrast", "SS"]
)

# 保存结果到Excel文件
results_df.to_excel("effects_results.xlsx", index=False)

print("计算完成！结果已保存到 effects_results.xlsx")