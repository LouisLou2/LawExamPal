import 'package:easy_cse/gui/widget/decorations/color_bar.dart';
import 'package:flutter/material.dart';

import '../../../constant/app_style/app_color.dart';

Future<PersistentBottomSheetController> showCustomBottomSheet(
    BuildContext context,
    {double? height,
      Widget? child,
      VoidCallback? onClosing,
      Widget? toolBar,
    }
) async {
  return showBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    elevation: 0,
    enableDrag: true,
    builder: (BuildContext context){
      return Stack(
        alignment:Alignment.center ,
        fit: StackFit.loose, //未定位widget占满Stack整个空间
        children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(
                style: BorderStyle.solid,
                color: AppColors.silenceColor,
                width: 0.6,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.silenceColor,
                offset: Offset(0, 0),
                blurRadius: 5.0,
              ),
            ],
            color: AppColors.white0,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          height: height??MediaQuery.of(context).size.height / 1.5,
          child: Column(
            children: [
              SizedBox(
                height: 30,
                child: Stack(
                  textDirection: TextDirection.rtl,
                  children: [
                    Center(
                      child: ColorBar(
                        width: MediaQuery.of(context).size.width / 7,
                        height: 5,
                        radius: 20,
                        color: AppColors.darkText1,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: onClosing,
                    ),
                  ],
                ),
              ),
              child??const SizedBox(),
            ]),
          ),
          if (toolBar != null)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: toolBar,
            ),
          ],
      );
    },
  );
}