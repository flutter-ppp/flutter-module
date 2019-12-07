## Getting Started

For help getting started with Flutter, view our online
[documentation](https://flutter.dev/).

# 常见Flutter命令
- `flutter -h`
- `flutter run`
- `flutter pub get`
- `flutter create --androidx -t module flutter_module` create flutter module
- `flutter channel ` see how many branches of flutter
- `flutter channel beta`  go to flutter branch beta.

注意：首先把 Flutter 切换到 beta/stable 分支 
- [Flutter-Channel](https://github.com/flutter/flutter/wiki/Flutter-build-release-channels) 

===

### Demo 描述
###### 1. `main.dart`
模版生成的dart

###### 2. `network.dart`
1. 示例使用第三方lib-http
2. 异步UI。 async，await 关键字（将任务转到后台）
3. 显示 progress
4. isolate . **Dart 有一个单线程执行的模型，同时也支持 Isolate（在另一个线程运行 Dart 代码的方法），它是一个事件循环和异步编程方式。**

###### 3. `lifecycleWatcher.dart`
1. 通过绑定 WidgetsBinding 观察者并监听 didChangeAppLifecycleState() 的变化事件来监听生命周期

###### 4. `channel.dart`
1. 通过 MethodChannel 调用 native 方法，并返回值。
2. 通过 MethodChannel 调用 dart 方法，并返回值。
3. 通过 BasicMessageChannel 
4. EventChannel：用于数据流的通信，持续通信，收到消息后无法回复此次消息。通常用于Native向Dart的通信。


### 踩坑
1. 示例中的Flutter-module是在beta branch创建出来的，运行的时候尽量在此版本下，以免出现兼容问题

### 说明
1. 结合Android端项目一起使用，地址如下：[FirstFlutterModuleInAndroid](https://github.com/flutter-ppp/FirstFlutterModuleInAndroid)

### 参考文档
- [给 Android 开发者的 Flutter 指南](https://flutter.cn/docs/get-started/flutter-for/android-devs)
- [Flutter混合开发(三)：Android与Flutter之间通信详细指南](https://juejin.im/post/5dce51edf265da0c0c1fe649)