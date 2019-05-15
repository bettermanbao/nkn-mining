#!/bin/sh

BASEDIR="$( cd "$(dirname "$0")" ; pwd -P )"

echo 'clean dist'
rm -rf ${BASEDIR}/dist/*

echo  'build web'
cd ${BASEDIR}/NKNMining/web/
npm install
npm run build

cd ${BASEDIR}/NKNMining/src/NKNMining/
echo 'install golang package'
glide install

IDENTIFIER="linux-386 linux-amd64 linux-arm linux-arm64 linux-mips linux-mipsle darwin-386 darwin-amd64 windows-386 windows-amd64"

for id in ${IDENTIFIER}; do
	echo "build ${id}"

	mkdir ${BASEDIR}/dist/NKNMining
	cp -r ${BASEDIR}/init_files/* ${BASEDIR}/dist/NKNMining/

	mkdir -p ${BASEDIR}/dist/NKNMining/web/
	cp -r ${BASEDIR}/NKNMining/web/dist/* ${BASEDIR}/dist/NKNMining/web/

	id_os=$(echo ${id} | cut -d - -f 1)
	id_arch=$(echo ${id} | cut -d - -f 2)

	GOPATH=$GOPATH:${BASEDIR}/NKNMining/ GOOS=${id_os} GOARCH=${id_arch} GOMIPS=softfloat go build
	
	cd ${BASEDIR}/dist
	if [ "${id_os}" = "windows" ]; then
		mv ${BASEDIR}/NKNMining/src/NKNMining/NKNMining.exe ${BASEDIR}/dist/NKNMining/
		zip -r "NKNMining-${id}.zip" "NKNMining"
	else
		mv ${BASEDIR}/NKNMining/src/NKNMining/NKNMining ${BASEDIR}/dist/NKNMining/
		tar -zcvf "NKNMining-${id}.tgz" "NKNMining"
	fi
	rm -rf "NKNMining"
	cd ${BASEDIR}/NKNMining/src/NKNMining/
done

echo 'done! ^_T'
