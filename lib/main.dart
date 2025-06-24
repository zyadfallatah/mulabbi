import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:mulabbi/views/Introductory_screens/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im15Y2puZXZuaWRnZWtsY2VnaHNiIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDcyOTIzNDYsImV4cCI6MjA2Mjg2ODM0Nn0.Zo0bOAvWcEw3MdjFUPn9clJd23ntp1iJsoDEri3mrRE",
    url: "https://mycjnevnidgeklceghsb.supabase.co",
  );

  await storage.remove("tempId");
  // await storage.remove("notConfirmedEmail");
  // await storage.remove("notConfirmedEmailName");

  runApp(MyApp());
}

final supabase = Supabase.instance.client;
final storage = SharedPreferencesAsync();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Cairo"),
      home: SplashScreen(),
    );
  }
}
