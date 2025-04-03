import pandas as pd
import numpy as np

# 读取数据
data_df = pd.read_excel("experiment.xlsx")

# 打印原始数据前5行和形状
print("原始数据前5行：")
print(data_df.head())
print("原始数据形状：", data_df.shape)

# 提取并转换需要的列（假设列索引正确）
try:
    C = data_df.iloc[:, 2].astype(np.float64)
    E = data_df.iloc[:, 4].astype(np.float64)
    F = data_df.iloc[:, 5].astype(np.float64)
    score = data_df.iloc[:, 6].astype(np.float64)
except Exception as e:
    print("列索引错误或数据无法转换为数值：", e)
    exit()

# 检查是否有 NaN
if C.isnull().any() or E.isnull().any() or F.isnull().any() or score.isnull().any():
    print("数据中存在 NaN，需进一步清理")
    # 选择非 NaN 的行
    valid_rows = data_df.index[~(C.isnull() | E.isnull() | F.isnull() | score.isnull())]
    C = C[valid_rows]
    E = E[valid_rows]
    F = F[valid_rows]
    score = score[valid_rows]

# 计算交互项
EF = E * F
CF = C * F
CE = C * E

# 构造设计矩阵 X
X = np.column_stack([
    np.ones_like(score),
    F,
    E,
    EF,
    CF,
    C,
    CE
])

print("X的形状:", X.shape)
print("X的类型:", X.dtype)

# 线性拟合（确保 X 的行数 ≥ 列数）
if X.shape[0] < X.shape[1]:
    print("数据不足，无法进行拟合（行数 < 列数）")
else:
    beta, residuals, rank, s = np.linalg.lstsq(X, score, rcond=None)
    print("拟合参数：")
    print(f"beta_0 = {beta[0]:.4f}")
    print(f"beta_1 = {beta[1]:.4f}")
    print(f"beta_2 = {beta[2]:.4f}")
    print(f"beta_3 = {beta[3]:.4f}")
    print(f"beta_4 = {beta[4]:.4f}")
    print(f"beta_5 = {beta[5]:.4f}")
    print(f"beta_6 = {beta[6]:.4f}")

    # 验证拟合效果
    if X.shape[0] > 0:
        predicted = X @ beta
        r_squared = np.corrcoef(score, predicted)[0, 1]**2
        print(f"R² = {r_squared:.4f}")
    else:
        print("数据不足，无法计算 R²")

# ...（之前的代码，包括计算 beta 的部分）...

# 保存 beta 到 Excel
beta_df = pd.DataFrame({
    "Parameter": ["beta_0", "beta_1", "beta_2", "beta_3", "beta_4", "beta_5", "beta_6"],
    "Value": beta.round(4)
})
beta_df.to_excel("beta_parameters.xlsx", index=False, engine='openpyxl')
print("参数已保存到 beta_parameters.xlsx")