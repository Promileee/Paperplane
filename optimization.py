import pandas as pd
import numpy as np
from scipy.optimize import minimize
beta_df = pd.read_excel("beta_parameters.xlsx")
beta = beta_df.to_numpy()[:,1]
print(beta)

def score(c, e, f):
    """
    计算目标函数值 score = x · beta
    Args:
        c (int): 0-100 的整数
        e (float): 15-60 的连续值
        f (float): 80-200 的连续值
    Returns:
        float: 目标函数值
    """
    ef = e * f
    cf = c * f
    ce = c * e
    x = np.array([1, f, e, ef, cf, c, ce])
    return np.dot(beta, x)


def optimize_e_f(c_val):
    """
    对固定 c 的值，优化 e 和 f 的连续变量
    Args:
        c_val (int): 当前 c 的值
    Returns:
        tuple: (最优 e, 最优 f, 最大 score)
    """

    # 定义目标函数（最大化 score → 最小化 -score）
    def objective(vars):
        e, f = vars
        return -score(c_val, e, f)

    # 定义变量边界约束
    bounds = [(15, 60), (80, 200)]  # e ∈ [15,60], f ∈ [80,200]

    # 初始猜测值（可调整）
    initial_guess = [30, 140]

    # 运行优化（使用 L-BFGS-B 方法处理边界约束）
    result = minimize(
        fun=objective,
        x0=initial_guess,
        bounds=bounds,
        method='L-BFGS-B'
    )

    if result.success:
        return (result.x[0], result.x[1], -result.fun)
    else:
        return (None, None, None)  # 优化失败时返回 None


# 主程序：遍历所有可能的 c 值，找到全局最优解
best_c = 0
best_e = 0.0
best_f = 0.0
max_score = -np.inf

for c in range(0, 101):
    e_opt, f_opt, current_score = optimize_e_f(c)
    if current_score is not None and current_score > max_score:
        max_score = current_score
        best_c = c
        best_e = e_opt
        best_f = f_opt

# 输出结果
print(f"最优解：")
print(f"c = {best_c}")
print(f"e = {best_e:.2f}")
print(f"f = {best_f:.2f}")
print(f"最大 score = {max_score:.4f}")

# 可选：将结果保存到 Excel（需安装 openpyxl）
try:
    import pandas as pd

    result_df = pd.DataFrame({
        "Parameter": ["c", "e", "f", "Max Score"],
        "Value": [best_c, best_e, best_f, max_score]
    })
    result_df.to_excel("optimal_parameters.xlsx", index=False)
    print("结果已保存到 optimal_parameters.xlsx")
except ImportError:
    print("请安装 pandas 和 openpyxl 以保存结果：pip install pandas openpyxl")