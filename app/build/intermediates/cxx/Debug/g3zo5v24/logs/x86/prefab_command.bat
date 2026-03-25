@echo off
"C:\\Program Files\\Android\\Android Studio\\jbr\\bin\\java" ^
  --enable-native-access ^
  ALL-UNNAMED ^
  --class-path ^
  "C:\\Users\\user\\.gradle\\caches\\modules-2\\files-2.1\\com.google.prefab\\cli\\2.1.0\\aa32fec809c44fa531f01dcfb739b5b3304d3050\\cli-2.1.0-all.jar" ^
  com.google.prefab.cli.AppKt ^
  --build-system ^
  cmake ^
  --platform ^
  android ^
  --abi ^
  x86 ^
  --os-version ^
  35 ^
  --stl ^
  c++_static ^
  --ndk-version ^
  28 ^
  --output ^
  "C:\\Users\\user\\AppData\\Local\\Temp\\agp-prefab-staging3453134984974178195\\staged-cli-output" ^
  "C:\\Users\\user\\.gradle\\caches\\9.3.1\\transforms\\d89189cf1bb462d02326088e419c8206\\workspace\\transformed\\games-activity-4.0.0\\prefab"
