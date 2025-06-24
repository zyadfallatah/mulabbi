import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/views/track_views/ifrad_view.dart';
import 'package:mulabbi/views/track_views/qeran_view.dart';
import 'package:mulabbi/views/track_views/tmatoa_view.dart';
import 'package:mulabbi/views/track_views/umrah_view.dart';
import 'package:mulabbi/widgets/track_widgets/track_fallaback_not_authorized.dart';
import 'package:mulabbi/widgets/track_widgets/track_fallback_non_active.dart';

class TrackEntryView extends StatelessWidget {
  const TrackEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    late final trackController = Get.put(TrackController());

    Widget render = Stack(
      alignment: Alignment.center,
      children: [
        Image.asset("assets/images/track_page.png"),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 40,
          children: [
            Text(
              "ملبي \n رحلة مناسكك خطوة بخطوة",
              style: TextStyle(
                color: Color(0xFF7E573B),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            CircularProgressIndicator(color: Color(0xFF7E573B)),
          ],
        ),
      ],
    ); // init state + Track checks everything

    return Scaffold(
      body: FutureBuilder(
        future: trackController.getUserCurrentStep(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    "assets/images/track_page.png",
                    width: 600,
                    fit: BoxFit.cover,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 40,
                    children: [
                      Text(
                        "ملبي \n رحلة مناسكك خطوة بخطوة",
                        style: TextStyle(
                          color: Color(0xFF7E573B),
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      CircularProgressIndicator(color: Color(0xFF7E573B)),
                    ],
                  ),
                ],
              ),
            );
          }
          if (!trackController.isTrackActive &&
              trackController.currentUserId != null) {
            render = TrackFallbackNonActive();
          }
          if (trackController.currentUserId == null) {
            render = TrackFallbackNotAuthorized();
          }
          if (snapshot.connectionState == ConnectionState.done &&
              trackController.isTrackActive) {
            switch (trackController.type) {
              case "ifrad":
                render = IfradView();
                break;
              case "qeran":
                render = QeranView();
                break;
              case "tamatoa":
                render = TmatoaView();
                break;
              case "umrah":
                render = UmrahView();
              default:
                render = TrackFallbackNonActive();
            }
          }

          return render;
        },
      ),
    );
  }
}
