import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 验证码输入框
class CodeInputContainer extends StatefulWidget {
  final int count;
  final String phone;
  final Function(String code) onResult;
  /// 重新发起获取验证码
  /// [return] 是否发起"获取验证码"操作成功
  final Future<bool> Function() onRestart;

  const CodeInputContainer({
    super.key,
    required this.count,
    required this.phone,
    required this.onResult,
    required this.onRestart,
  });

  @override
  State createState() => _CodeInputContainerState();
}

class _CodeInputContainerState extends State<CodeInputContainer> with WidgetsBindingObserver {
  late final ValueNotifier<String> code = ValueNotifier('');
  late FocusNode inputFocus = FocusNode();

  bool restart = false;
  Timer? timer;
  final int seconds = 60;
  late final ValueNotifier<int> timeCount = ValueNotifier(seconds);
  DateTime? pausedTime;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeCount.value--;
      if (timeCount.value <= 0) {
        timer.cancel();
        timeCount.value = seconds;
        code.value = '';
        setState(() {
          restart = true;
        });
      }
    });
  }

  String handlePhone(String phone) {
    if (phone.length == 11) {
      return '${phone.substring(0, 3)} ${phone.substring(3, 7)} ${phone.substring(7, 11)}';
    } else {
      return phone;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      inputFocus.requestFocus();
      startTimer();
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    /// 适配页面切换、熄屏时倒计时混乱问题
    if (state == AppLifecycleState.resumed) {
      if (pausedTime != null) {
        int seconds = DateTime.now().difference(pausedTime!).inSeconds;
        pausedTime = null;
        timeCount.value = max(0, timeCount.value - seconds);
        startTimer();
      }
    } else if (state == AppLifecycleState.paused) {
      timer?.cancel();
      pausedTime = DateTime.now();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer?.cancel();
    inputFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '输入验证码',
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '验证码已发送至 ${handlePhone(widget.phone)}',
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          const SizedBox(height: 20),
          buildCodeInput(),
          const SizedBox(height: 100),
          GestureDetector(
            onTap: () {
              /// 点击时弹出输入键盘
              SystemChannels.textInput.invokeMethod('TextInput.show');
              inputFocus.requestFocus();
            },
            child: buildCodeView(),
          ),
          const SizedBox(height: 15),
          if (!restart)
            ValueListenableBuilder<int>(
              valueListenable: timeCount,
              builder: (context, value, child) {
                return Text(
                  '$value 秒后可重新获取',
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                );
              },
            ),
          if (restart)
            GestureDetector(
              onTap: () async {
                if (await widget.onRestart.call()) {
                  setState(() {
                    restart = false;
                  });
                  startTimer();
                }
              },
              child: const Text(
                '重新发送',
                style: TextStyle(color: Colors.red, fontSize: 13),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildCodeInput() {
    return SizedBox(
      height: 20,
      width: 100,
      child: TextField(
        style: const TextStyle(color: Colors.green),
        controller: TextEditingController(text: code.value),
        focusNode: inputFocus,
        maxLength: widget.count,
        keyboardType: TextInputType.number,
        // 禁止长按复制
        enableInteractiveSelection: false,
        decoration: const InputDecoration(
          counterText: '',
          border: OutlineInputBorder(borderSide: BorderSide.none),
        ),
        inputFormatters: [
          // 只允许输入数字
          FilteringTextInputFormatter(RegExp("^[0-9]*\$"), allow: true)
        ],
        onChanged: (v) async {
          code.value = v;
          if (v.length == widget.count) widget.onResult.call(v);
        },
      ),
    );
  }

  Widget buildCodeView() {
    return ValueListenableBuilder<String>(
      valueListenable: code,
      builder: (context, value, child) {
        return GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: widget.count,
          scrollDirection: Axis.vertical,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisSpacing: 8,
          childAspectRatio: 0.95,
          children: List.generate(widget.count, (int i) => i).map((index) {
            return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.red.shade200,
                border: ((index < widget.count && index == value.length) ||
                    (inputFocus.hasFocus && value.isEmpty && index == 0))
                    ? Border.all(width: 1, color: Colors.red)
                    : null,
                borderRadius: BorderRadius.circular(8),
              ),
              child: (value.length > index)
                  ? Text(
                value[index],
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              )
                  : null,
            );
          }).toList(),
        );
      },
    );
  }
}