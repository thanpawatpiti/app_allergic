import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:allergic_app/localization/locale_constant.dart';
import 'package:allergic_app/views/onboarding_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

class ChooseLanguate extends StatefulWidget {
  const ChooseLanguate({super.key});

  @override
  State<ChooseLanguate> createState() => _ChooseLanguateState();
}

class _ChooseLanguateState extends State<ChooseLanguate> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future<OkCancelResult> showAlertDialog(
      BuildContext context, String languate) async {
    return await showOkCancelAlertDialog(
      context: context,
      title: languate == 'English' ? 'Choose Language' : 'เลือกภาษา',
      message: languate == 'English'
          ? 'Your language is "$languate"'
          : 'ภาษาของคุณคือ "$languate"',
      okLabel: languate == 'English' ? 'OK' : 'ตกลง',
      cancelLabel: languate == 'English' ? 'Cancel' : 'ยกเลิก',
      isDestructiveAction: true,
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await showAlertDialog(context, 'English');
                  if (result == OkCancelResult.ok) {
                    changeLanguage(context, 'en');
                    storage.write(key: 'language', value: 'en');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const OnBoardingScreen()),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10.h,
                  backgroundImage:
                      AssetImage('assets/images/united-states.png'),
                ),
              ),
              Text('English', style: TextStyle(fontSize: 10.sp)),
              SizedBox(
                height: 20.h,
              ),
              GestureDetector(
                onTap: () async {
                  final result = await showAlertDialog(context, 'ภาษาไทย');
                  if (result == OkCancelResult.ok) {
                    changeLanguage(context, 'th');
                    storage.write(key: 'language', value: 'th');
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => const OnBoardingScreen()),
                      ),
                      (route) => false,
                    );
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 10.h,
                  backgroundImage: AssetImage('assets/images/thailand.png'),
                ),
              ),
              Text('ภาษาไทย', style: TextStyle(fontSize: 10.sp)),
            ],
          ),
        ),
      ),
    );
  }
}
