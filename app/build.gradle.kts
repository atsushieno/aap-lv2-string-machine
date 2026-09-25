plugins {
    alias(libs.plugins.android.application)
}

val enable_asan: Boolean by extra

android {
    namespace = "org.androidaudioplugin.ports.lv2.string_machine"
    compileSdk = libs.versions.android.compileSdk.get().toInt()
    defaultConfig {
        applicationId = "org.androidaudioplugin.ports.lv2.string_machine"
        minSdk = libs.versions.android.minSdk.get().toInt()
        targetSdk = libs.versions.android.targetSdk.get().toInt()
        versionCode = 1
        versionName = libs.versions.aap.lv2.get()
        testInstrumentationRunner = "androidx.test.runner.AndroidJUnitRunner"

        externalNativeBuild {
            cmake {
                arguments ("-DCMAKE_BUILD_TYPE=RelWithDebInfo", "-DANDROID_STL=c++_shared", "-DAAP_ENABLE_ASAN=" + (if (enable_asan) "1" else "0"))
            }
        }
    }

    // see androidaudioplugin/build.gradle.kts for details...
    ndkVersion = libs.versions.ndk.get()

    buildTypes {
        release {
            isMinifyEnabled = false
            proguardFiles (getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
    externalNativeBuild {
        cmake {
            path ("src/main/cpp/CMakeLists.txt")
            version = libs.versions.cmake.get()
        }
    }
    buildFeatures {
        prefab = true
    }
    packaging {
        if (enable_asan)
            jniLibs.useLegacyPackaging = true
    }
    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }
}

dependencies {
    implementation (libs.aap.lv2)
    implementation (libs.aap.core)
    implementation (libs.aap.midi.device.service)
    implementation (libs.aap.ui.compose.app)
    implementation (libs.aap.ui.web)
    implementation (libs.aap.js.controller)
    androidTestImplementation (libs.aap.testing)
    //  If you want to test aap-core and aap-lv2 locally, switch to these local references
    //  (along with settings.gradle.kts changes)
    /*
    implementation (project(":androidaudioplugin-lv2"))
    implementation (project(":androidaudioplugin"))
    implementation (project(":androidaudioplugin-midi-device-service"))
    implementation (project(":androidaudioplugin-ui-compose-app"))
    implementation (project(":androidaudioplugin-ui-web"))
    androidTestImplementation (project(":androidaudioplugin-testing"))
     */

    testImplementation (libs.junit)
    androidTestImplementation (libs.test.ext.junit)
}
