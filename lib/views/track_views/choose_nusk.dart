import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/widgets/loader.dart';

class ChooseNuskView extends StatelessWidget {
  const ChooseNuskView({super.key});

  @override
  Widget build(BuildContext context) {
    final trackController = Get.put(TrackController());
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset("assets/images/track_page.png"),
          Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 40,
              children: [
                Container(
                  alignment: Alignment.center,
                  width: 337,
                  height: 62,
                  decoration: BoxDecoration(
                    gradient: AppColorBrown.gradientPrimary,
                    borderRadius: BorderRadius.circular(66),
                  ),
                  child: Text(
                    "حدد نوع الحج",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),

                Column(
                  spacing: 28,
                  children: [
                    InkWell(
                      onTap: () {
                        if (trackController.isPending) return;
                        trackController.isPending = true;
                        showDialog(
                          context: context,
                          builder:
                              (context) => Loader(
                                text: "جاري إنشاء رحلتك لنسك الإفراد...",
                              ),
                        );
                        trackController.registerNewTrack(1);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 337,
                        height: 62,
                        decoration: BoxDecoration(
                          color: Color(0x06CB9052),
                          border: Border.all(color: Color(0xFF7E5A3B)),
                          borderRadius: BorderRadius.circular(66),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "حج الإفراد            ",
                                style: TextStyle(
                                  color: Color(0xFF7E5A3B),
                                  fontFamily: "Cairo",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: "(حج فقط)",
                                style: TextStyle(
                                  color: Color(0xFF7E5A3B),
                                  fontFamily: "Cairo",
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        if (trackController.isPending) return;
                        trackController.isPending = true;
                        showDialog(
                          context: context,
                          builder:
                              (context) => Loader(
                                text: "جاري إنشاء رحلتك لنسك القران...",
                              ),
                        );
                        trackController.registerNewTrack(2);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 337,
                        height: 62,
                        decoration: BoxDecoration(
                          color: Color(0x06CB9052),
                          border: Border.all(color: Color(0xFF7E5A3B)),
                          borderRadius: BorderRadius.circular(66),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "حج القِران    ",
                                style: TextStyle(
                                  color: Color(0xFF7E5A3B),
                                  fontFamily: "Cairo",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: "(عمرة + حج معًا)",
                                style: TextStyle(
                                  color: Color(0xFF7E5A3B),
                                  fontFamily: "Cairo",
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        if (trackController.isPending) return;
                        trackController.isPending = true;
                        showDialog(
                          context: context,
                          builder:
                              (context) => Loader(
                                text: "جاري إنشاء رحلتك لنسك التمتع...",
                              ),
                        );
                        trackController.registerNewTrack(3);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 337,
                        height: 62,
                        decoration: BoxDecoration(
                          color: Color(0x06CB9052),
                          border: Border.all(color: Color(0xFF7E5A3B)),
                          borderRadius: BorderRadius.circular(66),
                        ),
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "حج التمتع       ",
                                style: TextStyle(
                                  color: Color(0xFF7E5A3B),
                                  fontFamily: "Cairo",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                              TextSpan(
                                text: "(عمرة ثم حج)",
                                style: TextStyle(
                                  color: Color(0xFF7E5A3B),
                                  fontFamily: "Cairo",
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
