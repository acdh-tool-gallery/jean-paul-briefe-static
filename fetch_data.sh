# bin/bash

echo "fetching transkriptions from data_repo"
rm -rf data/
curl -LO https://github.com/acdh-tool-gallery/jean-paul-briefe/archive/refs/heads/main.zip
unzip main

mv ./jean-paul-briefe-main/data/ .

rm main.zip
rm -rf ./jean-paul-briefe-main

echo "fetch imprint"
./shellscripts/dl_imprint.sh
