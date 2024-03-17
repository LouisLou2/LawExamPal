import 'dart:io';

import 'package:camerawesome/camerawesome_plugin.dart';
import 'package:easy_cse/service/path_manager.dart';
import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
class SnapPicPage extends StatefulWidget {
  const SnapPicPage({Key? key}) : super(key: key);

  @override
  _SnapPicPageState createState() => _SnapPicPageState();
}

class _SnapPicPageState extends State<SnapPicPage> {
   Future<CaptureRequest> pathBuilder(List<Sensor> sensors) async{
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
        pathBuilder: pathBuilder,
      ),
      onMediaTap: (mediaCapture) {
        OpenFile.open(PathManager.lastPicPath);
      },
    );
  }
}
