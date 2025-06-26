import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mulabbi/controllers/quran_controller.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/views/tools_views/quran%20view/surah_indx_view.dart';
import 'package:mulabbi/widgets/tools_widgets/quran_widgets/navButton_widget.dart';
import 'package:mulabbi/widgets/tools_widgets/quran_widgets/quran_widget.dart';
import 'package:quran/quran.dart' as quran;

class QuranPageView extends StatelessWidget {
  const QuranPageView({super.key});

  static const buttonNextColor = AppColorBrown.gradient;
  static const buttonPreColor = AppColorLight.quranNotSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F4EF),
      endDrawer: const SurahDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          color: const Color(0xFF7E5A3B),
          onPressed: () {
            Navigator.pop(context);
          },
        ),

        actions: [
          Builder(
            builder:
                (context) => IconButton(
                  icon: const Icon(Icons.menu_rounded),
                  color: const Color(0xFF7E5A3B),
                  onPressed: () {
                    final controller = Get.find<QuranController>();
                    controller.updateSearch(''); // ⬅️ clear previous search
                    Scaffold.of(context).openEndDrawer();
                  },
                ),
          ),
        ],
        centerTitle: true,
        title: GetX<QuranController>(
          builder:
              (controller) => Text(
                quran.getSurahNameArabic(controller.getSurah()),
                style: const TextStyle(
                  color: Color(0xFF7E5A3B),
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetX<QuranController>(
              builder:
                  (controller) => Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: QuranPageContent(page: controller.page.value),
                  ),
            ),
          ),

          /// ✅ Bottom Navigation Raised Safely
          SafeArea(
            minimum: const EdgeInsets.only(bottom: 20),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 23),
              child: GetX<QuranController>(
                builder:
                    (controller) => Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        NavigationButton(
                          label: 'الصفحة التالية',
                          icon: Icons.arrow_back_ios_new,
                          onTap: () {
                            controller.incrementPage();
                            final getList = quran.getSurahPages(
                              controller.getSurah(),
                            );
                            if (!getList.contains(controller.getPage())) {
                              controller.incrementSurah();
                            }
                          },
                          gradient: AppColorBrown.gradientBrown,
                          textColor: Colors.white,
                        ),

                        // 🟤 Page Number Circle
                        InkWell(
                          onTap: () {
                            final controller = Get.find<QuranController>();
                            final TextEditingController inputController =
                                TextEditingController();

                            showDialog(
                              context: context,
                              builder:
                                  (context) => Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24),
                                    ),
                                    backgroundColor: const Color.fromARGB(
                                      219,
                                      255,
                                      245,
                                      237,
                                    ), // your lavender
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 24.0,
                                        vertical: 20,
                                      ),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Text(
                                            "أدخل رقم الصفحة",
                                            style: TextStyle(
                                              fontFamily: 'Cairo',
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Color(
                                                0xFF5C3A1A,
                                              ), // brown title
                                            ),
                                          ),
                                          const SizedBox(height: 16),
                                          TextField(
                                            controller: inputController,
                                            autofocus: true,
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [
                                              FilteringTextInputFormatter
                                                  .digitsOnly,
                                            ],
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'Cairo',
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xFF5C3A1A),
                                            ),
                                            decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.white,
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                              enabledBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    130,
                                                    60,
                                                    0,
                                                  ), // slightly violet border
                                                  width: 1.3,
                                                ),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                borderSide: const BorderSide(
                                                  color: Color.fromARGB(
                                                    255,
                                                    130,
                                                    60,
                                                    0,
                                                  ),
                                                  width: 1.7,
                                                ),
                                              ),
                                            ),
                                            onSubmitted: (value) {
                                              final int? page = int.tryParse(
                                                value,
                                              );
                                              if (page != null &&
                                                  page >= 1 &&
                                                  page <= 604) {
                                                controller.setPage(page);
                                                for (int s = 1; s <= 114; s++) {
                                                  if (quran
                                                      .getSurahPages(s)
                                                      .contains(page)) {
                                                    controller.setSurah(s);
                                                    break;
                                                  }
                                                }
                                                Navigator.pop(context);
                                              } else {
                                                Navigator.pop(context);
                                                WidgetsBinding.instance
                                                    .addPostFrameCallback((_) {
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          backgroundColor:
                                                              Colors.black87,
                                                          content: Text(
                                                            "رقم الصفحة غير صحيح",
                                                            textAlign:
                                                                TextAlign
                                                                    .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Color.fromARGB(
                                                                    255,
                                                                    236,
                                                                    221,
                                                                    209,
                                                                  ),
                                                              fontFamily:
                                                                  'Cairo',
                                                            ),
                                                          ),
                                                          behavior:
                                                              SnackBarBehavior
                                                                  .floating,
                                                          duration: Duration(
                                                            seconds: 2,
                                                          ),
                                                        ),
                                                      );
                                                    });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            );
                          },

                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(83, 0, 0, 0),
                                  blurStyle: BlurStyle.normal,
                                  blurRadius: 4.0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                              shape: BoxShape.circle,
                              color: const Color.fromARGB(219, 234, 223, 208),
                              border: Border.all(color: Color(0xFF8D511E)),
                            ),
                            child: Text(
                              controller.page.value.toString(),
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF7E5A3B),
                              ),
                            ),
                          ),
                        ),

                        NavigationButton(
                          label: 'الصفحة السابقة',
                          icon:
                              Icons
                                  .arrow_forward_ios, // this is the RTL direction → right arrow
                          onTap: () {
                            controller.decrementPage();
                            final getList = quran.getSurahPages(
                              controller.getSurah(),
                            );
                            if (!getList.contains(controller.getPage())) {
                              controller.decrementSurah();
                            }
                          },
                          color: const Color(
                            0xFFDED2C2,
                          ), // background from Figma
                          textColor: const Color(0x66000000), // 40% black
                        ),
                      ],
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
