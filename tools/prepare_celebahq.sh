mkdir -p datasets/celeba-hq-dataset
mkdir -p datasets/temp

unzip datasets/data256x256.zip -d datasets/celeba-hq-dataset/

echo "Preparing Files..."
# Reindex

for i in `echo {00000..00029}`
do
    mv 'datasets/celeba-hq-dataset/data256x256/'$i'.jpg' 'datasets/celeba-hq-dataset/data256x256/'$[10#$i]'.jpg'
done

echo "Preparing Splits..."
# Split: split train -> train & val
cat tools/train_shuffled.flist | shuf > datasets/celeba-hq-dataset/temp_train_shuffled.flist
cat datasets/celeba-hq-dataset/temp_train_shuffled.flist | head -n 5 > datasets/celeba-hq-dataset/val_shuffled.flist
cat datasets/celeba-hq-dataset/temp_train_shuffled.flist | tail -n +6 > datasets/celeba-hq-dataset/train_shuffled.flist
cat tools/val_shuffled.flist > datasets/celeba-hq-dataset/visual_test_shuffled.flist

mkdir datasets/celeba-hq-dataset/train_256/
mkdir datasets/celeba-hq-dataset/val_source_256/
mkdir datasets/celeba-hq-dataset/visual_test_source_256/

cat datasets/celeba-hq-dataset/train_shuffled.flist | xargs -I {} mv datasets/celeba-hq-dataset/data256x256/{} datasets/celeba-hq-dataset/train_256/
cat datasets/celeba-hq-dataset/val_shuffled.flist | xargs -I {} mv datasets/celeba-hq-dataset/data256x256/{} datasets/celeba-hq-dataset/val_source_256/
cat datasets/celeba-hq-dataset/visual_test_shuffled.flist | xargs -I {} mv datasets/celeba-hq-dataset/data256x256/{} datasets/celeba-hq-dataset/visual_test_source_256/