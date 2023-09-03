set -e
set -x

# https://book.orthanc-server.com/plugins/indexer.html

#if [ "$TARGETARCH" = amd64 ]; then 
# https://www.orthanc-server.com/browse.php?path=/plugin-indexer
# https://lsb.orthanc-server.com/plugin-indexer/mainline/
#apt-get -q install -y curl
#curl https://lsb.orthanc-server.com/plugin-indexer/mainline/libOrthancIndexer.so -o libOrthancIndexer.so
#else
# <build>
#fi

# Build from source on all platforms
# Need the "skip large files" patch

apt-get -q install -y mercurial cmake make g++ patch unzip libdcmtk-dev
# TODO uncomment
#hg clone https://orthanc.uclouvain.be/hg/orthanc-indexer
# hg update -r<REV>

apt-get -q install -y git
git clone https://github.com/CGDogan/orthanc-indexer --branch=rewrite

cd orthanc-indexer
mkdir build
cd build
cmake .. -DSTATIC_BUILD=ON -DCMAKE_BUILD_TYPE=Release

# If needed: VERBOSE=1
make -j$(nproc)
mv libOrthancIndexer.so.mainline ../../libOrthancIndexer.so
cd ../..
rm -rf orthanc-indexer
