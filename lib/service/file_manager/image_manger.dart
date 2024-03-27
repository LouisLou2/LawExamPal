import 'dart:io';

import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/service/navigation/navigation_helper.dart';
import 'package:easy_cse/service/navigation/route_collector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/app_style/app_color.dart';

class ImageManager {
  static ImagePicker imagePicker = ImagePicker();
  static const int _imageQuality = 50; // 1-100
  static const int _compressQuality = 20; // 1-100
  static late String lastImgPath;// 仅仅用于测试
  /*
  * 选择图片
  * fromGallery: true 从相册选择，false 从相机选择
  */
  static Future<void> editImg(bool fromGallery) async {
    await imagePicker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: _imageQuality
    ).then((value) {
      if (value != null) {
        cropImage(value.path);
      }
    });
  }

  static Future<void> editImgFromGallery() async {
    await editImg(true);
  }

  static Future<void> cropImage(String path) async {
    final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ] : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        uiSettings: [AndroidUiSettings(
          toolbarTitle: AppStrings.cropImage,
          toolbarColor: AppColors.silentBlue,
          toolbarWidgetColor: AppColors.white2,
          statusBarColor: AppColors.silentBlue,
          backgroundColor: AppColors.white2,
          dimmedLayerColor: AppColors.white0.withOpacity(0.3),
          cropFrameColor: AppColors.white0,
          activeControlsWidgetColor: AppColors.silentBlue,
          cropFrameStrokeWidth: 3,
          initAspectRatio: CropAspectRatioPreset.square,
          lockAspectRatio: false,
          hideBottomControls: false,
        ),
          IOSUiSettings(
            title: AppStrings.cropImage,
          )
        ]
    );
    if(croppedFile == null)return;
    imageCache.clear();
    print('@@@@@@@@@@@@@@@@@@@@@');
    print(croppedFile.path);
    lastImgPath = croppedFile.path;
    NavigationHelper.pushNamed(
      RouteCollector.explanation,
      arguments: croppedFile.path,
    );
    //reload();
  }
  // 2. compress file and get file.
  // 这里会返回一个压缩后的文件，targetPath是压缩后的文件路径，应该存储
  Future<File> testCompressAndGetFile(File file, String targetPath) async {
    var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: _compressQuality,
      rotate: 0,
    );
    print(file.lengthSync());
    print(await result?.length());
    return File(result!.path);
  }
}