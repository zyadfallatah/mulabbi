import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mulabbi/main.dart';
import 'package:mulabbi/models/nusk_details.dart';
import 'package:mulabbi/services/user_service.dart';
import 'package:mulabbi/views/shell/main_scaffold.dart';
import 'package:mulabbi/widgets/loader.dart';

class TrackController extends GetxController {
  String? currentUserId;
  RxInt currentStep = 1.obs;
  Steps? stepInfo;
  int progressId = -1;
  bool isTrackActive = false;
  bool isPending = false;
  String type = "";

  List<nusks_details> nusks = [];

  void reset() {
    currentUserId = null;
    progressId = -1;
    isTrackActive = false;
    isPending = false;
    type = "";
    currentStep.value = 1;
    stepInfo = null;
  }

  Future<void> getUserCurrentStep(BuildContext? context) async {
    final user = await UserService.getCurrentUser();
    currentUserId = user?.id;
    try {
      final doesUserExist = await supabase
          .from("users")
          .select("id")
          .eq("id", currentUserId!);
      doesUserExist.first; // if there's nothing it will throw error
    } catch (e) {
      currentUserId = null;
      return;
    }
    if (context != null) {
      showDialog(
        context: context,
        builder: (context) => Loader(text: "يتم تحميل البيانات..."),
      );
    }
    try {
      final response = await supabase
          .from("user_nusuk_progress")
          .select('''
    user_nusuk_pr_id,
    step_number,
    completed_at,
    user_nusuk (
      user_id,
      nusuk_id (
        nusuk_type
      )
    )
''')
          .eq("user_id", currentUserId!)
          .or("completed_at.is.null");
      final data = response.first;
      if (data["completed_at"] != null || data["user_nusuk"] == null) {
        isTrackActive = false;
        throw Error();
      }

      // data look like this: {step_number: 1, user_nusuk: {nusuk_id: {nusuk_type: ifrad}}}
      isTrackActive = true;
      currentStep.value = data["step_number"];
      type = data["user_nusuk"]["nusuk_id"]["nusuk_type"];
      progressId = data["user_nusuk_pr_id"];
      await getStepInfo();
    } catch (e) {}
  }

  Future<void> setNuskDetails(String type) async {
    try {
      final String jsonString = await rootBundle.loadString(
        'lib/data/nusk_details.json',
      );
      final List<dynamic> jsonData = json.decode(jsonString);
      nusks = jsonData.map((json) => nusks_details.fromJson(json)).toList();
      nusks = nusks.where((nusk) => nusk.type == type).toList();
      update();
      // ignore: empty_catches
    } catch (e) {}
  }

  Future<void> getStepInfo() async {
    await setNuskDetails(type);
    if (nusks.isEmpty) {
      return;
    }
    stepInfo = nusks.first.steps?.elementAt(getCurrentStep() - 1);
  }

  int getCurrentStep() {
    return currentStep.toInt();
  }

  Future<void> incrementStep() async => {
    if (!isPending)
      {
        isPending = true,

        await supabase
            .from("user_nusuk_progress")
            .update({"step_number": getCurrentStep() + 1})
            .eq("user_nusuk_pr_id", progressId),

        currentStep.value = getCurrentStep() + 1,
        isPending = false,
      },
  };

  void registerNewTrack(int nusukId) async {
    if (isPending && isTrackActive) return;

    isPending = true;
    if (currentUserId == null) {
      Get.offUntil(
        MaterialPageRoute(
          builder: (context) => MainScaffold(userType: UserType.user, index: 2),
        ),
        (route) => false,
      );
      ;
      return;
    }

    final nusuk = await supabase
        .from("user_nusuk")
        .insert({"user_id": currentUserId, "nusuk_id": nusukId})
        .select('''
                        user_nusuk_id,
                        nusuk_id(
                          nusuk_type  
                        )
                      ''');
    final progress =
        await supabase.from("user_nusuk_progress").insert({
          "user_id": currentUserId,
          "user_nusuk_id": nusuk.first["user_nusuk_id"],
          "step_number": 1,
        }).select();
    progressId = progress.first["user_nusuk_pr_id"];
    type = nusuk.first["nusuk_id"]["nusuk_type"];
    currentStep.value = 1;
    isTrackActive = true;
    Get.offUntil(
      MaterialPageRoute(
        builder: (context) => MainScaffold(userType: UserType.user, index: 2),
      ),
      (route) => false,
    );
    isPending = false;
  }

  void endTracking(BuildContext context) async {
    await supabase
        .from("user_nusuk_progress")
        .update({"completed_at": DateTime.now().toString()})
        .eq("user_nusuk_pr_id", progressId);

    currentStep.value = 1;
    progressId = -1;
    type = "";
    isTrackActive = false;
    isPending = false;
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MainScaffold(userType: UserType.user),
      ),
      (route) => false,
    );
  }
}
