import pyautogui, time
time.sleep(5)

first_time = True
conti = True
plane_type = 0

def game_start():
    pyautogui.click(1304, 1153)

def para_1(plane_type):
    if plane_type == 'A':
        pyautogui.click(494, 598)
    elif plane_type == 'B':
        pyautogui.click(666, 599)
    else:
        pyautogui.click(847,603)

#def para_2(paper_weight):



#def parameter(plane_type, paper_weight, elevators, winglets):

def main():
    game_start()
    time.sleep(1)
    para_1('B')

main()