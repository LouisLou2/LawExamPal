import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:easy_cse/gui/widget/decorations/guide_line.dart';
import 'package:easy_cse/gui/widget/buttons/icon_text_button.dart';
import 'package:easy_cse/gui/widget/ui_kitbag.dart';
import 'package:easy_cse/service/file_manager/image_manger.dart';
import 'package:easy_cse/service/file_manager/path_manager.dart';
import 'package:easy_cse/service/handler/ques_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';
import '../../../dependency_change/camerawesome/awesome_capture_button.dart';
class SnapPicPage extends StatefulWidget {
  const SnapPicPage({super.key});

  @override
  State<SnapPicPage> createState() => _SnapPicPageState();
}

class _SnapPicPageState extends State<SnapPicPage> {
   Future<CaptureRequest> _pathBuilder(List<Sensor> sensors) async{
    if (sensors.length == 1) {
      return SingleCaptureRequest(await PathManager.makePhotoPath(0),sensors.first);
    } else {
      return MultipleCaptureRequest(
        {
          for (final sensor in sensors)
            sensor:
            await PathManager.makePhotoPath(sensor.position == SensorPosition.front ? 1 : 0),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CameraAwesomeBuilder.awesome(
      saveConfig: SaveConfig.photo(
        pathBuilder: _pathBuilder,
      ),
      onMediaTap: (mediaCapture) {
        OpenFile.open(PathManager.lastRawPicPath);
      },
      progressIndicator: const Center(
        child: UIKitBag.blue_loadingIndicator,
      ),
      topActionsBuilder: (state) => AwesomeTopActions(
        state: state,
        children: [
          AwesomeFlashButton(state: state),
          if (state is PhotoCameraState)
            AwesomeAspectRatioButton(state: state),
          if (state is PhotoCameraState)
            Material(
              color: Colors.transparent,
              child: SizedBox(
                width: 150.w,
                height: 170.w,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Switch(
                        value: false,
                        activeColor: AppColors.megaBlue,
                        activeTrackColor: AppColors.white1,
                        onChanged: (value) {}
                    ),
                    Text(
                      AppStrings.incognito,
                      style: TextStyle(
                        color: AppColors.white1,
                        fontSize: 30.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      bottomActionsBuilder: (state) => AwesomeBottomActions(
        state: state,
        /*修改了camerawesome-2.0.1\lib\src\widgets\buttons\awesome_capture_button.dart源码，到lib/dependency_change/camerawesome/awesome_capture_button.dart
        因为要使用onPhoto可能需要使用custome模式自定义界面，这里仍然使用插件buildIn UI,但是需要再照片刚刚拍下来，
        就执行某个逻辑，所以增加了这个属性。
        */
        captureButton: AwesomeCaptureButton1(
          state: state,
          onPhoto: QuesHandler.executeSearchQues,
        ),
        left: IconTextButton(
          icon: Icons.folder_copy_outlined,
          text: AppStrings.history,
          onTap: () {},
          color: AppColors.white1,
          size: 150.w,
        ),
        right: IconTextButton(
          icon: Icons.photo_outlined,
          text: AppStrings.gallery,
          onTap: ImageManager.editImgFromGallery,
          color: AppColors.white1,
          size: 150.w,
        ),
      ),
      middleContentBuilder: (state)=>LayoutBuilder(
        builder: (context, constraints)=>GuideLineWidget(
          width: constraints.maxWidth,
          height: constraints.maxHeight,
          color: AppColors.white2,
        ),
      ),
    );
  }
}
