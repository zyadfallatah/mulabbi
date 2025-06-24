import 'package:flutter/material.dart';
import 'package:mulabbi/core/colors.dart';

class AuthContainer extends StatelessWidget {
  final String title;
  final Widget child;
  final double? cardHeight;
  final double? cardWidth;

  const AuthContainer({
    super.key,
    required this.title,
    required this.child,
    this.cardHeight,
    this.cardWidth,
  });

  static const colorBox = AppColorBrown.gradientPrimary;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/welcome_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 360,
              height: 650,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  // البطاقة البنية الكبيرة بالخلفية
                  Positioned(
                    top: 70,
                    child: Container(
                      width: 360,
                      height: 400,
                      decoration: BoxDecoration(
                        gradient: colorBox,
                        borderRadius: BorderRadius.circular(55),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // البطاقة البيضاء المتداخلة فوق البنية
                  Positioned(
                    top: 150,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Container(
                        width: cardWidth ?? 388,
                        padding: const EdgeInsets.all(24),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF5D4037),
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(55),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xFF7E5A3B),
                              blurRadius: 15,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: child,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
