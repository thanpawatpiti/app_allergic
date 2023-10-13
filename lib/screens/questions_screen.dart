import 'package:allergic_app/localization/language/languages.dart';
import 'package:allergic_app/screens/home_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key, required this.age}) : super(key: key);

  final double age;

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late final double _age = widget.age;
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  late double _question1;

  String? username;
  String name = '';

  final TextEditingController _question7_1 = TextEditingController();
  final TextEditingController _question7_2 = TextEditingController();
  final TextEditingController _question7_3 = TextEditingController();
  final TextEditingController _question7_3_1 = TextEditingController();
  final TextEditingController _question8_1 = TextEditingController();
  final TextEditingController _question8_3 = TextEditingController();
  final TextEditingController _question9_1 = TextEditingController();
  final TextEditingController _question10_1 = TextEditingController();
  final TextEditingController _question11_1 = TextEditingController();

  String? _question2,
      _question3_1,
      _question3_2,
      _question3_3,
      _question3_4,
      _question3_5,
      _question3_6,
      _question3_7,
      _question3_8,
      _question3_9,
      _question3_10,
      _question3_11,
      _question3_12,
      _question3_13,
      _question3_14,
      _question3_15,
      _question3_16,
      _question4,
      _question5_1,
      _question5_2,
      _question5_3,
      _question5_4,
      _question6,
      _question6_1,
      _question7,
      _question7_4,
      _question8,
      _question8_2,
      _question9,
      _question10,
      _question11,
      _question11_2 = '';

  int score = 0;

  void _conditionBeforeSave() {
    if (_question2 == '' ||
        _question3_1 == '' ||
        _question3_2 == '' ||
        _question3_3 == '' ||
        _question3_4 == '' ||
        _question3_5 == '' ||
        _question3_6 == '' ||
        _question3_7 == '' ||
        _question3_8 == '' ||
        _question3_9 == '' ||
        _question3_10 == '' ||
        _question3_11 == '' ||
        _question3_12 == '' ||
        _question3_13 == '' ||
        _question3_14 == '' ||
        _question3_15 == '' ||
        _question3_16 == '' ||
        _question4 == '' ||
        _question5_1 == '' ||
        _question5_2 == '' ||
        _question5_3 == '' ||
        _question5_4 == '' ||
        _question6 == '' ||
        _question7 == '' ||
        _question7_4 == '' ||
        _question8 == '' ||
        _question9 == '' ||
        _question10 == '' ||
        _question11 == '') {
      EasyLoading.showError(
          Languages.of(context)!.pleaseAnswerAllQuestions);
    } else if(_question6 == 'No' && _question6_1 == '') {
      EasyLoading.showError(Languages.of(context)!.pleaseAnswerAllQuestions);
    } else if (_question7 == 'Yes' && _question7_4 == '') {
      EasyLoading.showError(Languages.of(context)!.pleaseAnswerAllQuestions);
    } else if (_question8 == 'Yes' &&
        _question8_2 == '' &&
        _question8_3.text.isEmpty) {
      EasyLoading.showError(Languages.of(context)!.pleaseAnswerAllQuestions);
    } else if (_question9 == 'Yes' && _question9_1.text.isEmpty) {
      EasyLoading.showError(Languages.of(context)!.pleaseAnswerAllQuestions);
    } else if (_question10 == 'Yes' && _question10_1.text.isEmpty) {
      EasyLoading.showError(Languages.of(context)!.pleaseAnswerAllQuestions);
    } else if (_question11 == 'Yes' &&
        _question11_2 == '' &&
        _question11_1.text.isEmpty) {
      EasyLoading.showError(Languages.of(context)!.pleaseAnswerAllQuestions);
    } else if (_question7_3.text.isNotEmpty && _question7_3_1.text.isEmpty) {
      EasyLoading.showError(Languages.of(context)!.pleaseAnswerAllQuestions);
    } else {
      _countScore();
    }
  }

  @override
  void initState() {
    super.initState();
    _question1 = _age.toDouble();
    _getInfoUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getInfoUser() async {
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

    storage.read(key: 'gender').then((value) {
      if (value != null && value.isNotEmpty) {
        setState(() {
          _question2 = value;
        });
      }
    });

    storage.read(key: 'username').then((value) {
      setState(() {
        username = value;
      });
    });
  }

  Future _insertData() async {
    if (_question3_1 == null || _question3_2 == null || _question3_3 == null || _question3_4 == null || _question3_5 == null || _question3_6 == null || _question3_7 == null || _question3_8 == null || _question3_9 == null || _question3_10 == null || _question3_11 == null || _question3_12 == null || _question3_13 == null || _question3_14 == null || _question3_15 == null || _question3_16 == null || _question4 == null || _question5_1 == null || _question5_2 == null || _question5_3 == null || _question5_4 == null || _question6 == null || _question7 == null || _question8 == null || _question9 == null || _question10 == null || _question11 == null) {
      EasyLoading.showError(Languages.of(context)!.pleaseAnswerAllQuestions);
      return;
    }

    EasyLoading.show(status: Languages.of(context)!.loading);
    await FirebaseFirestore.instance.collection('surveys').add({
      'username': username,
      'my_name': name,
      'date': DateFormat('dd-MM-yyyy').format(DateTime.now()),
      'datetime': DateTime.now(),
      'type': 'pre',
      'score': score,
      'question1': _question1.round().toString(),
      'question2': _question2,
      'question3_1': _question3_1,
      'question3_2': _question3_2,
      'question3_3': _question3_3,
      'question3_4': _question3_4,
      'question3_5': _question3_5,
      'question3_6': _question3_6,
      'question3_7': _question3_7,
      'question3_8': _question3_8,
      'question3_9': _question3_9,
      'question3_10': _question3_10,
      'question3_11': _question3_11,
      'question3_12': _question3_12,
      'question3_13': _question3_13,
      'question3_14': _question3_14,
      'question3_15': _question3_15,
      'question3_16': _question3_16,
      'question4': _question4,
      'question5_1': _question5_1,
      'question5_2': _question5_2,
      'question5_3': _question5_3,
      'question5_4': _question5_4,
      'question6': _question6,
      'question6_1': _question6_1,
      'question7': _question7,
      'question7_1': _question7_1.text,
      'question7_1_1': _question7_3_1.text,
      'question7_2': _question7_2.text,
      'question7_3': _question7_3.text,
      'question7_4': _question7_4,
      'question8': _question8,
      'question8_1': _question8_1.text,
      'question8_2': _question8_2,
      'question8_3': _question8_3.text,
      'question9': _question9,
      'question9_1': _question9_1.text,
      'question10': _question10,
      'question10_1': _question10_1.text,
      'question11': _question11,
      'question11_1': _question11_1.text,
      'question11_2': _question11_2,
    }).then((value) {
      EasyLoading.showSuccess(Languages.of(context)!.success);
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
          (route) => false);
    }).catchError((error) {
      print(error);
      EasyLoading.showError(Languages.of(context)!.error);
    });
  }

  void _countScore() {
    setState(() {
      score = 0;
    });

    if (_question3_1 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_2 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_3 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_4 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_5 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_6 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_7 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_8 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_9 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_10 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_11 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_12 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_13 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_14 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_15 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question3_16 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question4 == 'Everyday') {
      setState(() {
        score += 2;
      });
    }

    if (_question4 == 'Everyweek') {
      setState(() {
        score += 1;
      });
    }

    if (_question5_1 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question5_2 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question5_3 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question5_4 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question6 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question6_1 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question7 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question7_4 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question8 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question8_2 == 'Yes') {
      setState(() {
        score += 1;
      });
    }

    if (_question9 == 'Yes') {
      setState(() {
        score += 1;
      });
    }
    _insertData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        Languages.of(context)!.questionStart,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.h,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question1,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FormBuilderSlider(
                  name: 'slider',
                  min: 0,
                  max: 100,
                  initialValue: _question1,
                  divisions: 100,
                  activeColor: Colors.red,
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
                      _question1 = value!;
                    });
                  },
                  onChangeStart: (value) {
                    setState(() {
                      _question1 = value!;
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      _question1 = value!;
                    });
                  },
                  numberFormat: NumberFormat('#'),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question2,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Male',
                        groupValue: _question2,
                        onChanged: (value) {
                          setState(() {
                            _question2 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.genderMale,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        width: 16.w,
                      ),
                      Radio(
                        value: 'Female',
                        groupValue: _question2,
                        onChanged: (value) {
                          setState(() {
                            _question2 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.genderFemale,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question3,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context)!.question3_1,
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_1,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_1 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_1,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_1 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_2,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_2,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_2 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_2,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_2 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_3,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_3,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_3 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_3,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_3 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_4,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_4,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_4 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_4,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_4 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_5,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_5,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_5 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_5,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_5 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_6,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_6,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_6 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_6,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_6 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_7,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_7,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_7 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_7,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_7 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_8,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_8,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_8 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_8,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_8 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_9,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_9,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_9 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_9,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_9 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_10,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_10,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_10 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_10,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_10 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_11,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_11,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_11 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_11,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_11 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_12,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_12,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_12 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_12,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_12 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_13,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_13,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_13 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_13,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_13 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_14,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_14,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_14 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_14,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_14 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_15,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_15,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_15 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_15,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_15 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Languages.of(context)!.question3_16,
                              style: TextStyle(
                                fontSize: 10.sp,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_16,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_16 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_16,
                                onChanged: (value) {
                                  setState(() {
                                    _question3_16 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question4,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                            value: 'Everyday',
                            groupValue: _question4,
                            onChanged: (value) {
                              setState(() {
                                _question4 = value.toString();
                              });
                            },
                          ),
                          Text(
                            Languages.of(context)!.everyDay,
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Everyweek',
                            groupValue: _question4,
                            onChanged: (value) {
                              setState(() {
                                _question4 = value.toString();
                              });
                            },
                          ),
                          Text(
                            Languages.of(context)!.everyWeek,
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                            value: 'Sometime',
                            groupValue: _question4,
                            onChanged: (value) {
                              setState(() {
                                _question4 = value.toString();
                              });
                            },
                          ),
                          Text(
                            Languages.of(context)!.someTime,
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question5,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context)!.question5_1,
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question5_1,
                                onChanged: (value) {
                                  setState(() {
                                    _question5_1 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question5_1,
                                onChanged: (value) {
                                  setState(() {
                                    _question5_1 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context)!.question5_2,
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question5_2,
                                onChanged: (value) {
                                  setState(() {
                                    _question5_2 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question5_2,
                                onChanged: (value) {
                                  setState(() {
                                    _question5_2 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context)!.question5_3,
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question5_3,
                                onChanged: (value) {
                                  setState(() {
                                    _question5_3 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question5_3,
                                onChanged: (value) {
                                  setState(() {
                                    _question5_3 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context)!.question5_4,
                            style: TextStyle(
                              fontSize: 10.sp,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question5_4,
                                onChanged: (value) {
                                  setState(() {
                                    _question5_4 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                              SizedBox(
                                width: 12.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question5_4,
                                onChanged: (value) {
                                  setState(() {
                                    _question5_4 = value.toString();
                                  });
                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question6,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question6,
                        onChanged: (value) {
                          setState(() {
                            _question6 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Radio(
                        value: 'No',
                        groupValue: _question6,
                        onChanged: (value) {
                          setState(() {
                            _question6 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                _question6 == 'No'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question6 == 'No'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question6_1,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question6 == 'No'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 'Yes',
                              groupValue: _question6_1,
                              onChanged: (value) {
                                setState(() {
                                  _question6_1 = value.toString();
                                });
                              },
                            ),
                            Text(
                              Languages.of(context)!.answerYes,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              width: 12.h,
                            ),
                            Radio(
                              value: 'No',
                              groupValue: _question6_1,
                              onChanged: (value) {
                                setState(() {
                                  _question6_1 = value.toString();
                                });
                              },
                            ),
                            Text(
                              Languages.of(context)!.answerNo,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question7,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question7,
                        onChanged: (value) {
                          setState(() {
                            _question7 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Radio(
                        value: 'No',
                        groupValue: _question7,
                        onChanged: (value) {
                          setState(() {
                            _question7 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                _question7 == 'Yes'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question7 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question7_1,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question7 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  Languages.of(context)!.petDogs,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.h,
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: TextFormField(
                                    controller: _question7_1,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  Languages.of(context)!.petCats,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.h,
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: TextFormField(
                                    controller: _question7_2,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  Languages.of(context)!.petOther,
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.h,
                                ),
                                SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: TextFormField(
                                    controller: _question7_3,
                                    keyboardType: TextInputType.number,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Container(),
                _question7_3.text == ''
                    ? Container()
                    : const SizedBox(
                        height: 20,
                      ),
                _question7_3.text == ''
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question7_1_1,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                _question7_3.text == ''
                    ? Container()
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          child: TextFormField(
                            minLines: 1,
                            maxLines: 10,
                            controller: _question7_3_1,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                _question7 == 'Yes'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question7 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question7_2,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question7 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 'Yes',
                              groupValue: _question7_4,
                              onChanged: (value) {
                                setState(() {
                                  _question7_4 = value.toString();
                                });
                              },
                            ),
                            Text(
                              Languages.of(context)!.answerYes,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              width: 12.h,
                            ),
                            Radio(
                              value: 'No',
                              groupValue: _question7_4,
                              onChanged: (value) {
                                setState(() {
                                  _question7_4 = value.toString();
                                });
                              },
                            ),
                            Text(
                              Languages.of(context)!.answerNo,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question8,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question8,
                        onChanged: (value) {
                          setState(() {
                            _question8 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Radio(
                        value: 'No',
                        groupValue: _question8,
                        onChanged: (value) {
                          setState(() {
                            _question8 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                _question8 == 'Yes'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question8 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question8_1,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question8 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: _question8_1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: Languages.of(context)!.question8_1_1,
                          ),
                        ),
                      )
                    : Container(),
                _question8 == 'Yes'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question8 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question8_2,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question8 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 'Yes',
                              groupValue: _question8_2,
                              onChanged: (value) {
                                setState(() {
                                  _question8_2 = value.toString();
                                });
                              },
                            ),
                            Text(
                              Languages.of(context)!.answerYes,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              width: 12.h,
                            ),
                            Radio(
                              value: 'No',
                              groupValue: _question8_2,
                              onChanged: (value) {
                                setState(() {
                                  _question8_2 = value.toString();
                                });
                              },
                            ),
                            Text(
                              Languages.of(context)!.answerNo,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                _question8_2 == 'Yes'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question8_2 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question8_3,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question8_2 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: _question8_3,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: Languages.of(context)!.question8_3_1,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question9,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question9,
                        onChanged: (value) {
                          setState(() {
                            _question9 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Radio(
                        value: 'No',
                        groupValue: _question9,
                        onChanged: (value) {
                          setState(() {
                            _question9 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                _question9 == 'Yes'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question9 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question9_1,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question9 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: _question9_1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: Languages.of(context)!.question9_1_1,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question10,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question10,
                        onChanged: (value) {
                          setState(() {
                            _question10 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Radio(
                        value: 'No',
                        groupValue: _question10,
                        onChanged: (value) {
                          setState(() {
                            _question10 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                _question10 == 'Yes'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question10 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question10_1,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question10 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: _question10_1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: Languages.of(context)!.question10_1_1,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question11,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question11,
                        onChanged: (value) {
                          setState(() {
                            _question11 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                      SizedBox(
                        width: 12.h,
                      ),
                      Radio(
                        value: 'No',
                        groupValue: _question11,
                        onChanged: (value) {
                          setState(() {
                            _question11 = value.toString();
                          });
                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: TextStyle(
                          fontSize: 10.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                _question11 == 'Yes'
                    ? const SizedBox(
                        height: 20,
                      )
                    : Container(),
                _question11 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          Languages.of(context)!.question11_1,
                          style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : Container(),
                _question11 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 80, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Radio(
                              value: 'bySkin',
                              groupValue: _question11_2,
                              onChanged: (value) {
                                setState(() {
                                  _question11_2 = value.toString();
                                });
                              },
                            ),
                            Text(
                              Languages.of(context)!.bySkin,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                            SizedBox(
                              width: 4.h,
                            ),
                            Radio(
                              value: 'byBlood',
                              groupValue: _question11_2,
                              onChanged: (value) {
                                setState(() {
                                  _question11_2 = value.toString();
                                });
                              },
                            ),
                            Text(
                              Languages.of(context)!.byBlood,
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Container(),
                _question11 == 'Yes'
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 10),
                        child: TextFormField(
                          minLines: 1,
                          maxLines: 10,
                          controller: _question11_1,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: Languages.of(context)!.question11_1_1,
                          ),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  height: 80,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 30.w,
        height: 4.h,
        child: ElevatedButton(
          onPressed: () {
            _conditionBeforeSave();
          },
          child: Text(Languages.of(context)!.send, style: TextStyle(fontSize: 12.sp),),
        ),
      ),
    );
  }
}
