import os
import shutil
import random

os.makedirs('datasets/celeba-hq-dataset/data256x256', exist_ok=True)
os.makedirs('datasets/celeba-hq-dataset/train_256', exist_ok=True)
os.makedirs('datasets/celeba-hq-dataset/val_source_256', exist_ok=True)
os.makedirs('datasets/celeba-hq-dataset/visual_test_source_256', exist_ok=True)

data_dir = '/kaggle/input/celeba-256x256-30k/celeba_hq_256/'
dest_dir = '/kaggle/working/FcF-Inpainting/datasets/celeba-hq-dataset/data256x256/'

# Ensure the destination directory exists
os.makedirs(dest_dir, exist_ok=True)

for i in range(30000):
    src = os.path.join(data_dir, f'{i:05}.jpg') #Pad the number with leading zeros.Ensure the total length of the formatted number is 5 characters.
    dst = os.path.join(dest_dir, f'{i}.jpg')
    #print(os.path.exists(src))  # Debug print statement
    if os.path.exists(src):
        shutil.copy(src, dst)
# Read the shuffled list
with open('tools/train_shuffled.flist', 'r') as f:
    files = f.readlines()

# Shuffle and split the list
random.shuffle(files)
with open('datasets/celeba-hq-dataset/temp_train_shuffled.flist', 'w') as f:
    f.writelines(files)

with open('datasets/celeba-hq-dataset/val_shuffled.flist', 'w') as f:
    f.writelines(files[:2000])

with open('datasets/celeba-hq-dataset/train_shuffled.flist', 'w') as f:
    f.writelines(files[2000:])

# Copy val_shuffled.flist to visual_test_shuffled.flist
with open('tools/val_shuffled.flist', 'r') as f:
    val_files = f.readlines()
with open('datasets/celeba-hq-dataset/visual_test_shuffled.flist', 'w') as f:
    f.writelines(val_files)

    
def move_files(flist_path, dest_dir):
    with open(flist_path, 'r') as f:
        files = f.readlines()
    for file in files:
        file = file.strip()
        src = os.path.join(data_dir, file)
        dst = os.path.join(dest_dir, file)
        if os.path.exists(src):
            shutil.copy(src, dst)

move_files('datasets/celeba-hq-dataset/train_shuffled.flist', 'datasets/celeba-hq-dataset/train_256')
move_files('datasets/celeba-hq-dataset/val_shuffled.flist', 'datasets/celeba-hq-dataset/val_source_256')
move_files('datasets/celeba-hq-dataset/visual_test_shuffled.flist', 'datasets/celeba-hq-dataset/visual_test_source_256')