# Paper Airplane Experiment - A Course Project on Experimental Design  
This repository is used to share some of the work I did while completing a course project for the Experimental Design course. Adhering to the principle of "Don't reinvent the wheel," I am sharing all the source code I used for this project, hoping to reduce the workload for future researchers.  
**Attention:[中文README点击这里](https://github.com/Promileee/Paperplane/blob/main/README-cn.md)**
## Project Introduction  
### Introduction to Paper Airplanes  
A paper airplane (scientific name: self-powered aerodynamic physical model) is a toy airplane made of paper. It is the most common form of origami in aviation and belongs to a branch of paper folding. Because paper airplanes are the easiest type of origami to master, they are beloved by beginners and experts alike.  

Depending on the goals, people design different types of paper airplanes. For example, gliders aim for the longest hang time. The current world record for the longest hang time is 27.9 seconds, achieved by a paper airplane made from a single sheet of paper without using any glue or scissors. Distance planes aim for the longest flight distance, with the current world record being 69.14 meters. There are also simulation or biomimetic planes that focus on realistic appearance, mimicking real aircraft or various organisms to achieve stable gliding performance.  

### Course Project Introduction  
In this course project, to make the design process, flight environment, and evaluation methods more objective, the course uses paper airplanes and a flight simulator [Paper Pilot](https://github.com/Promileee/Paperplane/blob/main/paperpilot.swf) to complete the airplane design and obtain flight data. The Paper Pilot simulator is provided as a Flash file and can be run using a browser with Flash support or a Flash player.  

### Parameter Settings for Paper Airplanes  
![Paper Airplane Parameter Settings Interface](/parameters_setting.png "Paper Airplane Parameter Settings Interface")  
As shown in the figure, this is the parameter settings interface for the paper airplane design and flight simulator. The simulator provides four parameters: Plane Type, Paper Weight, Elevator, and Winglets. After setting the parameters, click the `Practice` button on the right to enter the test flight interface.  

### Test Flight of Paper Airplanes  
![Paper Airplane Test Flight Interface](/test_flight.png "Paper Airplane Test Flight Interface")  
As shown in the figure, this is the test flight interface of the paper airplane design and flight simulator. Drag the airplane with the mouse to adjust its initial attitude, then release the mouse to start the simulated flight. The system will automatically simulate the flight trajectory and display the flight distance in real-time at the bottom right.  

### Design Objectives  
The goal of this course project is to use the Paper Pilot simulator to design and simulate paper airplanes, achieving the longest possible flight distance with stability. Specifically, the project has two objectives:  
1. Maximize the flight distance;  
2. Ensure stable flight distances across multiple repeated test flights.  

### Suggested Design Steps  
To achieve the above objectives, the recommended steps and methods are as follows:  
1. Research relevant materials, create real paper airplanes, and conduct flight tests to learn and understand the design and construction methods of physical paper airplanes. Study various factors affecting flight distance, such as airplane type and aerodynamics.  
2. Use the Paper Pilot simulator to systematically analyze the impact of each factor, optimize factor levels, and validate the effectiveness of the best parameter combinations. Multiple modeling methods are encouraged, and this process can be iterative for continuous improvement.  
3. Create a simple instruction manual so that a third party unfamiliar with the project can independently operate the Paper Pilot simulator, repeatedly measure flight distances, and evaluate whether the process achieves minimal variability.  

## Automated Operations  
Since this experiment may require a large number of repetitive operations, which are time-consuming but not practically meaningful, I aimed to use a `GUI` tool to automate the process. A function was constructed to input any parameter combination [A=a, B=b, C=c, D=d, E=e, F=f], automatically adjust parameters, conduct test flights, and return the flight distance.  

### pyautogui  
Python provides a library called `pyautogui` for simulating basic mouse and keyboard operations. All automated operations in this project are based on pyautogui. Study notes on the basic methods of pyautogui are stored in [pyautogui_study.py](https://github.com/Promileee/Paperplane/blob/main/pyautogui_study.py).  

### Parameter Settings  
Parameter settings can be divided into three categories: plane_type, weight and elevator, and winglets.  

- **Plane_type**: The simplest to set. After obtaining the coordinates of the 'A', 'B', and 'C' buttons, click directly.  
- **Winglets**: Also straightforward. Obtain the coordinates of the 'ON' and 'OFF' buttons. Drag from 'OFF' to 'ON' if the parameter is 'ON', and vice versa.  
- **Weight and Elevator**: Slightly more complex because their coordinates vary depending on previous settings. The following steps were taken:  
  1. Capture screen images of the weight and elevator ranges.  
  2. Locate the orange squares in the image and sort them by y-coordinate (the smaller y-coordinate is weight, the larger is elevator).  
  3. Hold the squares and obtain the coordinates of the current numbers above them.  
  4. Compare the current parameter values with the target values: if target_para > current_para, drag the square right; otherwise, drag left.  
  5. For faster response, if $|target\_para - current\_para| \geq 10$, move 18 pixels per step; otherwise, move 1 pixel.  
  6. Repeat steps 2 to 5.  
  Testing revealed that drag recognition fails when $|target\_para - current\_para|$ is too large. Thus, a nested function was added: if $|target\_para - current\_para| > 50$, first adjust to $current\_para \pm 50$, then to $target\_para$.  

### Test Flight Operations  
Test flight operations are also simple. First, the initial coordinates of the paper airplane [x_init, y_init] are given, and the target coordinates are calculated based on [angle, force]:  
$$target\_x = x\_init - force * cos(angle)$$  
$$target\_y = x\_init + force * sin(angle)$$  
Then, drag from the initial coordinates to the target coordinates and release the mouse.  

### Experimental Result Recognition  
Result recognition is also based on screen capture. A specified area at the bottom right is captured, and pure white content (RGB=[225, 225, 225]) is identified and templated to recognize numbers.  

**Note: Recognition may occasionally fail, so the original screenshots are retained for manual verification. Despite this, it significantly reduces labor costs.**  

## Experimental Design and Modeling Analysis  
The experimental design followed the approach below.  

### Factor Analysis  
The Paper Pilot simulator provides four adjustable parameters in the settings interface:  
1. Plane Type: ['A', 'B', 'C']  
2. Paper Weight: Integers from 0 to 100  
3. Elevator: Integers from 0 to 100  
4. Winglets: ['ON', 'OFF']  
Additionally, throwing affects flight distance. The throwing parameters are decomposed into:  
5. Throw Angle  
6. Throw Force  
Thus, the factors for this experiment are [Plane_Type, Paper_weight, Elevator, Winglets, Throw_Angle, Throw_force], labeled [A, B, C, D, E, F].  

### 2k Factorial Design  
Using the principles of 2k factorial design, high and low levels were set for each of the six factors [A, B, C, D, E, F]:  
1. [A]: - = 'A', + = 'C'  
2. [B]: - = 20, + = 80  
3. [C]: - = 20, + = 80  
4. [D]: - = 'OFF', + = 'ON'  
5. [E]: - = 15, + = 60  
6. [F]: - = 40, + = 120  
This created a sample space of $2^{6} = 64$. [pre_experiment.py](https://github.com/Promileee/Paperplane/blob/main/pre_experiment.py) was used to conduct tests in this space, with results saved in [pre_experiment.xlsx](https://github.com/Promileee/Paperplane/blob/main/pre_experiment.xlsx).  

Main and interaction effects were analyzed:  
$$Effect = \frac{\sum{sign\_vector \times response}}{N}$$  
Since GUI operations eliminated uncertainty, the number of replicates $n=1$. The contrast was calculated:  
$$ Contrast\_effect = Effect \times n \cdot 2^{k-1}$$  
The sum of squares (SS) for each effect and total SS were calculated:  
$$SS\_effect = \frac{(Contrast\_effect)^{2}}{n \cdot 2 ^{k}}$$  
$$SS_{T} = \sum_{i}\sum_j\sum_k(y_{i,j,k} - \bar{y})^{2}$$  
Thus:  
$$SS_{T} = \sum_{effect}SS_{effect} + SS_{E}$$  
Calculations yielded:  
$$SS_{T} = 1365.63359375$$  
$$\sum_{effect}{SS_{effect}} = 1365.63359375$$  
Thus:  
$$SS_{E} = SS_{T} - \sum_{effect}{SS_{effect}} = -9.09494701772928E-13$$  
The error SS was negligible ($10^{-13}$), confirming that GUI operations minimized variability. The contribution rate of each effect was calculated:  
$$Distribution\_rate_{effect} = \frac{SS_{effect}}{SS_{T}} \times 100\%$$  
The results are visualized here:  

![effect_analysis](/effect_analysis.png "Effect Analysis")  

Effects with contribution rates > 5% were selected:  

![main_effect](/main_effect_analysis.png "Main Effect Analysis")  
The main effects were throw angle, throw force, and their interaction. Other interactions were insignificant. Dense sampling was conducted for throw angle, force, and flight distance:  

![angle_and_force_to_score](/contour_plot.png "Contour Plot")  
High scores were achieved with small angles and high force. A fixed throwing method (angle=22.5, force=200) was adopted, and the other four parameters were analyzed using 2k factorial design for dimensionality reduction.  

### Reduced-Dimensional Factorial Design  
For [A, B, C, D], high and low levels were set as:  
1. [A]: - = 'A', + = 'C'  
2. [B]: - = 10, + = 50  
3. [C]: - = 10, + = 50  
4. [D]: - = 'OFF', + = 'ON'  
This created a sample space of $2^{4} = 16$. Tests were conducted using [pre_experiment.py](https://github.com/Promileee/Paperplane/blob/main/pre_experiment.py), with results saved in [experiment_2k.xlsx](https://github.com/Promileee/Paperplane/blob/main/experiment_2k.xlsx).  

Main and interaction effects were analyzed similarly. The error SS was 0, confirming minimal variability. Contribution rates were calculated:  
$$Distribution\_rate_{effect} = \frac{SS_{effect}}{SS_{T}} \times 100\%$$  
Results are visualized here:  

![effect_analysis](/effect_analysis_2.png "Effect Analysis")  

Effects with contribution rates > 2% were selected:  

![main_effect](/main_effect_analysis_2.png "Main Effect Analysis")  
The most significant effects were [B, BD, D, A], with A's interactions being insignificant.  

### Dense Sampling Test  
Dense sampling was conducted for [A, B, C, D]:  
1. [A] = ['A', 'B', 'C']  
2. [B] = [20, 25, 30, 35, 40, 45, 50]  
3. [C] = [20, 25, 30, 35]  
4. [D] = ['ON', 'OFF']  
Results were saved in [experiment_3.xlsx](https://github.com/Promileee/Paperplane/blob/main/experiment_3.xlsx).  

Average flight distances for each plane type:  
$$\bar{Score}_{type=A} = \frac{\sum_{type=A}{score}}{num\_type=A}=10.25942$$  
$$\bar{Score}_{type=B} = \frac{\sum_{type=B}{score}}{num\_type=B}=7.25271$$  
$$\bar{Score}_{type=C} = \frac{\sum_{type=C}{score}}{num\_type=C}=14.03751$$  
Type C performed significantly better.  

For type C, the highest scores occurred in the range [A='C', B=30, C=25, D='ON'] to [A='C', B=45, C=35, D='ON']. Dense sampling was conducted in this range.  

### Optimal Parameter Search  
Dense sampling for [A, B, C, D]:  
1. [A] = ['C']  
2. [B] = All integers from 30 to 45  
3. [C] = All integers from 25 to 35  
4. [D] = ['ON']  
Results were saved in [experiment_4.xlsx](https://github.com/Promileee/Paperplane/blob/main/experiment_4.xlsx).  

The results are visualized here:  

![EF](/contour_plot_2.png)  

The maximum flight distance of 48.2m was achieved with [A='C', B=37, C=30, D='ON', E=22.5, F=200].  

![highest_score](/highest_score.png "Maximum Distance")  