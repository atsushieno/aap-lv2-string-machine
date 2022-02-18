
PWD=$(shell pwd)
AAP_LV2_DIR=$(PWD)/external/aap-lv2

all: build-all

build-all: \
	build-aap-lv2 \
	get-string-machine-deps \
	import-string-machine-deps \
	build-java

build-aap-lv2:
	cd $(AAP_LV2_DIR) && make

## downloads

get-string-machine-deps: dependencies/string-machine-deps/dist/stamp

dependencies/string-machine-deps/dist/stamp: android-string-machine-binaries.zip
	mkdir -p dependencies/string-machine-deps
	unzip android-string-machine-binaries -d dependencies/string-machine-deps/
	if [ ! -d app/src/main/cpp/symlinked-dist ] ; then \
		ln -s $(PWD)/dependencies/string-machine-deps/dist app/src/main/cpp/symlinked-dist ; \
	fi
	touch dependencies/string-machine-deps/dist/stamp

android-string-machine-binaries.zip:
	wget https://github.com/atsushieno/android-native-audio-builders/releases/download/r8.4/android-string-machine-binaries.zip

# Run importers

import-string-machine-deps:
	./import-string-machine-deps.sh

## Build utility

build-java:
	ANDROID_SDK_ROOT=$(ANDROID_SDK_ROOT) ./gradlew build
 
## update metadata

update-metadata:
	cd external/aap-lv2 && make build-lv2-importer
	external/aap-lv2/tools/aap-import-lv2-metadata/build/aap-import-lv2-metadata app/src/main/assets/lv2 app/src/main/res/xml

