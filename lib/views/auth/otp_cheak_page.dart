import 'package:flutter/material.dart';
import 'package:mulabbi/controllers/otp_controller.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/widgets/auth_widgets/auth_custom.dart';
import 'package:mulabbi/widgets/tools_widgets/button_custom.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({
    super.key,
    required this.id,
    required this.name,
    required this.email,
  });

  final String? id;
  final String name;
  final String email;
  static const focusColor = AppColorBrown.gradientBrown;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OtpController()); // استخدم GetX Controller
    controller.startTimer();
    return AuthContainer(
      title: "تأكيد الحساب",
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 3, right: 3, bottom: 6),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            const Text(
              "أدخل رمز التحقق المرسل إلى بريدك الإلكتروني",
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 14,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return SizedBox(
                  width: 43,
                  child: TextField(
                    controller: controller.codeControllers[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        FocusScope.of(context).nextFocus();
                      }
                    },
                    cursorColor: Color(0xFF7E5A3B),
                    decoration: InputDecoration(
                      focusColor: Color.fromARGB(146, 126, 90, 59),
                      counterText: '',
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: const Color.fromARGB(133, 158, 158, 158),
                          width: 1,
                        ),
                      ),
                      //لما يجي عليه فوكس
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: OtpScreen.focusColor.colors[0],
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 50),
            Obx(() {
              return Column(
                children: [
                  controller.canResend.value
                      ? TextButton(
                        onPressed: () => controller.resendOtp(email),
                        child: const Text(
                          "إعادة إرسال الرمز",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF7E5A3B),
                            color: Color(0xFF5D4037),
                            fontFamily: 'Cairo',
                            fontSize: 13,
                          ),
                        ),
                      )
                      : Text(
                        "يمكنك إعادة إرسال الرمز بعد ${controller.secondsRemaining} ثانية",
                        style: const TextStyle(
                          color: Color.fromARGB(255, 105, 105, 105),
                          fontFamily: 'Cairo',
                          fontSize: 13,
                        ),
                      ),
                ],
              );
            }),
            SizedBox(height: 40),
            Align(
              alignment: Alignment.bottomCenter,
              child: SizedBox(
                width: 184,
                height: 51,
                child: PrimaryButton(
                  text: "تحقق",
                  gradient: AppColorBrown.gradientBrown,
                  onPressed: () async {
                    try {
                      await controller.verifyOtp(email);

                      final res = await supabase.auth.getUser(id!);
                      print(res);
                      if (res.user?.emailConfirmedAt != null) {
                        // Email is confirmed
                        await supabase.from('users').insert({
                          'id': id,
                          'name': name,
                          'email': email,
                        });
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
