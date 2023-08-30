set -e
set -x

# https://book.orthanc-server.com/plugins/indexer.html

if [ "$TARGETARCH" = amd64 ]; then 

# https://www.orthanc-server.com/browse.php?path=/plugin-indexer
# https://lsb.orthanc-server.com/plugin-indexer/mainline/

apt-get -q install -y curl
curl https://lsb.orthanc-server.com/plugin-indexer/mainline/libOrthancIndexer.so -o libOrthancIndexer.so

else

# TODO uncommentt
#apt-get -q install -y mercurial cmake make g++ patch unzip
#hg clone https://orthanc.uclouvain.be/hg/orthanc-indexer

#export COLLECT_NO_DEMANGLE=1
apt-get -q install -y git libdcmtk-dev
git clone https://github.com/CGDogan/orthanc-indexer


cd orthanc-indexer
mkdir build
cd build
cmake .. -DSTATIC_BUILD=ON -DCMAKE_BUILD_TYPE=Release

# If needed: VERBOSE=1
make
mv libOrthancIndexer.so.mainline ../../libOrthancIndexer.so
cd ../..

fi
