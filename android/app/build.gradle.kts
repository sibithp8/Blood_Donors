plugins {
    id("com.android.application")
    id("kotlin-android")

    // ✅ Flutter Gradle Plugin must be after Android/Kotlin
    id("dev.flutter.flutter-gradle-plugin")

    // ✅ Google Services plugin
    id("com.google.gms.google-services")
}

android {
    namespace = "com.example.blooddonor" // change if needed
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.blooddonor" // change if needed
        minSdk = 23
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        multiDexEnabled = true
    }

    buildTypes {
        release {
            // For now, use debug signing config (replace with your own keystore later)
            signingConfig = signingConfigs.getByName("debug")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // ✅ Firebase BOM (manages versions automatically)
    implementation(platform("com.google.firebase:firebase-bom:33.4.0"))

    // ✅ Firebase services you need
    implementation("com.google.firebase:firebase-analytics")
    implementation("com.google.firebase:firebase-auth")
    implementation("com.google.firebase:firebase-firestore")
    implementation("androidx.multidex:multidex:2.0.1")

    // ✅ AndroidX + Material
    implementation("androidx.core:core-ktx:1.13.1")
    implementation("androidx.appcompat:appcompat:1.7.0")
    implementation("com.google.android.material:material:1.12.0")
}