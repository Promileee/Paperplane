import pandas as pd
import numpy as np
import matplotlib.pyplot as plt

import pandas as pd

# 读取Excel文件
effect_result_df = pd.read_excel("effects_results.xlsx")
SS_result_df = pd.read_excel("SS_result.xlsx")

# 转换为NumPy数组
effect_result = effect_result_df.to_numpy()
SS_result = SS_result_df.to_numpy()

# 获取SST值（假设SS_result的第三列第一行是SST）
SST = SS_result[0, 2]

# 存储数据的列表（每个元素是一个元组：(effect_name, SS, effect_rate)）
data_list = []

# 遍历effect_result的每一行
for i in range(len(effect_result)):
    # 获取当前行的数据
    effect_name = effect_result[i, 0]  # 假设effect_name在第0列
    SS = effect_result[i, 3]  # 假设SS在第3列

    # 计算effect_rate
    effect_rate = (SS / SST) * 100

    # 将数据存储到列表中
    data_list.append({
        "effect_name": effect_name,
        "SS": SS,
        "effect_rate": effect_rate
    })

# 按effect_rate降序排序
sorted_data = sorted(data_list, key=lambda x: x["effect_rate"], reverse=True)

# 转换为DataFrame（可选）
sorted_df = pd.DataFrame(sorted_data, columns=["effect_name", "SS", "effect_rate"])

# 设置中文字体（如果需要中文显示）
plt.rcParams['font.sans-serif'] = ['SimHei']
plt.rcParams['axes.unicode_minus'] = False

# 提取数据
effect_names = sorted_df["effect_name"].tolist()
effect_rates = sorted_df["effect_rate"].tolist()

# 创建图表
plt.figure(figsize=(16, 9))
bars = plt.bar(
    x=effect_names,
    height=effect_rates,
    color='skyblue',
    edgecolor='black'
)

# 添加标签和标题
plt.title("各效应贡献率分析", fontsize=14)
plt.xlabel("效应名称", fontsize=12)
plt.ylabel("贡献率 (%)", fontsize=12)
plt.xticks(rotation=45, ha='right')

# 添加数值标签
for bar in bars:
    height = bar.get_height()
    plt.text(
        bar.get_x() + bar.get_width()/2.,
        height,
        f'{height:.1f}%',
        ha='center',
        va='bottom',
        fontsize=8
    )

# 调整布局并显示
plt.tight_layout()
plt.savefig("effect_analysis.png", dpi=600)
plt.show()

# 截取前6行数据
top_6_sorted_df = sorted_df.head(3)

# 提取数据
effect_names = top_6_sorted_df["effect_name"].tolist()
effect_rates = top_6_sorted_df["effect_rate"].tolist()

# 创建图表
plt.figure(figsize=(16, 9))
bars = plt.bar(
    x=effect_names,
    height=effect_rates,
    color='skyblue',
    edgecolor='black'
)

# 添加标签和标题
plt.title("主要因子贡献分析", fontsize=14)
plt.xlabel("效应名称", fontsize=12)
plt.ylabel("贡献率 (%)", fontsize=12)
plt.xticks(rotation=45, ha='right')

# 添加数值标签
for bar in bars:
    height = bar.get_height()
    plt.text(
        bar.get_x() + bar.get_width()/2.,
        height,
        f'{height:.1f}%',
        ha='center',
        va='bottom'
    )

# 调整布局并显示
plt.tight_layout()
plt.savefig("main_effect_analysis.png", dpi=600)
plt.show()