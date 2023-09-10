set -e
set -x

# https://book.orthanc-server.com/plugins/indexer.html

# libboost-all-dev can be removed in the future (maybe)
apt-get -q install -y git mercurial cmake make g++ patch unzip libcurl-dev libboost-all-dev

git clone https://github.com/CGDogan/orthanc-indexer --branch=rewrite

cd orthanc-indexer
mkdir build
cd build

cmake .. -DSTATIC_BUILD=ON -DCMAKE_BUILD_TYPE=Release

# If needed: VERBOSE=1
make VERBOSE=1 -j$(nproc)
# doesnt work: ./UnitTests
mv libOrthancIndexer.so.mainline ../../libOrthancIndexer.so
cd ../..
rm -rf orthanc-indexer
