
PWD=$(shell pwd)
AAP_LV2_DIR=$(PWD)/external/aap-lv2

all: build-all

build-all: \
	build-aap-lv2 \
	patch-string-machine \
	build-agp

build-aap-lv2:
	cd $(AAP_LV2_DIR) && make

patch-string-machine: external/string-machine/patch.stamp
	if [ ! -L app/src/main/cpp ] ; then \
	cd app/src/main && ln -s ../../../external/string-machine cpp ; \
	else echo "symlink already exists" ; \
	fi

external/string-machine/patch.stamp:
	cd external/string-machine && \
		patch -i ../../aap-support.patch -p1 && \
		touch patch.stamp || exit 1

build-agp:
	ANDROID_SDK_ROOT=$(ANDROID_SDK_ROOT) ./gradlew build bundle
 
# Make sure to have a look at README.md and understand you need up-to-date string-machine.lv2 under app/src/main/assets.
update-metadata:
	cd external/aap-lv2 && make build-lv2-importer
	external/aap-lv2/tools/aap-import-lv2-metadata/build/aap-import-lv2-metadata app/src/main/assets/lv2 app/src/main/res/xml

