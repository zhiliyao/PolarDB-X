set -eux

echo "Make sure you have already run make successfully"

build_path=$(pwd)/build

rm -rf tmp && mkdir -p tmp
mv build/run tmp/run
cp -f entrypoint.sh tmp/
cp -f Dockerfile tmp/
cd tmp/
sudo docker build -t all-in-one --network host . -f Dockerfile --build-arg BUILD_PATH="$build_path"
cd .. && mv tmp/run build/run && rm -rf tmp
