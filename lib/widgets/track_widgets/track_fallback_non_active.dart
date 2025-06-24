import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/views/track_views/choose_nusk.dart';

class TrackFallbackNonActive extends StatelessWidget {
  const TrackFallbackNonActive({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TrackController());
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.center,
      children: [
        Image.asset(
          "assets/images/track_page.png",
          width: 600,
          fit: BoxFit.cover,
        ),
        Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ShaderMask(
              shaderCallback:
                  (bounds) => AppColorBrown.gradientBrown.createShader(bounds),
              child: Text(
                "لا يوجد لديك رحلة!",
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              "تابع مناسكك خطوة بخطوة عند \nبدء رحلتك للحج أو العمرة",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, color: Colors.black87),
            ),
            SizedBox(height: 24),
            InkWell(
              onTap: () {
                Get.to(() => ChooseNuskView());
              },
              child: Container(
                width: 246,
                height: 58,
                decoration: BoxDecoration(
                  gradient: AppColorBrown.hajj,
                  borderRadius: BorderRadius.circular(66),
                ),
                child: Row(
                  spacing: 20,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 30),
                    Text(
                      "ابدأ رحلة الحج",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            InkWell(
              onTap: () async {
                if (controller.isPending) return;
                controller.isPending = true;
                controller.registerNewTrack(4);
              },
              child: Container(
                width: 246,
                height: 58,
                decoration: BoxDecoration(
                  gradient: AppColorGrey.umrah,
                  borderRadius: BorderRadius.circular(66),
                ),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Icon(Icons.add, color: Colors.white, size: 30),
                    Text(
                      "ابدأ رحلة العمرة",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
