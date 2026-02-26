import 'package:flutter/material.dart';
import 'package:price_updating/utils/global_widget/toast_message.dart';

class ErrorMessage {
  static void message(
      {required String apiName, required Object error, showError = true}) {
    debugPrint('Error from $apiName api service ==> $error');
    String extendedText = showError ? ' => $apiName' : '';
    ToastMessage.error('Something went Wrong!$extendedText');
  }
}
