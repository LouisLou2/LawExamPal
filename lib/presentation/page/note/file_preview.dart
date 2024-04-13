import 'dart:io';

import 'package:easy_cse/constant/app_style/app_icons.dart';
import 'package:easy_cse/presentation/widget/buttons/icon_text_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:printing/printing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../constant/app_string.dart';
import '../../../constant/app_style/app_color.dart';

class FilePreviewPage extends StatefulWidget {
  final String path;
  const FilePreviewPage({super.key, required this.path});
  @override
  State<FilePreviewPage> createState() => _FilePreviewPageState();
}
class _FilePreviewPageState extends State<FilePreviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.previewNote),
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
      body: SfPdfViewer.file(File(widget.path)),
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
                  text: '${AppStrings.transTo}${AppStrings.word}',
                  color: AppColors.silentBlue,
                  size: 50,
              ),
              IconTextButton(
                icon: AppIcons.file_pdf,
                text: '${AppStrings.transTo}${AppStrings.pdf}',
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
    final result = await Share.shareXFiles(
        [XFile(widget.path)],
        text: AppStrings.shareText
    );
    if (result.status == ShareResultStatus.success) {
      print(AppStrings.shareDone);
    }
  }
  void printTest() async {
    final pdfUni8List = await File(widget.path).readAsBytes();
    await Printing.layoutPdf(
      onLayout: (_) => pdfUni8List,
      usePrinterSettings: true,
    );
    // for asset pdf: deprecated
    // final pdf = await rootBundle.load(widget.path);
    // await Printing.layoutPdf(
    //   onLayout: (_) => pdf.buffer.asUint8List(),
    //   usePrinterSettings: true,
    // );
  }
}