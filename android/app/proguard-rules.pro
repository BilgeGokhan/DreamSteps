# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Google Mobile Ads
-keep class com.google.android.gms.ads.** { *; }
-keep class com.google.ads.** { *; }
-dontwarn com.google.android.gms.ads.**

# Gson specific classes
-keepattributes Signature
-keepattributes *Annotation*
-dontwarn sun.misc.**
-keep class com.google.gson.examples.android.model.** { <fields>; }
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Keep native methods
-keepclasseswithmembernames class * {
    native <methods>;
}

# Keep custom model classes
-keep class com.dreamsteps.app.** { *; }

# SharedPreferences
-keep class android.content.SharedPreferences { *; }
-keep class android.content.SharedPreferences$Editor { *; }

# Local notifications
-keep class com.dexterous.flutterlocalnotifications.** { *; }

# Package info
-keep class dev.fluttercommunity.plus.packageinfo.** { *; }

# Keep line numbers for debugging
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile

