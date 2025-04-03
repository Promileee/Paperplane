import torch
import torch.nn as nn
import torch.optim as optim
from torch.distributions import Normal
import pyautogui
import cv2
import numpy as np
import pytesseract
from PIL import Image
import time
import os

pytesseract.pytesseract.tesseract_cmd = r'D:\Program Files\tesseract\tesseract.exe'

DETECTION_REGION = {
    'left': 410,
    'top': 686,
    'width': 978 - 410,
    'height': 1037 - 686
}


def capture_screen():
    region = (
        DETECTION_REGION['left'],
        DETECTION_REGION['top'],
        DETECTION_REGION['width'],
        DETECTION_REGION['height']
    )
    return cv2.cvtColor(np.array(pyautogui.screenshot(region=region)), cv2.COLOR_RGB2BGR)


def find_orange_blocks(image):
    hsv = cv2.cvtColor(image, cv2.COLOR_BGR2HSV)
    lower_orange = np.array([10, 100, 100])
    upper_orange = np.array([25, 255, 255])
    mask = cv2.inRange(hsv, lower_orange, upper_orange)

    contours, _ = cv2.findContours(mask, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    contours = [cnt for cnt in contours if 200 < cv2.contourArea(cnt) < 10000]
    contours = sorted(contours, key=lambda cnt: (cv2.boundingRect(cnt)[1], cv2.boundingRect(cnt)[0]))  # 按Y/X排序

    blocks = []
    for cnt in contours[:2]:
        x, y, w, h = cv2.boundingRect(cnt)
        blocks.append((x, y, w, h))
    return blocks


def ocr_number(full_screen_image, block):
    x, y, w, h = block
    global_x = x + DETECTION_REGION['left']
    global_y = y + DETECTION_REGION['top']

    left = global_x - 5
    upper = max(0, global_y - h - 12)
    right = global_x + w
    lower = global_y

    number_region = full_screen_image.crop((left, upper, right, lower))
    number_region = number_region.convert('L')
    img_array = np.array(number_region)
    _, binary = cv2.threshold(img_array, 90, 255, cv2.THRESH_BINARY_INV)

    kernel = np.ones((1, 1), np.uint8)
    binary = cv2.dilate(binary, kernel, iterations=1)
    binary = cv2.erode(binary, kernel, iterations=1)
    binary_pil = Image.fromarray(binary)

    # 保存调试图像（用于OCR调试）
    #binary_pil = Image.fromarray(binary)
    #binary_pil.save(f"debug_ocr_{int(time.time())}.png")

    text = pytesseract.image_to_string(
        binary_pil,
        config='--psm 10 --oem 3 -c tessedit_char_whitelist=0123456789'
    )
    return int(text.strip()) if text.strip().isdigit() else 0


def drag_and_adjust(target_value, initial_block_coords):
    x, y, w, h = initial_block_coords
    global_x = x + DETECTION_REGION['left'] + w // 2
    global_y = y + DETECTION_REGION['top'] + h // 2

    pyautogui.moveTo(global_x, global_y, duration=0.1)
    #pyautogui.moveTo(global_x, global_y)
    pyautogui.mouseDown(button='left')

    step = 1
    direction = 1

    while True:
        #pyautogui.moveRel(direction * step, 0, duration=0.1)
        pyautogui.moveRel(direction * step, 0,duration=0.1)
        #time.sleep(0.1)

        current_screen_area = capture_screen()
        current_blocks = find_orange_blocks(current_screen_area)
        current_block = find_closest_block(initial_block_coords, current_blocks)

        if not current_block:
            #print("未检测到方块，停止拖拽")
            break

        current_number = ocr_number(pyautogui.screenshot(), current_block)
        #print(f"当前数值：{current_number}，目标：{target_value}")
        if -10 < current_number - target_value < 10:
            step = 1
        else:
            step = 18

        if current_number == target_value:
            break
        elif (current_number > target_value) and (direction == 1) or \
                (current_number < target_value and direction == -1):
            direction *= -1
        else:
            pass

    pyautogui.mouseUp(button='left')


def find_closest_block(initial_block, blocks):
    if not blocks:
        return None
    initial_x, initial_y, _, _ = initial_block
    min_distance = float('inf')
    closest_block = None
    for block in blocks:
        x, y, w, h = block
        distance = ((x - initial_x) ** 2 + (y - initial_y) ** 2) ** 0.5
        if distance < min_distance:
            min_distance = distance
            closest_block = block
    return closest_block


def get_block_number(block):
    x, y, w, h = block
    global_x = DETECTION_REGION['left'] + x + w // 2
    global_y = DETECTION_REGION['top'] + y + h // 2

    #pyautogui.moveTo(global_x, global_y, duration=0.1)
    pyautogui.moveTo(global_x, global_y)
    pyautogui.mouseDown(button='left')
    current_screen = pyautogui.screenshot()
    number = ocr_number(current_screen, block)
    pyautogui.mouseUp(button='left')
    return number


def weight_and_elevator(target_values=[25,25]):
    #target_values = [50, 75]  # 目标数值

    while True:
        detection_area = capture_screen()
        blocks = find_orange_blocks(detection_area)

        if len(blocks) != 2:
            #print("未检测到两个方块，重新检测...")
            continue

        block1, block2 = blocks  # 按Y排序后的结果

        current_number1 = get_block_number(block1)
        current_number2 = get_block_number(block2)
        #print(f"当前数值：Block1={current_number1}, Block2={current_number2}")



        if current_number1 == target_values[0] and current_number2 == target_values[1]:
            #print("已达到目标值，完成！")
            break

        if current_number1-target_values[0]<-50:
            drag_and_adjust(target_values[0]-50, block1)
        elif current_number1-target_values[0]>50:
            drag_and_adjust(target_values[0]+50, block1)
        else:
            drag_and_adjust(target_values[0], block1)
        if current_number2-target_values[1]<-50:
            drag_and_adjust(target_values[1]-50, block2)
        elif current_number2-target_values[1]>50:
            drag_and_adjust(target_values[1]+50,block2)
        else:
            drag_and_adjust(target_values[1], block2)

def game_start():
    pyautogui.click(1304, 1153)
    time.sleep(1.2)

def plane_type(target_plane):
    if target_plane == 'A':
        pyautogui.moveTo(494,598)
        pyautogui.click(494, 598)
    elif target_plane == 'B':
        pyautogui.moveTo(666,598)
        pyautogui.click(666, 598)
    else:
        pyautogui.moveTo(847,598)
        pyautogui.click(847,598)

def winglets(target_wins):
    if target_wins == 'ON':
        pyautogui.moveTo(552,1158)
        pyautogui.dragTo(825,1158,duration=0.2)
    else:
        pyautogui.moveTo(825,1158)
        pyautogui.dragTo(552,1158,duration=0.2)

def para(target_para=['A',75,50,'ON']):
    target_plane = target_para[0]
    target_value = target_para[1:3]
    target_wins = target_para[3]
    plane_type(target_plane)
    weight_and_elevator(target_value)
    winglets(target_wins)


def practice():
    pyautogui.click(1841,936)

def throw(target_position=[715,907]):
    x = target_position[0]
    y = target_position[1]
    pyautogui.moveTo(818,882)
    pyautogui.dragTo(x,y,duration=0.2)

def play_again():
    pyautogui.click(1249,724)
    time.sleep(1.2)

def score():
    time.sleep(5)
    """
    在指定范围内（2009, 1164 到 2100, 1195）采集白色数字并识别。

    返回:
        int: 识别到的数字。如果无法识别，则返回 None。
    """
    # 定义检测区域
    detection_region = {
        'left': 1980,
        'top': 1150,
        'width': 2200 - 1980,
        'height': 1300 - 1225
    }

    # 截取屏幕指定区域
    region = (
        detection_region['left'],
        detection_region['top'],
        detection_region['width'],
        detection_region['height']
    )
    screenshot = pyautogui.screenshot(region=region)
    screenshot = cv2.cvtColor(np.array(screenshot), cv2.COLOR_RGB2BGR)

    # 转换为灰度图像
    gray = cv2.cvtColor(screenshot, cv2.COLOR_BGR2GRAY)

    # 创建白色掩码（RGB 值为 255, 255, 255）
    lower_white = np.array([254, 254, 254])
    upper_white = np.array([255, 255, 255])
    mask = cv2.inRange(screenshot, lower_white, upper_white)

    # 应用掩码提取白色区域
    white_only = cv2.bitwise_and(gray, gray, mask=mask)

    # 对白色区域进行二值化处理
    _, binary = cv2.threshold(white_only, 200, 255, cv2.THRESH_BINARY)

    # 形态学操作：去噪和增强数字边界
    kernel = np.ones((2, 2), np.uint8)
    binary = cv2.dilate(binary, kernel, iterations=1)
    binary = cv2.erode(binary, kernel, iterations=1)

    # 将处理后的图像转换为 PIL 图像
    binary_pil = Image.fromarray(binary)

    # 保存调试图像（用于OCR调试）
    #binary_pil.save(f"debug_ocr_{int(time.time())}.png")

    # 使用 Tesseract 进行 OCR 识别
    try:
        text = pytesseract.image_to_string(
            binary_pil,
            config='--psm 7 --oem 3 -c tessedit_char_whitelist=0123456789'
        ).strip()
        if text.isdigit():  # 确保识别结果是数字
            #print(int(text))
            return float(text) * 0.1
        else:
            #print("OCR 识别结果非数字:", text)
            return None
    except Exception as e:
        #print("OCR 识别失败:", e)
        return None

def set_para():
    pyautogui.moveTo(430,1290)
    pyautogui.click(430,1290)

def experiment(target_para, target_position):
    """
    在打开游戏参数设置界面后执行投掷操作并返回得分
    :param target_para:
    :param target_position:
    :return:
    """
    #target_para = ['B', 50, 37, 'ON']
    para(target_para)
    practice()
    #target_position = [610,970]
    throw(target_position)
    ex_score = score()
    return(ex_score)


# 定义Actor网络
class Actor(nn.Module):
    def __init__(self, state_dim, action_dim):
        super(Actor, self).__init__()
        self.fc1 = nn.Linear(state_dim, 64)
        self.fc2 = nn.Linear(64, 64)
        self.mean_layer = nn.Linear(64, action_dim)
        self.log_std_layer = nn.Linear(64, action_dim)
        self.action_dim = action_dim

    def forward(self, state):
        x = torch.relu(self.fc1(state))
        x = torch.relu(self.fc2(x))
        raw_mean = self.mean_layer(x)
        raw_log_std = self.log_std_layer(x)

        # 缩放每个动作维度到对应的范围
        means = []
        log_stds = []
        for i in range(self.action_dim):
            if i == 0:  # 第一个参数（0-2）
                mean_val = torch.sigmoid(raw_mean[i]) * 2
                log_std_val = raw_log_std[i]
            elif i == 1 or i == 2:  # 第二、三个参数（0-100）
                mean_val = torch.sigmoid(raw_mean[i]) * 100
                log_std_val = raw_log_std[i]
            elif i == 3:  # 第四个参数（0-1）
                mean_val = torch.sigmoid(raw_mean[i]) * 1
                log_std_val = raw_log_std[i]
            elif i == 4:  # 第五个参数x（566-1203）
                delta_x = 880 - 570
                mean_val = torch.sigmoid(raw_mean[i]) * delta_x + 570
                log_std_val = raw_log_std[i]
            elif i == 5:  # 第五个参数y（708-1207）
                delta_y = 992 - 800
                mean_val = torch.sigmoid(raw_mean[i]) * delta_y + 800
                log_std_val = raw_log_std[i]
            means.append(mean_val)
            log_stds.append(log_std_val)

        mean = torch.stack(means)
        log_std = torch.stack(log_stds)
        log_std = torch.clamp(log_std, -20, 2)
        return mean, log_std

    def sample_action(self, state):
        mean, log_std = self(state)
        std = log_std.exp()
        normal = Normal(mean, std)
        action = normal.rsample()  # 重参数化采样
        log_prob = normal.log_prob(action).sum(-1)
        return action, log_prob


# 环境类
class Environment:
    def __init__(self):
        pass

    def reset(self):
        return np.array([0.0])

    def step(self, action):
        action = action.detach().numpy()
        p1 = action[0]
        p2 = action[1]
        p3 = action[2]
        p4 = action[3]
        x = action[4]
        y = action[5]

        # 转换为实际参数
        p1_int = int(round(p1))
        p1_int = np.clip(p1_int, 0, 2)
        p1_str = 'A' if p1_int == 0 else 'B' if p1_int == 1 else 'C'

        p4_int = int(round(p4))
        p4_int = np.clip(p4_int, 0, 1)
        p4_str = 'ON' if p4_int == 0 else 'OFF'

        p2_int = int(round(p2))
        p2_int = np.clip(p2_int, 0, 100)
        p3_int = int(round(p3))
        p3_int = np.clip(p3_int, 0, 100)

        x_int = int(round(x))
        x_int = np.clip(x_int, 570, 880)
        y_int = int(round(y))
        y_int = np.clip(y_int, 800, 992)
        coord = [x_int, y_int]

        # 调用operate函数获取奖励（替换为实际函数）
        reward = self.operate(p1_str, p2_int, p3_int, p4_str, coord)
        return np.array([0.0]), reward, True, {}

    def operate(self, p1, p2, p3, p4, coord):
        # 示例奖励函数，实际应替换为真实函数
        set_para()
        time.sleep(0.5)
        target_para = [p1, p2, p3, p4]
        target_position = coord
        score = experiment(target_para, target_position)
        return score


def main():
    time.sleep(3)
    game_start()
    time.sleep(0.5)

    env = Environment()
    state_dim = 1
    action_dim = 6
    actor = Actor(state_dim, action_dim)
    optimizer = optim.Adam(actor.parameters(), lr=0.001)
    num_episodes = 10000

    # 模型保存路径和初始化变量
    checkpoint_path = 'training_checkpoint.pth'
    start_episode = 0

    # 尝试加载检查点
    try:
        checkpoint = torch.load(checkpoint_path)
        actor.load_state_dict(checkpoint['actor_state_dict'])
        optimizer.load_state_dict(checkpoint['optimizer_state_dict'])
        start_episode = checkpoint['episode'] + 1
        print(f"Loaded checkpoint, resuming from episode {start_episode}")
    except FileNotFoundError:
        print("No checkpoint found, starting fresh")
    except Exception as e:
        print(f"Error loading checkpoint: {e}, starting fresh")

    for episode in range(start_episode, num_episodes):
        state = env.reset()
        state_tensor = torch.from_numpy(state).float()
        action, log_prob = actor.sample_action(state_tensor)

        # 参数解码部分
        with torch.no_grad():
            action_np = action.detach().numpy()
            # 参数转换逻辑
            p1 = int(np.clip(round(action_np[0]), 0, 2))  # 飞机类型 0:A,1:B,2:C
            p2 = int(np.clip(round(action_np[1]), 0, 100))  # 参数2
            p3 = int(np.clip(round(action_np[2]), 0, 100))  # 参数3
            p4 = 'ON' if int(np.clip(round(action_np[3]), 0, 1)) == 0 else 'OFF'  # 翼梢小翼
            x = int(np.clip(round(action_np[4]), 566, 1203))  # X坐标
            y = int(np.clip(round(action_np[5]), 708, 1207))  # Y坐标

        _, reward, _, _ = env.step(action)
        reward = torch.tensor([reward], dtype=torch.float32)

        # 计算损失并更新策略
        loss = -log_prob * reward
        optimizer.zero_grad()
        loss.backward()
        optimizer.step()

        if episode % 3 == 0:
            # 带参数显示的打印输出
            print(f"Episode {episode:4d} | Reward: {reward.item():6.2f} | "
                  f"Params: Plane={['A', 'B', 'C'][p1]} | "
                  f"P2={p2:3d} | P3={p3:3d} | Wing={p4:3} | "
                  f"Pos=({x:4d},{y:4d})")

        # 保存检查点
        torch.save({
            'episode': episode,
            'actor_state_dict': actor.state_dict(),
            'optimizer_state_dict': optimizer.state_dict(),
        }, checkpoint_path)

    # 训练完成清理
    if os.path.exists(checkpoint_path):
        os.remove(checkpoint_path)
        print("Training completed, checkpoint removed")


if __name__ == '__main__':
    main()