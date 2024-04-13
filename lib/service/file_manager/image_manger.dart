import 'dart:io';

import 'package:easy_cse/constant/app_string.dart';
import 'package:easy_cse/service/file_manager/path_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../constant/app_style/app_color.dart';

class ImageManager {
  static ImagePicker imagePicker = ImagePicker();
  static const int _imageQuality = 50; // 1-100
  static const int _compressQuality = 30; // 1-100
  /*
  * 选择图片
  * fromGallery: true 从相册选择，false 从相机选择
  */
  static Future<String?> editImg(bool fromGallery) async {
    XFile? file=await imagePicker.pickImage(
        source: fromGallery ? ImageSource.gallery : ImageSource.camera,
        imageQuality: _imageQuality
    );
    if(file!=null){
      return file.path;
    }
    return null;
  }

  static Future<String?> editImgFromGallery() async {
    return await editImg(true);
  }

  static Future<String> cropImage(String path) async {
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
    if(croppedFile == null)return '';
    imageCache.clear();
    return croppedFile.path;
  }
  // 2. compress file and get file.
  // 这里会返回一个压缩后的文件，targetPath是压缩后的文件路径，应该存储
  static Future<String?> compressAndGetPath(String sourcePath, String targetPath) async {
    XFile? result = await FlutterImageCompress.compressAndGetFile(
      sourcePath, targetPath,
      quality: _compressQuality,
      rotate: 0,
    );
    return result?.path;
  }

  static Future<String?> compressAndGetPathDefault(String sourcePath) async {
    String targetPath = await PathManager.makeCompressImgPath();
    XFile? result = await FlutterImageCompress.compressAndGetFile(
      sourcePath, targetPath,
      quality: _compressQuality,
      rotate: 0,
    );
    return result?.path;
  }
}