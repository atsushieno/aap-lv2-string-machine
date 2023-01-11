# aap-lv2-string-machine: String-Machine ported to Audio Plugins For Android

It is a port of [String-Machine](https://github.com/jpcima/string-machine) to [Audio Plugins For Android](https://github.com/atsushieno/aap-core/). It is powered by LV2 using [aap-lv2](https://github.com/atsushieno/aap-lv2/).

## Building

`make` should take care of the builds. See [GitHub Actions script](.github/workflows/actions.yml) for further normative setup.

Historically, we downloaded prebuilt string-machine binaries from [android-native-audio-builders](https://github.com/atsushieno/android-native-audio-builders) release artifacts. Now DPF supports CMake so our build is based on CMake script (with some tweaks).

We patch string-machine sources as if it did not support GUI (DGL does not compile on Android). Unlike Makefile, DPF CMake does not seem to support `UI_TYPE` and `CROSS_COMPILING`.

## Important notes on updating string-machine

This build setup involves patching DPF cmake script to explicitly skip lv2-ttl-generator (because it does not compile under cross-compiling environment). If you updated string-machine sources, make sure to build it locally first, copy the `string-machine.lv2` directory to `app/main/assets/lv2`, removing `*.so` files (they are built during app build time by Gradle).

Therefore unlike other LV2 projects, we directly commit string-machine.lv2 content in the source tree for now.

(It may sound awkward, but having to download prebuilt binaries and therefore being unable to debug the sources is way more annoying problem that you would not like to deal with.)

## Licensing notice

aap-lv2-string-machine codebase is distributed under the BSL-1.0 license.

LV2 (repository for the headers) is under the ISC license.

String-Machine is distributed under the BSL-1.0 license.

The entire plugin application bundles `androidaudioplugin-lv2` AAR module from `aap-lv2`, and `androidaudioplugin` AAR module, and is packaged into one application.
