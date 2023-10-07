import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

import '../localization/language/languages.dart';
import 'eye_question_screen.dart';
import 'nose_question_screen.dart';
import 'package:sizer/sizer.dart';

class SelectDailyQuestion extends StatefulWidget {
  const SelectDailyQuestion({super.key});

  @override
  State<SelectDailyQuestion> createState() => _SelectDailyQuestionState();
}

class _SelectDailyQuestionState extends State<SelectDailyQuestion> {
  double _dailyQuestion1 = 0;
  double _dailyQuestion2 = 0;
  double _dailyQuestion3 = 0;
  double _dailyQuestion4 = 0;
  double _dailyQuestion5 = 0;
  double _dailyQuestion6 = 0;
  double _dailyQuestion7 = 0;
  double _score = 0;

  String? _username;

  String name = '';

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  @override
  void dispose() {
    super.dispose();
  }

  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future _getUsername() async {
    await storage.read(key: 'name').then((value) {
      setState(() {
        name = value.toString();
      });
    });

    await storage.read(key: 'surname').then((value) {
      setState(() {
        name += ' $value';
      });
    });

    storage.read(key: 'username').then((value) {
      setState(() {
        _username = value;
      });
    });
  }

  void _getScore() {
    setState(() {
      _score = 0;
      _score = _dailyQuestion1 +
          _dailyQuestion2 +
          _dailyQuestion3 +
          _dailyQuestion4 +
          _dailyQuestion5 +
          _dailyQuestion6 +
          _dailyQuestion7 + 30;
    });
  }

  Future _insertData() async {
    EasyLoading.show(status: Languages.of(context)!.loading);
    await FirebaseFirestore.instance.collection('surveys').add({
      'username': _username,
      'my_name': name,
      'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      'datetime': DateTime.now(),
      'type': 'daily',
      'score': _score,
      'question1': _dailyQuestion1,
      'question2': _dailyQuestion2,
      'question3': _dailyQuestion3,
      'question4': _dailyQuestion4,
      'question5': _dailyQuestion5,
      'question6': _dailyQuestion6,
      'question7': _dailyQuestion7,
    }).then((value) {
      EasyLoading.showSuccess(Languages.of(context)!.success);
      Navigator.pop(context);
    }).catchError((error) {
      print(error);
      EasyLoading.showError(Languages.of(context)!.error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EyeQuestionScreen()))
                    .then((value) {
                  print("value ${value}");
                  print(value["_dailyQuestion5"]);
                  _dailyQuestion5 = value["_dailyQuestion5"];
                  _dailyQuestion6 = value["_dailyQuestion6"];
                  _dailyQuestion7 = value["_dailyQuestion7"];
                  print(_dailyQuestion5);
                }),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 48,
                    backgroundImage: AssetImage("assets/images/1.png"),
                  ),
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              InkWell(
                onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NoseQuestionScreen()))
                    .then((value) {
                  print("value ${value}");
                  _dailyQuestion1 = value["_dailyQuestion1"];
                  _dailyQuestion2 = value["_dailyQuestion2"];
                  _dailyQuestion3 = value["_dailyQuestion3"];
                  _dailyQuestion4 = value["_dailyQuestion4"];
                }),
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 48,
                    backgroundImage: AssetImage("assets/images/2.png"),
                  ),
                  height: MediaQuery.of(context).size.height * 0.18,
                  width: MediaQuery.of(context).size.width * 0.37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(10.0),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 17.h,
                height: 9.w,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blueAccent, // background
                    onPrimary: Colors.white, // foreground
                  ),
                  onPressed: () async {
                    if (_dailyQuestion1 == 0 ||
                        _dailyQuestion2 == 0 ||
                        _dailyQuestion3 == 0 ||
                        _dailyQuestion4 == 0 ||
                        _dailyQuestion5 == 0 ||
                        _dailyQuestion6 == 0 ||
                        _dailyQuestion7 == 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              Languages.of(context)!.notificationPleaseAnswer),
                        ),
                      );
                    } else {
                      final result = await _showDialog(context);
                      if (result == OkCancelResult.ok) {
                        _getScore();
                        _insertData();
                      }
                    }
                  },
                  child: Text(
                    Languages.of(context)!.btnSendDailyquestion,
                    style: TextStyle(fontSize: 8.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
        appBar: AppBar(
          title: Text(Languages.of(context)!.headerSelectScreen),
        ));
  }
}

_showDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title:
            Text(Languages.of(context)!.showMessagesConfirmationDailyQuestion),
        content: Text(Languages.of(context)!
            .showMessagesConfirmationDailyQuestionDescription),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(OkCancelResult.cancel);
            },
            child: Text(Languages.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(OkCancelResult.ok);
            },
            child: Text(Languages.of(context)!.ok),
          ),
        ],
      );
    },
  );
}
