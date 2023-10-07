import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:allergic_app/localization/language/languages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class DailyQuestionScreen extends StatefulWidget {
  const DailyQuestionScreen({Key? key}) : super(key: key);

  @override
  State<DailyQuestionScreen> createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionScreen> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  double _dailyQuestion1 = 0;
  double _dailyQuestion2 = 0;
  double _dailyQuestion3 = 0;
  double _dailyQuestion4 = 0;
  double _dailyQuestion5 = 0;
  double _dailyQuestion6 = 0;
  double _dailyQuestion7 = 0;

  String? _username;

  String name = '';

  double _score = 0;

  @override
  void initState() {
    super.initState();
    _getUsername();
  }

  @override
  void dispose() {
    super.dispose();
  }

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
      _score = _dailyQuestion1 + _dailyQuestion2 + _dailyQuestion3 + _dailyQuestion4 + _dailyQuestion5 + _dailyQuestion6 + _dailyQuestion7;
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 2.h, top: 1.h),
                    child: Text(
                      Languages.of(context)!.questionDaily,
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Languages.of(context)!.noseSickness,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion1,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion1_1,
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FormBuilderSlider(
                        name: 'slider',
                        min: 0,
                        max: 10,
                        initialValue: _dailyQuestion1,
                        divisions: 10,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.pink[100],
                        displayValues: DisplayValues.current,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dailyQuestion1 = value!;
                          });
                        },
                        onChangeStart: (value) {
                          setState(() {
                            _dailyQuestion1 = value!;
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            _dailyQuestion1 = value!;
                          });
                        },
                        numberFormat: NumberFormat('#'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion2,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion2_1,
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FormBuilderSlider(
                        name: 'slider',
                        min: 0,
                        max: 10,
                        initialValue: _dailyQuestion2,
                        divisions: 10,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.pink[100],
                        displayValues: DisplayValues.current,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dailyQuestion2 = value!;
                          });
                        },
                        onChangeStart: (value) {
                          setState(() {
                            _dailyQuestion2 = value!;
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            _dailyQuestion2 = value!;
                          });
                        },
                        numberFormat: NumberFormat('#'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion3,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion3_1,
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FormBuilderSlider(
                        name: 'slider',
                        min: 0,
                        max: 10,
                        initialValue: _dailyQuestion3,
                        divisions: 10,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.pink[100],
                        displayValues: DisplayValues.current,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dailyQuestion3 = value!;
                          });
                        },
                        onChangeStart: (value) {
                          setState(() {
                            _dailyQuestion3 = value!;
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            _dailyQuestion3 = value!;
                          });
                        },
                        numberFormat: NumberFormat('#'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion4,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion4_1,
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FormBuilderSlider(
                        name: 'slider',
                        min: 0,
                        max: 10,
                        initialValue: _dailyQuestion4,
                        divisions: 10,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.pink[100],
                        displayValues: DisplayValues.current,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dailyQuestion4 = value!;
                          });
                        },
                        onChangeStart: (value) {
                          setState(() {
                            _dailyQuestion4 = value!;
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            _dailyQuestion4 = value!;
                          });
                        },
                        numberFormat: NumberFormat('#'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  Languages.of(context)!.eyeSickness,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion5,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion5_1,
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FormBuilderSlider(
                        name: 'slider',
                        min: 0,
                        max: 10,
                        initialValue: _dailyQuestion5,
                        divisions: 10,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.pink[100],
                        displayValues: DisplayValues.current,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dailyQuestion5 = value!;
                          });
                        },
                        onChangeStart: (value) {
                          setState(() {
                            _dailyQuestion5 = value!;
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            _dailyQuestion5 = value!;
                          });
                        },
                        numberFormat: NumberFormat('#'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion6,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion6_1,
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FormBuilderSlider(
                        name: 'slider',
                        min: 0,
                        max: 10,
                        initialValue: _dailyQuestion6,
                        divisions: 10,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.pink[100],
                        displayValues: DisplayValues.current,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dailyQuestion6 = value!;
                          });
                        },
                        onChangeStart: (value) {
                          setState(() {
                            _dailyQuestion6 = value!;
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            _dailyQuestion6 = value!;
                          });
                        },
                        numberFormat: NumberFormat('#'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion7,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion7_1,
                        style: TextStyle(
                          fontSize: 11.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: FormBuilderSlider(
                        name: 'slider',
                        min: 0,
                        max: 10,
                        initialValue: _dailyQuestion7,
                        divisions: 10,
                        activeColor: Colors.redAccent,
                        inactiveColor: Colors.pink[100],
                        displayValues: DisplayValues.current,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 15, bottom: 11, top: 11, right: 15),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _dailyQuestion7 = value!;
                          });
                        },
                        onChangeStart: (value) {
                          setState(() {
                            _dailyQuestion7 = value!;
                          });
                        },
                        onChangeEnd: (value) {
                          setState(() {
                            _dailyQuestion7 = value!;
                          });
                        },
                        numberFormat: NumberFormat('#'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 50,
        child: ElevatedButton(
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
                  content: Text(Languages.of(context)!.notificationPleaseAnswer),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.send),
              const SizedBox(
                width: 10,
              ),
              Text(Languages.of(context)!.send),
            ],
          ),
        ),
      ),
    );
  }
}

_showDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(Languages.of(context)!.showMessagesConfirmationDailyQuestion),
        content: Text(Languages.of(context)!.showMessagesConfirmationDailyQuestionDescription),
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
