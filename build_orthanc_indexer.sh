set -e
set -x

# https://book.orthanc-server.com/plugins/indexer.html

if [ "$TARGETARCH" = amd64 ]; then 

# https://www.orthanc-server.com/browse.php?path=/plugin-indexer
# https://lsb.orthanc-server.com/plugin-indexer/mainline/

apt-get -q install -y curl
curl https://lsb.orthanc-server.com/plugin-indexer/mainline/libOrthancIndexer.so -o libOrthancIndexer.so

else

apt-get -q install -y mercurial cmake make g++ patch unzip
hg clone https://orthanc.uclouvain.be/hg/orthanc-indexer
cd orthanc-indexer
mkdir build
cd build
cmake .. -DSTATIC_BUILD=ON -DCMAKE_BUILD_TYPE=Release
make
mv libOrthancIndexer.so.mainline ../../libOrthancIndexer.so
cd ../..

fi
