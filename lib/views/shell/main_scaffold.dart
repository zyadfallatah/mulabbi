import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/track_controller.dart';
import 'package:mulabbi/views/home_views/guest_home.dart';
import 'package:mulabbi/views/settings_views/guest_settings%20page.dart';
import 'package:mulabbi/views/settings_views/settings_page.dart';
import 'package:mulabbi/views/shell/bottom_nav_bar.dart';
import 'package:mulabbi/views/track_views/track_entry_view.dart';
import 'package:mulabbi/views/zad_views/zad_page_view.dart';

enum UserType { guest, user, onJourney }

class MainScaffold extends StatefulWidget {
  final UserType userType;
  final int? index;

  const MainScaffold({super.key, required this.userType, this.index});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _selectedIndex = 3;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.index ?? 3;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    final trackContoller = Get.put(TrackController());
    trackContoller.getUserCurrentStep(null);
    switch (index) {
      case 0: // الإعدادات
        return trackContoller.currentUserId != null
            ? SettingsPage()
            : GuestSettingsPage();
      case 1: // زاد
        return ZadPageView();
      case 2: // المسار
        return TrackEntryView();

      case 3: // الرئيسية
        return GuestHome();
      default:
        return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getPage(_selectedIndex),
      bottomNavigationBar: MulabbiBottomNavBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
