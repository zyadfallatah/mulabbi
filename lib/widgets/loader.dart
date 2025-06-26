import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class Loader extends StatelessWidget {
  const Loader({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          gradient: AppColorLight.greyGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            spacing: 12,
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text),
              CircularProgressIndicator(
                color: AppColorBrown.gradientColors.first,
                backgroundColor: AppColorBrown.angularGoldColors.first,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
