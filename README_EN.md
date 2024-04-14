# LawExamPal
[中文版](https://github.com/LouisLou2/LawExamPal/blob/master/README.md)

[GitHub][github] • [Gitee][gitee]

#### Links to other repositories of this project

[Server][server_repo]

[AI Model][ai_model]

[github]: https://github.com/LouisLou2/LawExamPal
[gitee]: https://gitee.com/giteeleoleo/LawExamPal
[server_repo]: https://github.com/vaporhug/AI_Helper/tree/master
[ai_model]: https://github.com/LiangYeJing/dengxi_Law_Learn

LawExamPal is an AI assistant designed specifically for legal exam candidates. It offers features such as photo-based question answering, AI Q&A, personalized question recommendations, and note organization to help candidates prepare efficiently for their exams.

## About

LawExamPal is an AI assistant designed for legal exam candidates. It utilizes fine-tuned Large Language Models (LLM) to provide features such as photo-based question answering, which accurately identifies and answers questions from photos of exam questions taken by candidates; AI Q&A, which provides efficient and accurate answers to questions; personalized question recommendations, which recommend practice questions tailored to the user's learning and exam needs; and intelligent note organization, which automatically organizes notes and key content from the user's study process, facilitating review and summarization. LawExamPal helps candidates prepare efficiently for exams, improve their exam scores, and is an ideal companion during the exam preparation process.

## Screenshots

 <img src="https://raw.githubusercontent.com/LouisLou2/LawExamPal/master/screenshots/home.jpg" alt="home" height="400"/>
<img src="https://raw.githubusercontent.com/LouisLou2/LawExamPal/master/screenshots/explanation.jpg" alt="explanation" height="400"/>
<img src="https://raw.githubusercontent.com/LouisLou2/LawExamPal/master/screenshots/chat.jpg" alt="chat" height="400"/>
<img src="https://raw.githubusercontent.com/LouisLou2/LawExamPal/master/screenshots/practice.jpg" alt="practice" height="400"/>

## Download

You can download and use the latest APK that we have already built.

[Latest APK][latest]

[latest]: https://github.com/LouisLou2/LawExamPal/releases/latest

## Setup

In most cases, LawExamPal should work out of the box. However, if you encounter any issues when opening or using the app, please check if your Android version is too low. We recommend using Android 9 or later versions for a stable and smooth experience.

## Prerequisites

1. Install [Flutter](https://flutter.dev).
2. Follow the [Flutter official documentation](https://docs.flutter.dev/get-started/install) or [Flutter Chinese developer documentation](https://flutter.cn/community/china) to set up the environment.
3. Download Android SDK and NDK.

> [!NOTE]
>
> - We recommend using Android Studio for one-stop code management, providing SDK, NDK, and other SDK Tools installation, version reference, and management.
> - Reference for the latest commit SDK and NDK of this project: [Environment Reference](https://github.com/LouisLou2/LawExamPal/blob/master/env.yaml)

To compile the source code and run it, please refer to [Getting Started](#getting-started).

## Getting Started

To compile and run LawExamPal from the source code, follow these steps:

1. Clone the `LawExamPal` repository.
2. Modify the configuration in `lib/config/config.dart`, such as the server's host address.
3. Run `cd app` to enter the app directory.
4. Run `flutter pub get` to download the necessary dependencies.
5. Run `flutter run` to start the app in debug mode.

Considering building a release version? Check out [Building](#building).

> [!NOTE]
>
> #### Potential Issues
>
> - The LawExamPal source code is written and tested on Flutter version 3.19.3, so build issues may be caused by a mismatch between the required and the (system-wide) installed Flutter version.  
>   To make development more consistent, you can refer to [Flutter Archive](https://docs.flutter.dev/release/archive) to download the Flutter version that matches the development version.
> - Updates to the Flutter version and dependencies in `pubspec.yaml` may result in dependency conflicts. You can try to refer to the output log and `pub.dev` to find compatible versions.

## Contributing

We welcome contributions from anyone interested in helping improve LawExamPal. If you'd like to contribute, there are a few ways to get involved:

### Bug Fixes and Improvements

- **Bug Fixes:** If you find a bug, please create a pull request with a clear description of the issue and how to fix it.
- **Improvements:** Have an idea for how to improve LawExamPal? Please create an issue first to discuss why the improvement is needed.

## Building

These commands are for maintainers only.

### Android

Traditional APK

```bash
flutter build apk
```

The built files are placed in the `build/app/outputs/flutter-apk` folder.

AppBundle for Google Play

```bash
flutter build appbundle
```

> [!NOTE]
> You can add `-v` after the above commands, for example, `flutter build apk -v`, to view the build log. This can help you locate reasons for slowing down the build process (if any) and other possible issues.