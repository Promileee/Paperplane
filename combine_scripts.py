import os
from chardet import detect


def extract_as_files_to_txt(source_dir, output_file):
    if not os.path.exists(source_dir):
        print(f"错误：路径 {source_dir} 不存在！")
        return

    with open(output_file, 'w', encoding='utf-8') as out_file:
        file_count = 0
        for root, dirs, files in os.walk(source_dir):
            for file in files:
                if file.endswith('.as'):
                    file_path = os.path.join(root, file)
                    print(f"处理中: {file_path}")  # 调试信息
                    try:
                        with open(file_path, 'rb') as in_file:
                            raw_data = in_file.read()
                            encoding = detect(raw_data)['encoding'] or 'utf-8'
                        content = raw_data.decode(encoding)

                        out_file.write(f'// ==== File: {file_path} ====\n')
                        out_file.write(content + '\n\n')
                        file_count += 1
                    except Exception as e:
                        print(f"处理失败: {file_path} - {str(e)}")

        print(f"共合并 {file_count} 个文件")


if __name__ == "__main__":
    script_directory = r'C:\Users\Promile\PycharmProjects\Paper_pilot\scripts'  # 改为你的绝对路径
    output_filename = 'combined.txt'

    extract_as_files_to_txt(script_directory, output_filename)
    print("合并完成！")