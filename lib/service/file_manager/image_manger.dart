import 'dart:io';

import 'package:easy_cse/constant/app_string.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/app_style/app_color.dart';

class ImageManager {
  static ImagePicker imagePicker = ImagePicker();
  static const int _imageQuality = 50; // 1-100

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
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
          hideBottomControls: false,
        ),
          IOSUiSettings(
            title: AppStrings.cropImage,
          )
        ]
    );
    if (croppedFile != null) {
      imageCache.clear();
      print('@@@@@@@@@@@@@@@@@@@@@');
      print(croppedFile.path);
      // reload();
    }
  }
}