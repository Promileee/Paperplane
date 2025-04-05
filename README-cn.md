# 纸飞机试验——一个试验设计的课程项目
这个仓库用于分享一些我在完成试验设计这门课程的一个课设项目时做的一些工作。本着“不要造重复的轮子”的原则，我将我进行这个项目的所有的源代码分享出来，希望能够减轻后人继续研究的工作量。
## 项目介绍
### 纸飞机简介
纸飞机（学名：自主动力空气动力学物理模型）是一种用纸做的玩具飞机，它是航空类折纸手工中最常见的形式，属于折纸手工的一个分支。由于纸飞机是最容易掌握的一种折纸类型，所以深受初学者乃至高手的喜爱。

根据不同的目标，人们设计了不同类型的纸飞机。例如，以最长滞空时间为目的的滞空机。仅由一张纸折叠而成且不适用任何胶水和剪刀的纸飞机，当前最长滞空时间为27.9秒。以最长飞行距离为目标的距离机，当前其世界纪录保持为69.14米。还有以外形逼真为目标的仿真机或仿生机，通过模仿真实飞机或模仿各种生物，实现稳定的滑翔性能。
### 课程项目简介
在本课程项目中，为了使纸飞机的设计过程，飞行环境，结果评价方式更为客观，课程使用纸飞机与试飞模拟器 [Paper Pilot](https://github.com/Promileee/Paperplane/blob/main/paperpilot.swf) 来完成飞机设计并获取飞行数据。 Paper Pilot 模拟器以 Flash 文件的形式提供，可以使用支持 Flash 插件的浏览器或者 Flash 播放器打开运行。
### 纸飞机的参数设置
![纸飞机参数设置界面](/parameters_setting.png "纸飞机参数设置界面")
如图所示是纸飞机设计与飞行模拟器的参数设置界面，模拟器提供的参数共4个，分别为： Plane Type （飞机类型）， Paper Weight （纸张重量）， Elevator （升降舵）和 Winglets （小翼）。参数设置完毕后，点击右侧的 `Practice` ，即可进入试飞界面。
### 纸飞机的试飞
![纸飞机试飞界面](/test_flight.png "纸飞机试飞界面")
如图所示是纸飞机设计与飞行模拟器的试飞界面，用鼠标拖动图中的飞机进行初始姿态调整，松开鼠标即可开始模拟飞行，系统会自动模拟出飞行轨迹，并在右下角实时展示飞行距离。
### 设计目标
本课程项目的目标是用 Paper Pilot 模拟器，进行纸飞机的模拟设计与飞行，并能够稳定的实现最远的飞行距离。亦即，本课程项目包括两个目标。
1. 飞行距离尽可能远；
2. 在多次重复试飞中具有稳定的飞行距离。
### 建议的设计步骤
为了实现上述设计目标，建议的工作步骤和方法如下：
1. 通过查询相关资料，动手制作真实的纸飞机并进行飞行测试，学习和了解物理纸飞机的设计制作方法，从多个维度研究影响纸飞机飞行距离的各种因子，比如折叠纸飞机的类型、空气动力学的影响等相关因子；
2. 按照设计目标的要求，使用 Paper Pilot 模拟器，系统地分析各因子的影响、进行因子水平的优化设计，并验证最佳参数组合的有效性。鼓励使用多种建模方法进行分析，此过程可以循环迭代以达到不断改进的目的；
3. 按照设计目标的要求，做一个简单的说明，使随机选择没有参与过研究此课题的第三方人员，能够独立地按照此标准作业程序书来操作 Paper Pilot 模拟器，多次重复飞行测量飞行距离，评估此过程的波动能否达到最小。
## 自动化操作
由于该试验可能需要大量的重复性的操作，而该操作需要耗费大量的时间但并无太大的实践意义，因此我希望使用`GUI`工具进行实践，构建一个函数，对其输入任意参数的组合[A=a, B=b, C=c, D=d, E=e, F=f]，其能够自动进行参数调整与试飞工作，并返回飞行距离。
### pyautogui
Python提供了一个库`pyautogui`，可以使用之进行基础的鼠标键盘模拟操作，本项目的自动化操作全部基于pyautogui进行。对于pyautogui的基本方法的学习笔记，储存于[pyautogui_study.py](https://github.com/Promileee/Paperplane/blob/main/pyautogui_study.py)。
### 参数设置
参数设置可以分为plane_type设置，weight与elevator设置，winglets三类。

对于plane_type的设置最为简单，拾取'A', 'B', 'C'按钮对应的坐标后直接点击即可。

对于winglets的设置亦很简单，拾取'ON'与'OFF'按钮对应的坐标，参数设置为'ON'时从'OFF'按钮的坐标拖动到'ON'按钮的坐标即可。反之，亦然。

对于weight与elevator的设置稍显复杂，因为这两者的坐标会因为上次试验设置参数的不同而不同，因此无法给定坐标进行`GUI`操作。基于此，我采取了以下的步骤进行：
1. 截取weight与elevator范围的屏幕图像
2. 在该图像内寻找橙色的方块，并按照y坐标排序，y坐标小的方块为weight，y坐标大的方块为elevator。
3. 分别按住两个方块，在方块上方获得现在的数字的坐标
4. 识别现在的参数值，与要设置的值进行对比：若target_para > current_para，将方块向右拖动；反之，向左拖动。
5. 为了更迅速的响应若 $|target\_para - current\_para| \geq 10$，则每次移动18个像素；反之，每次移动1个像素。
6. 重复2到5
在进行测试时发现当 $|target\_para - current\_para|$ 的值过大时，拖拽识别会失效，因此我在这个函数内又增加了一个嵌套调用：如果 $|target\_para - current\_para| > 50$，那么先调整至 $current\_para \pm 50$，再调整至 $target\_para$。
### 试飞操作
试飞操作亦很简单，我们首先给定初始时纸飞机的坐标值[x_init, y_init]，然后根据[angle, force]计算目标坐标值。
$$target\_x = x\_init - force * cos(angle)$$
$$target\_y = x\_init + force * sin(angle)$$
之后从初始坐标拖动至目标坐标，然后松开鼠标即可。
### 试验结果识别
试验结果识别同样基于屏幕截图的识别，给定右下角一个指定的范围，识别RGB=[225, 225, 225]的纯白色内容并制成模板，识别数字即可。

**需要注意的是，识别偶尔会错误，因此我保留了初始的截屏结果，需要手工复核。尽管如此，这也极大节省了人力成本。**
## 试验设计操作与建模分析
本次试验设计我按照如下的思路进行。
### 因子分析
Paper Pilot 模拟器在参数设置界面提供了4个可供调整的参数，分别为：
1. Plane Type， 取值范围为['A', 'B', 'C']；
2. Paper Weight，取值范围为0到100的整数；
3. Elevator，取值范围为0到100的整数；
4. Winglets，取值范围为['ON', 'OFF']；
此外投掷也会影响飞行的距离。对于投掷的参数化，我将其分解为：
5. 投掷角度
6. 投掷力度
即我认为，该试验的因子有[Plane_Type, Paper_weight, Elevator, Winglets, Throw_Angle, Throw_force]这六个因子。
设之为[A, B, C, D, E, F]。
### 2k析因设计
我使用2k析因设计的原则，对[A, B, C, D, E, F]六个因子分别取高水平和低水平，具体如下：
1. [A] : - = 'A', + = 'C'
2. [B] : - = 20, + = 80
3. [C] : - = 20, + = 80
4. [D] : - = 'OFF', + = 'ON'
5. [E] : - = 15, + = 60
6. [F] : - = 40, + = 120
如此我们便构成了一个 $2^{6} = 64$ 的样本空间，使用[pre_experiment.py](https://github.com/Promileee/Paperplane/blob/main/pre_experiment.py)在该样本空间上进行试验，得到的结果保存至[pre_experiment.xlsx](https://github.com/Promileee/Paperplane/blob/main/pre_experiment.xlsx)文件中。

对于该试验结果，我们分析其主效应与交互效应：
$$Effect = \frac{\sum{符号向量 \times 响应值}}{N}$$
由于在本试验中我们采用了`GUI`的操作方式，通过拾取坐标的方式进行试验，从而消除了试验中的不确定性，因此我们的重复次数 $n=1$。 之后计算其对照：
$$ Contrast\_effect = Effect \times n \cdot 2^{k-1}$$
据此我们可以计算各个效应引起的误差平方和以及总误差平方和：
$$SS\_effect = \frac{(Contrast\_effect)^{2}}{n \cdot 2 ^{k}}$$
$$SS_{T} = \sum_{i}\sum_j\sum_k(y_{i,j,k} - \bar{y})^{2}$$
此时有：
$$SS_{T} = \sum_{effect}SS_{effect} + SS_{E}$$
计算得到：
$$SS_{T} = 1365.63359375$$
$$\sum_{effect}{SS_{effect}} = 1365.63359375$$
于是有：
$$SS_{E} = SS_{T} - \sum_{effect}{SS_{effect}} = -9.09494701772928E-13$$
可以看到误差引起的离均平方和的数量级是 $10^{-13}$，几乎可以认为是计算机储存浮点数引起的偏差。这验证了我们认为通过`GUI`操作可以避免波动的推测。之后我们可以计算每种效应在总效应中的贡献值，即
$$Distribution\_rate_{effect} = \frac{SS_{effect}}{SS_{T}} \times 100\%$$
我将计算的结果绘制出来如图所示：

![effect_analysis](/effect_analysis.png "效应分析")

我们拾取贡献率大于 $5\%$ 的效应，如图所示：

![main_effect](/main_effect_analysis.png "主效应分析")
可以看到目前主效应为投掷的角度与力度以及它俩之间的交互，与其他效应的交互并不显著。因此我们密集采点，对投掷角度、投掷力度与飞行距离之间的关系进行试验，结果如图所示：

![angle_and_force_to_score](/contour_plot.png "等高线图")

我们发现小角度大力度的投掷方式能够取得较高的分数。我们取角度为22.5，力度为200的投掷方式为固定的投掷方式，再对其他四个参数进行2k试验分析，实现降维操作。
### 降维后再次析因设计
我使用2k析因设计的原则，对[A, B, C, D]四个因子分别取高水平和低水平，具体如下：
1. [A] : - = 'A', + = 'C'
2. [B] : - = 10, + = 50
3. [C] : - = 10, + = 50
4. [D] : - = 'OFF', + = 'ON'
如此我们便构成了一个 $2^{64} = 16$ 的样本空间，使用[pre_experiment.py](https://github.com/Promileee/Paperplane/blob/main/pre_experiment.py)在该样本空间上进行试验，得到的结果保存至[experiment.xlsx](https://github.com/Promileee/Paperplane/blob/main/experiment_2k.xlsx)文件中。

对于该试验结果，我们分析其主效应与交互效应：
$$Effect = \frac{\sum{符号向量 \times 响应值}}{N}$$
由于在本试验中我们采用了`GUI`的操作方式，通过拾取坐标的方式进行试验，从而消除了试验中的不确定性，因此我们的重复次数 $n=1$。 之后计算其对照：
$$ Contrast\_effect = Effect \times n \cdot 2^{k-1}$$
据此我们可以计算各个效应引起的误差平方和以及总误差平方和：
$$SS\_effect = \frac{(Contrast\_effect)^{2}}{n \cdot 2 ^{k}}$$
$$SS_{T} = \sum_{i}\sum_j\sum_k(y_{i,j,k} - \bar{y})^{2}$$
此时有：
$$SS_{T} = \sum_{effect}SS_{effect} + SS_{E}$$
计算得到：
$$SS_{T} = 2544.829375$$
$$\sum_{effect}{SS_{effect}} = 2544.829375$$
于是有：
$$SS_{E} = SS_{T} - \sum_{effect}{SS_{effect}} = 0$$
可以看到误差引起的离均平方和为0，这再次印证了我们对该种试验方式可以忽略随机波动的影响这一推测。于是我们计算各个效应的贡献率：
$$Distribution\_rate_{effect} = \frac{SS_{effect}}{SS_{T}} \times 100\%$$
我将计算的结果绘制出来如图所示：

![effect_analysis](/effect_analysis_2.png "效应分析")

我们拾取贡献率大于 $2\%$ 的效应，如图所示：

![main_effect](/main_effect_analysis_2.png "主效应分析")

可以看到贡献最大的效应是[B, BD, D, A]，而A与其他效应的交互不显著。
### 密集采点试验
对此，我们对[A, B, C, D]进行密集采点试验。
1. [A] = ['A', 'B', 'C']
2. [B] = [20, 25, 30, 35, 40, 45, 50]
3. [C] = [20, 25, 30, 35]
4. [D] : ['ON', 'OFF']
试验结果储存于[experiment_3.xlsx](https://github.com/Promileee/Paperplane/blob/main/experiment_3.xlsx)

我们计算对A不同取值时飞机的飞行距离如下：
$$\bar{Score}_{type=A} = \frac{\sum_{type=A}{score}}{num\_type=A}=10.25942$$
$$\bar{Score}_{type=B} = \frac{\sum_{type=B}{score}}{num\_type=B}=7.25271$$
$$\bar{Score}_{type=C} = \frac{\sum_{type=C}{score}}{num\_type=C}=14.03751$$
显然，C飞机的飞行距离显著大于A和B。

之后，我们对C的试验结果进行最大值提取，发现当参数置于[A='C', B=30, C=25, D='ON']到[A='C', B=45, C=35, D='ON']时，试验分数达到显著的最大值。我们推测最优参数出现在这一区间，对这个区间进行密集取点试验。
### 最优参数寻找
对此，我们对[A, B, C, D]进行密集采点试验。
1. [A] = ['C']
2. [B] = 30 到 45 的所有整数
3. [C] = 25 到 35 的所有整数
4. [D] : ['ON']
试验结果储存于[experiment_4.xlsx](https://github.com/Promileee/Paperplane/blob/main/experiment_4.xlsx)。

我们将试验结果绘制出来如图所示：

![EF](/contour_plot_2.png)

最终，我们得到，在参数[A='C', B=37, C=30, D='ON', E=22.5, F=200]时，飞行距离达到最大，为48.2m。

![highest_score](/highest_score.png "最大距离")
