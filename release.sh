#!/bin/bash
#
# Script to release new versions for Windows, macOS, and Linux.
#
# This script expects a file `./env` with exported envvars to sign executables
# for Windows and macOS.
#
# The commented cmdlines were used in the past to fix different kind of issues.
# They were left here because they might be useful for troubleshooting in the future.

step1() {
	echo step1
	rm -rf node_modules/
	#npm install --save node-sass-chokidar || exit -1
	npm install || exit -1
}

step2() {
	echo step2
	make check || exit -1
	make i18n || exit -1

	rm -rf build/
	#export NODE_OPTIONS=--max_old_space_size=2048
	npm run build || exit -1
}

step3() {
	echo step3
	#npm install bufferutil fibers utf-8-validate sass node-sass-chokidar
	#npm install electron-builder@22.10.5
	#npm install electron-builder@latest
}

step4() {
	echo step4
	source ./env
	npm run electron-pack-linux || exit -1
	npm run electron-pack-win || exit -1
	npm run electron-pack-mac || exit -1
}

step1
step2
step3
step4
