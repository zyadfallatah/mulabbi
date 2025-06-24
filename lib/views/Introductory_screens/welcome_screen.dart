import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/services/user_service.dart';
import 'package:mulabbi/views/auth/login_page.dart';
import 'package:mulabbi/views/auth/singup_page.dart';
import 'package:mulabbi/views/shell/main_scaffold.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserService.registerFirstTime();
    return Scaffold(
      body: Stack(
        children: [
          // 🔹 Background
          Positioned.fill(
            child: Image.asset(
              'assets/images/welcome_background.png', // update with correct image name
              fit: BoxFit.cover,
            ),
          ),

          // 🔹 Overlay content
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 33, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 🔸 Top right icon
                  const Spacer(),

                  // 🔸 Guest Button
                  Container(
                    height: 58,
                    decoration: BoxDecoration(
                      gradient: AppColorBrown.unlocked,
                      borderRadius: BorderRadius.circular(66),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(100, 0, 0, 0),
                          blurRadius: 3,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (_) => MainScaffold(userType: UserType.guest),
                          ),
                        );
                      },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(66),
                        ),
                      ),
                      child: const Text(
                        'المتابعة كضيف',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 4,
                              color: Color.fromARGB(
                                150,
                                0,
                                0,
                                0,
                              ), // soft dark shadow behind text
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔸 Login Button
                  Container(
                    height: 58,
                    decoration: BoxDecoration(
                      color: Color.fromARGB(
                        255,
                        196,
                        181,
                        166,
                      ), // 🔹 Solid fill color
                      borderRadius: BorderRadius.circular(66),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(100, 0, 0, 0),
                          blurRadius: 3,
                          offset: Offset(4, 4),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        Get.to(() => LoginScreen());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(66),
                        ),
                        padding: EdgeInsets.zero,
                      ),
                      child: const Center(
                        child: Text(
                          'تسجيل الدخول',
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 2),
                                blurRadius: 4,
                                color: Color.fromARGB(
                                  150,
                                  0,
                                  0,
                                  0,
                                ), // soft dark shadow behind text
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),

                  // 🔸 Register Text Link
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Get.to(() => SingupPage());
                      },
                      child: const Text(
                        'انشاء حساب جديد',
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.underline,
                          color: Color(0xFF734218),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
