
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:price_updating/utils/colors/app_colors.dart';
import 'package:price_updating/utils/sizes/k_sizes.dart';
import 'package:price_updating/utils/text_styles/text_font_style.dart';

class ToastMessage {
  static final double _padding = 8.w;
  static final double _borderWidth = 1.w;
  static final double _borderRadius = 10.r;
  static const double _opacity = 0.5;
  static const Color _colorText = KColors.white;
  static const int _duration = 1500;
  static const bool _shouldIconPulse = true;

  static success(String message) {
    return Get.snackbar(
      '',
      '',
      titleText: Text('Success', style: TextFontStyle.textMD16w500BlackManrope),
      messageText: Text(message, style: TextFontStyle.textMD16w500BlackManrope),
      padding: EdgeInsets.all(_padding),
      borderWidth: _borderWidth,
      borderRadius: _borderRadius,
      borderColor: KColors.grey,
      backgroundColor: KColors.white.withOpacity(_opacity),
      colorText: _colorText,
      icon: const Icon(Icons.done_outline_outlined, color: Colors.green),
      duration: const Duration(milliseconds: _duration),
      shouldIconPulse: _shouldIconPulse,
    );
  }

  static error(String message) {
    return Get.snackbar(
      '',
      '',
      titleText: Text('Alert', style: TextFontStyle.textMD16w500BlackManrope),
      messageText: Text(message, style: TextFontStyle.textMD16w500BlackManrope),
      padding: EdgeInsets.all(_padding),
      borderWidth: _borderWidth,
      borderRadius: _borderRadius,
      borderColor: KColors.grey,
      backgroundColor: KColors.background,
      colorText: _colorText,
      icon: const Icon(Icons.error_outlined, color: Colors.red),
      duration: const Duration(milliseconds: _duration),
      shouldIconPulse: _shouldIconPulse,
    );
  }

  static loading() {
    return Get.showSnackbar(
      GetSnackBar(
        message: "",
        messageText: Center(
          child: Text(
            'Loading...',
            style: TextFontStyle.textMD16w500BlackManrope,
          ),
        ),
        duration: const Duration(seconds: 2),
        maxWidth: KSizes.kScreenWidth * .35,
        borderRadius: 50.r,
        padding: EdgeInsets.all(KSizes.hGapSmall),
        margin: EdgeInsets.only(bottom: 40.h),
      ),
    );
  }
}
