import 'package:flutter/material.dart';
import 'package:price_updating/utils/colors/app_colors.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
          dismissible: false,
          // ignore: deprecated_member_use
        ),
        const Center(child: CircularProgressIndicator(color: KColors.white)),
      ],
    );
  }
}
