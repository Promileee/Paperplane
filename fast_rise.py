import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
from scipy.interpolate import griddata

# 读取数据
data_df = pd.read_excel("experiment.xlsx")
data = data_df.to_numpy()
E = data[:, 4]  # 第5列（索引4）
F = data[:, 5]  # 第6列（索引5）
score = data[:, 6]  # 第7列（索引6）

# 创建网格
points = np.vstack((E, F)).T  # 将E和F组合成坐标点
grid_x, grid_y = np.mgrid[
    E.min():E.max():100j,  # 自动划分100个间隔
    F.min():F.max():100j
]

# 插值生成网格化的score值
grid_z = griddata(
    points,
    score,
    (grid_x, grid_y),
    method='cubic'  # 可选：'linear', 'nearest', 'cubic'
)

# 绘制等高线图
plt.figure(figsize=(10, 6))
contour = plt.contourf(
    grid_x,
    grid_y,
    grid_z,
    levels=15,  # 等高线数量
    cmap='viridis'  # 颜色映射
)
plt.colorbar(contour, label='Score')  # 添加颜色条

# 添加标签和标题
plt.xlabel('E')
plt.ylabel('F')
plt.title('Contour Plot of Score vs E and F')
plt.grid(alpha=0.3)
plt.tight_layout()
plt.savefig("contour_plot.png", dpi=300, bbox_inches='tight')
# 显示图形
plt.show()