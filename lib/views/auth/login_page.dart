import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/views/auth/otp_cheak_page.dart';
import 'package:mulabbi/views/auth/singup_page.dart';
import 'package:mulabbi/views/shell/main_scaffold.dart';
// import 'package:mulabbi/views/shell/main_scaffold.dart';
import 'package:mulabbi/widgets/auth_widgets/auth_custom.dart';
import 'package:mulabbi/widgets/tools_widgets/button_custom.dart';
import 'package:mulabbi/widgets/auth_widgets/textfield_custom.dart';

import 'package:supabase_flutter/supabase_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const buttonColor = AppColorBrown.gradient;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      title: "تسجيل الدخول",
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              textDirection: TextDirection.rtl,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 12),
                CustomTextField(
                  label: "*البريد الإلكتروني",
                  hint: "أدخل بريدك الإلكتروني",
                  keyboardType: TextInputType.emailAddress,
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال البريد الإلكتروني';
                    }
                    if (!GetUtils.isEmail(value)) {
                      return 'الرجاء إدخال بريد إلكتروني صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 17),
                CustomTextField(
                  label: "*كلمة المرور",
                  hint: "ادخل كلمة المرور",
                  obscureText: true,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال كلمة المرور';
                    }

                    if (value.length < 6) {
                      return 'يجب أن لا تقل كلمة المرور عن 6 حروف';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 1),
                Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text(
                        "نسيت كلمة المرور؟",
                        style: TextStyle(
                          color: Color(0xFF69494B),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF69494B),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text(
                      'تذكرني',
                      style: TextStyle(color: Color(0xFF734218)),
                    ),
                    Checkbox(
                      value: _rememberMe,
                      onChanged: (bool? value) {
                        setState(() {
                          _rememberMe = value ?? false;
                        });
                      },
                      hoverColor: Color(0xFF734218),
                      checkColor: Colors.white,
                      activeColor: const Color(0xFF734218),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                Center(
                  child: SizedBox(
                    width: 200,
                    height: 50,
                    child: PrimaryButton(
                      text: "تسجيل",
                      gradient: AppColorBrown.gradientBrown,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            if (await storage.getString("notConfirmedEmail") ==
                                emailController.text) {
                              final res = await supabase.auth.signUp(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                              final storedName = await storage.getString(
                                "notConfirmedEmailName",
                              );
                              Get.offUntil(
                                MaterialPageRoute(
                                  builder:
                                      (context) => OtpScreen(
                                        id: res.user?.id,
                                        name: storedName!,
                                        email: emailController.text,
                                      ),
                                ),
                                (route) => false,
                              );
                              return;
                            }
                            final AuthResponse response = await supabase.auth
                                .signInWithPassword(
                                  email: emailController.text,
                                  password: passwordController.text,
                                );
                            await storage.setString(
                              'token',
                              response.session!.accessToken,
                            );

                            Get.to(() => MainScaffold(userType: UserType.user));
                          } on AuthException catch (e) {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => Dialog(
                                    child: Container(
                                      decoration: BoxDecoration(
                                        gradient: AppColorLight.greyGradient,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          spacing: 12,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              "خطأ في تسجيل الدخول",
                                              style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    AppColorBrown
                                                        .gradientColors
                                                        .first,
                                              ),
                                            ),
                                            Text(
                                              "المعلومات المدخلة غير صحيحة",
                                              textAlign: TextAlign.center,
                                            ),
                                            TextButton(
                                              onPressed:
                                                  () =>
                                                      Navigator.of(
                                                        context,
                                                      ).pop(),
                                              child: Text(
                                                "حسناً",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      AppColorBrown
                                                          .gradientColors
                                                          .first,
                                                ),
                                                textDirection:
                                                    TextDirection.rtl,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                            );
                          } catch (e) {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => AlertDialog(
                                    title: const Text("خطأ غير متوقع"),
                                    content: const Text(
                                      "حدث خطأ غير متوقع, يرجى المحاولة مرة أخرى",
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed:
                                            () => Navigator.of(context).pop(),
                                        child: const Text("حسناً"),
                                      ),
                                    ],
                                  ),
                            );
                          }
                        }
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SingupPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "إنشاء حساب",
                        style: TextStyle(
                          color: Color(0xFF8D511E),
                          decoration: TextDecoration.underline,
                          decorationColor: Color(0xFF8D511E),
                        ),
                      ),
                    ),
                    Text(
                      'لا تمتلك حساب؟',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
