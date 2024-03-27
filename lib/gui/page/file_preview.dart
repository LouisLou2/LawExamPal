import 'dart:io';

import 'package:easy_cse/constant/app_icons.dart';
import 'package:easy_cse/gui/widget/buttons/icon_text_button.dart';
import 'package:easy_cse/service/file_manager/image_manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../constant/app_style/app_color.dart';

class FilePreviewPage extends StatefulWidget {
  const FilePreviewPage({Key? key}) : super(key: key);

  @override
  State<FilePreviewPage> createState() => _FilePreviewPageState();
}
class _FilePreviewPageState extends State<FilePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('File Preview'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: shareTest,
          ),
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: printTest,
          ),
        ],
      ),
      body: SfPdfViewer.asset('assets/files/flutter-succinctly.pdf'),
      bottomNavigationBar: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 40.w, vertical: 2.h), // EdgeInsets.only(left: 20.w, right: 20.w, bottom: 10.h
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            shape: BoxShape.rectangle,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: [
              BoxShadow(
                color: AppColors.silenceColor.withOpacity(0.3),
                blurRadius: 2,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconTextButton(
                  icon: AppIcons.file_word,
                  text: '转为word',
                  color: AppColors.silentBlue,
                  size: 50,
              ),
              IconTextButton(
                icon: AppIcons.file_pdf,
                text: '转为pdf',
                color: AppColors.thickRed,
                size: 50,
              ),
            ],
          ),
        ),
      )
    );
  }
  void shareTest() async {
    final result = await Share.shareXFiles([XFile('/data/user/0/com.example.easy_cse/cache/image_cropper_1711535495206.jpg')], text: 'Great picture');
    if (result.status == ShareResultStatus.success) {
      print('Thank you for sharing the picture!');
    }
  }
  void printTest() async {
    // final pdf = await File('assets/files/flutter-succinctly.pdf').readAsBytes();
    // await Printing.layoutPdf(onLayout: (_) => pdf);
    final pdf = await rootBundle.load('assets/files/flutter-succinctly.pdf');
    await Printing.layoutPdf(onLayout: (_) => pdf.buffer.asUint8List());
  }
}