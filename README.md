# 法考智友

[本项目GitHub][github] • [Gitee][gitee]

[服务端仓库地址][server_repo]

[English](https://github.com/LouisLou2/LawExamPal/blob/master/README_EN.md)

[github]: https://github.com/LouisLou2/LawExamPal
[gitee]: https://gitee.com/giteeleoleo/LawExamPal
[server_repo]: https://github.com/vaporhug/AI_Helper/tree/master

一个专为法考考生设计的AI助手，提供基于图片的问题解答、AI问答、个性化推荐和笔记整理等功能，帮助考生高效备考。

- [法考智友](#法考智友)
  - [关于](#关于)
  - [截图](#截图)
  - [下载](#下载)
  - [设置](#设置)
  - [准备](#准备)
  - [开始使用](#开始使用)
  - [贡献](#贡献)
    - [Bug修复与改进](#bug修复与改进)
  - [构建](#构建)
    - [Android](#android)

## 关于

法考智友是专为法考考生设计的AI助手。它利用针对性训练的大型语言模型（LLM），支持多种功能，包括基于图片的问题解答，利用[TextIn通用文字识别][text_in],精准识别考生拍摄的试题照片，并提供详细解答；AI问答，提供高效准确的问题解答；个性化题目推荐，根据用户的学习情况和考试需求，推荐符合个人水平的练习题目；智能笔记整理，自动整理用户学习过程中的笔记和重点内容，方便复习和总结。LawExamPal帮助考生高效备考，提高考试分数，是备考过程中的理想伙伴。

[text_in]: https://www.textin.com/product/textin_text

## 截图
 <img src="https://raw.githubusercontent.com/LouisLou2/LawExamPal/master/screenshots/home.jpg" alt="home" height="400"/>
<img src="https://raw.githubusercontent.com/LouisLou2/LawExamPal/master/screenshots/explanation.jpg" alt="explanation" height="400"/>
<img src="https://raw.githubusercontent.com/LouisLou2/LawExamPal/master/screenshots/chat.jpg" alt="chat" height="400"/>
<img src="https://raw.githubusercontent.com/LouisLou2/LawExamPal/master/screenshots/practice.jpg" alt="practice" height="400"/>

## 下载
您可以下载并使用我们已经构建的最新APK

[最新APK][latest]

[latest]: https://github.com/LouisLou2/LawExamPal/releases/latest

## 设置

在大多数情况下，法考智友应该可以直接使用。但是，如果你在打开或者使用过程中遇到问题，请检查您的Android版本是否过低。我们推荐您使用Android 9及更新的版本，以得到稳定流畅的体验

## 准备
1. 安装 [Flutter](https://flutter.dev)
2. 跟随 [Flutter官方文档](https://docs.flutter.dev/get-started/install)或者[Flutter中国开发者文档](https://flutter.cn/community/china)配置环境
3. 下载Andriod SDK与NDK
> [!NOTE]
> - 推荐您使用Andriod Studio进行一站式的代码管理，提供SDK, NDK以及其他SDK Tools的安装，版本参照以及管理
> - 本项目最新commit的SDK以及NDK的参考：[环境参考](https://github.com/LouisLou2/LawExamPal/blob/master/env.yaml)

编译源码并运行请查看[开始使用](#开始使用)
## 开始使用

将“法考智友”从源码编译运行，请按照以下步骤：

1. 安装 [Flutter](https://flutter.dev)
2. 跟随 [Flutter官方文档](https://docs.flutter.dev/get-started/install)或者[Flutter中国开发者文档](https://flutter.cn/community/china)配置环境
3. 克隆 `LawExamPal` 仓库
4. 在 `lib/config/config.dart`中修改配置，例如服务端主机地址等
5. 运行 `cd app` 进入应用程序目录
6. 运行 `flutter pub get` 以下载必要的依赖项
7. 运行 `flutter run` 在debug模式下启动应用程序

考虑构建release版本？查看[构建](#构建)
> [!NOTE]
> #### 可能出现的问题
> - “法考智友” 源代码在Flutter 3.19.3版本下编写与测试，因此，构建问题可能是由所需的Flutter版本与（系统范围内）安装的Flutter版本不匹配造成的。  
> 为了使开发更加一致，你可以查看[Flutter Archive](https://docs.flutter.dev/release/archive),下载与开发版本相同的Flutter版本
> - Flutter版本的更新以及`pubspec.yaml`中的依赖项的更新，可能会产生依赖冲突的问题, 你可以尝试参阅输出日志以及`pub.dev` 寻找兼容版本

## 贡献

我们欢迎任何有兴趣帮助改进 法考智友 的贡献者。如果您想要贡献，有几种方式可以参与进来：

### Bug修复与改进

- **Bug修复:** 如果您发现了一个 bug，请创建一个拉取请求（pull request），并清晰描述问题以及如何修复它。
- **改进:** 如果你有更好改进“法考智友”的点子，请先创建一个问题（issue），发表你的建议

## 构建

这些命令仅供维护者使用。

### Android

Traditional APK

```bash
flutter build apk
```
构建完成后的文件置于 `build/app/outputs/flutter-apk` 文件夹下

AppBundle for Google Play

```bash
flutter build appbundle
```


> [!NOTE]
> 你可以在以上命令后加`-v` , 例如`flutter build apk -v` 以查看build日志，这可以帮助你定位到拖慢build过程的原因(如果有的话)，以及其他可能出现的问题
