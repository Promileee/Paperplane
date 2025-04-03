import pyautogui, time

# 获取屏幕大小
wh = pyautogui.size()
print(wh)

# 移动鼠标
'''
for i in range(10):
    pyautogui.moveTo(100,100,duration=0.25)
    pyautogui.moveTo(200,100,duration=0.25)
    pyautogui.moveTo(200,200,duration=0.25)
    pyautogui.moveTo(100,200,duration=0.25)
'''

# 移动鼠标
'''
for i in range(10):
    pyautogui.move(100,0,duration=0.25)
    pyautogui.move(0,100,duration=0.25)
    pyautogui.move(-100,0,duration=0.25)
    pyautogui.move(0,-100,duration=0.25)
'''

# 获取鼠标的位置
print(pyautogui.position())

#单击鼠标
'''
pyautogui.click(89,29,button='left')
'''
'''
click() 事实上是 mouseDown() 与 mouseUp() 两个函数的封装
除 click 外，还可
doubleClick()
rightClick()
middleClick()
'''

# 拖动鼠标
'''
pyautogui 提供了 dragTo() 和 drag() 两个函数
'''

'''
time.sleep(5)

pyautogui.click()
distance = 900
change = 20
while distance > 0:
    pyautogui.drag(distance,0,duration=0.2)
    distance = distance - change
    pyautogui.drag(0,distance,duration=0.2)
    pyautogui.drag(-distance,0,duration=0.2)
    distance = distance - change
    pyautogui.drag(0,-distance,duration=0.2)
'''

# 滚动鼠标
'''
pyautogui.scroll(2000)
'''

# 规划鼠标运动
pyautogui.mouseInfo()