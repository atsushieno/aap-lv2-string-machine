# aap-lv2-string-machine: String-Machine ported to Audio Plugins For Android

It is a port of [String-Machine](https://github.com/jpcima/string-machine) to [Audio Plugins For Android](https://github.com/atsushieno/aap-core/). It is powered by LV2 using [aap-lv2](https://github.com/atsushieno/aap-lv2/).

## Building

`make` should take care of the builds. See [GitHub Actions script](.github/workflows/actions.yml) for further normative setup.

At this state, it downloads prebuilt string-machine binaries from [android-native-audio-builders](https://github.com/atsushieno/android-native-audio-builders) release artifacts. We are not sure if we change that - DPF is not CMake ready.


## Licensing notice

aap-lv2-string-machine codebase is distributed under the BSL-1.0 license.

LV2 (repository for the headers) is under the ISC license.

String-Machine is distributed under the BSL-1.0 license.

The entire plugin application bundles `androidaudioplugin-lv2` AAR module from `aap-lv2`, and `androidaudioplugin` AAR module, and is packaged into one application.
