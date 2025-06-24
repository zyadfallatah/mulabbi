import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mulabbi/core/colors.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/views/auth/otp_cheak_page.dart';
import 'package:mulabbi/views/auth/policy_page.dart';
import 'package:mulabbi/widgets/auth_widgets/auth_custom.dart';
import 'package:mulabbi/widgets/auth_widgets/textfield_custom.dart';
import 'package:mulabbi/widgets/tools_widgets/button_custom.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SingupPage extends StatefulWidget {
  const SingupPage({super.key});

  @override
  State<SingupPage> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<SingupPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _agree = false;
  late TapGestureRecognizer _policyRecognizer;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _policyRecognizer =
        TapGestureRecognizer()
          ..onTap = () {
            Get.to(() => const PolicyPage());
          };
  }

  @override
  void dispose() {
    _policyRecognizer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthContainer(
      title: "إنشاء حساب",
      cardWidth: 400,
      cardHeight: 500,
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 4, right: 4, bottom: 6),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const SizedBox(height: 1),
              CustomTextField(
                label: "*الاسم الكامل",
                hint: "أدخل اسمك الكامل",
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'الرجاء إدخال الاسم الكامل';
                  }
                  if (value.length < 2) {
                    return 'الاسم الكامل يجب أن يكون أكثر من حرفين';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              CustomTextField(
                label: "*كلمة المرور",
                hint: "••••••••",
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
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'عند التسجيل فإني أوافق على ',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontFamily: 'Cairo',
                      ),
                      children: [
                        TextSpan(
                          text: 'الشروط والأحكام',
                          style: const TextStyle(
                            color: Color(0xFF8D511E),
                            decoration: TextDecoration.underline,
                            decorationColor: Color(0xFF8D511E),
                            fontWeight: FontWeight.w600,
                          ),
                          recognizer: _policyRecognizer,
                        ),
                      ],
                    ),
                  ),
                  Checkbox(
                    value: _agree,
                    onChanged: (bool? value) {
                      setState(() {
                        _agree = value ?? false;
                      });
                    },
                    hoverColor: const Color(0xFF734218),
                    checkColor: Colors.white,
                    activeColor: const Color(0xFF734218),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                    semanticLabel: 'عند التسجيل فإني أوافق على الشروط والأحكام',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  width: 184,
                  height: 51,
                  child: PrimaryButton(
                    text: "إنشاء حساب",
                    gradient: AppColorBrown.gradientBrown,
                    onPressed: () async {
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }
                      if (!_agree) {
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "خطأ في التسجيل",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppColorBrown
                                                    .gradientColors
                                                    .first,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "يجب الموافقة على الشروط والأحكام",
                                          textAlign: TextAlign.center,
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(context).pop(),
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
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        );
                        return;
                      }
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
                                    spacing: 12,
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("جاري تسجيل الحساب..."),
                                      CircularProgressIndicator(
                                        color:
                                            AppColorBrown.gradientColors.first,
                                        backgroundColor:
                                            AppColorBrown
                                                .angularGoldColors
                                                .first,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                      );
                      try {
                        final res = await supabase.auth.signUp(
                          email: emailController.text,
                          password: passwordController.text,
                        );
                        await supabase.from('users').insert({
                          'id': res.user?.id,
                          'name': nameController.text,
                          'email': emailController.text,
                        });
                        // await storage.setString(
                        //   "notConfirmedEmail",
                        //   emailController.text,
                        // );
                        // await storage.setString(
                        //   "notConfirmedEmailName",
                        //   nameController.text,
                        // );

                        Get.offUntil(
                          MaterialPageRoute(
                            builder:
                                (context) => OtpScreen(
                                  id: res.user?.id,
                                  name: nameController.text,
                                  email: emailController.text,
                                ),
                          ),
                          (route) => false,
                        );
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "خطأ في التسجيل",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppColorBrown
                                                    .gradientColors
                                                    .first,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "المعلومات المدخلة غير صحيحة أو البريد مستخدم مسبقاً",
                                          textAlign: TextAlign.center,
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(context).pop(),
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
                                            textDirection: TextDirection.rtl,
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
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "خطأ غير متوقع",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color:
                                                AppColorBrown
                                                    .gradientColors
                                                    .first,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        const Text(
                                          "حدث خطأ غير متوقع, يرجى المحاولة مرة أخرى",
                                          textAlign: TextAlign.center,
                                        ),
                                        TextButton(
                                          onPressed:
                                              () => Navigator.of(context).pop(),
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
                                            textDirection: TextDirection.rtl,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
