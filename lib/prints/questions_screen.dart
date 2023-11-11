import 'package:allergic_app/localization/language/languages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

class QuestionDetailScreen extends StatefulWidget {
  const QuestionDetailScreen({Key? key, required this.survey}) : super(key: key);

  final DocumentSnapshot survey;

  @override
  State<QuestionDetailScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionDetailScreen> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  double _question1 = 1;

  String? gender;
  String? username;

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

  @override
  void initState() {
    super.initState();
    _setData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _setData() async {
    setState(() {
      _question1 = double.parse(widget.survey['question1']);
      _question2 = widget.survey['question2'];
      _question3_1 = widget.survey['question3_1'];
      _question3_2 = widget.survey['question3_2'];
      _question3_3 = widget.survey['question3_3'];
      _question3_4 = widget.survey['question3_4'];
      _question3_5 = widget.survey['question3_5'];
      _question3_6 = widget.survey['question3_6'];
      _question3_7 = widget.survey['question3_7'];
      _question3_8 = widget.survey['question3_8'];
      _question3_9 = widget.survey['question3_9'];
      _question3_10 = widget.survey['question3_10'];
      _question3_11 = widget.survey['question3_11'];
      _question3_12 = widget.survey['question3_12'];
      _question3_13 = widget.survey['question3_13'];
      _question3_14 = widget.survey['question3_14'];
      _question3_15 = widget.survey['question3_15'];
      _question3_16 = widget.survey['question3_16'];
      _question4 = widget.survey['question4'];
      _question5_1 = widget.survey['question5_1'];
      _question5_2 = widget.survey['question5_2'];
      _question5_3 = widget.survey['question5_3'];
      _question5_4 = widget.survey['question5_4'];
      _question6 = widget.survey['question6'];
      _question6_1 = widget.survey['question6_1'];
      _question7 = widget.survey['question7'];
      _question7_1.text = widget.survey['question7_1'];
      _question7_3_1.text = widget.survey['question7_1_1'];
      _question7_2.text = widget.survey['question7_2'];
      _question7_3.text = widget.survey['question7_3'];
      _question7_4 = widget.survey['question7_4'];
      _question8 = widget.survey['question8'];
      _question8_1.text = widget.survey['question8_1'];
      _question8_2 = widget.survey['question8_2'];
      _question8_3.text = widget.survey['question8_3'];
      _question9 = widget.survey['question9'];
      _question9_1.text = widget.survey['question9_1'];
      _question10 = widget.survey['question10'];
      _question10_1.text = widget.survey['question10_1'];
      _question11 = widget.survey['question11'];
      _question11_1.text = widget.survey['question11_1'];
      _question11_2 = widget.survey['question11_2'];
    });
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
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                FormBuilderSlider(
                  enabled: false,
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
                      _question1 = value;
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      _question1 = value;
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
                    style: const TextStyle(
                      fontSize: 16,
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
                        },
                      ),
                      Text(
                        Languages.of(context)!.genderMale,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'Female',
                        groupValue: _question2,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.genderFemale,
                        style: const TextStyle(
                          fontSize: 16,
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
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Languages.of(context)!.question3_1,
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_1,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_1,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_2,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_2,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_3,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_3,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_4,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_4,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_5,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_5,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_6,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_6,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_7,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_7,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_8,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_8,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_9,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_9,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_10,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_10,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_11,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_11,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_12,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_12,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_13,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_13,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_14,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_14,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_15,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_15,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                              style: const TextStyle(
                                fontSize: 15,
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question3_16,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question3_16,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                    style: const TextStyle(
                      fontSize: 16,
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

                            },
                          ),
                          Text(
                            Languages.of(context)!.everyDay,
                            style: const TextStyle(
                              fontSize: 16,
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

                            },
                          ),
                          Text(
                            Languages.of(context)!.everyWeek,
                            style: const TextStyle(
                              fontSize: 16,
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

                            },
                          ),
                          Text(
                            Languages.of(context)!.someTime,
                            style: const TextStyle(
                              fontSize: 16,
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
                    style: const TextStyle(
                      fontSize: 16,
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
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question5_1,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question5_1,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question5_2,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question5_2,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question5_3,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question5_3,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Radio(
                                value: 'Yes',
                                groupValue: _question5_4,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerYes,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                              SizedBox(
                                width: 14.h,
                              ),
                              Radio(
                                value: 'No',
                                groupValue: _question5_4,
                                onChanged: (value) {

                                },
                              ),
                              Text(
                                Languages.of(context)!.answerNo,
                                style: const TextStyle(
                                  fontSize: 16,
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
                    style: const TextStyle(
                      fontSize: 16,
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

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question6,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _question6 == 'No' ? const SizedBox(
                  height: 20,
                ) : Container(),
                _question6 == 'No' ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question6_1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question6 == 'No' ? Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question6_1,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question6_1,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question7,
                    style: const TextStyle(
                      fontSize: 16,
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

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question7,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _question7 == 'Yes' ? const SizedBox(height: 20,) : Container(),
                _question7 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question7_1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question7 == 'Yes'? Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            Languages.of(context)!.petDogs,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: TextFormField(
                              readOnly: true,
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
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: TextFormField(
                              readOnly: true,
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
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const Spacer(),
                          SizedBox(
                            width: 50,
                            height: 50,
                            child: TextFormField(
                              readOnly: true,
                              controller: _question7_3,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ) : Container(),
                _question7_3.text == '' ? Container() : const SizedBox(height: 20,),
                _question7_3.text == '' ? Container() : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question7_1_1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _question7_3.text == '' ? Container() : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    child: TextFormField(
                      readOnly: true,
                      minLines: 1,
                      maxLines: 10,
                      controller: _question7_3_1,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                _question7 == 'Yes' ? const SizedBox(
                  height: 20,
                ) : Container(),
                _question7 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question7_2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question7 == 'Yes'? Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question7_4,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question7_4,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question8,
                    style: const TextStyle(
                      fontSize: 16,
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

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question8,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _question8 == 'Yes' ? const SizedBox(
                  height: 20,
                ) : Container(),
                _question8 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question8_1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question8 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    readOnly: true,
                    minLines: 1,
                    maxLines: 10,
                    controller: _question8_1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: Languages.of(context)!.question8_1_1,
                    ),
                  ),
                ) : Container(),
                _question8 == 'Yes' ? const SizedBox(
                  height: 20,
                ) : Container(),
                _question8 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question8_2,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question8 == 'Yes'? Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Yes',
                        groupValue: _question8_2,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question8_2,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
                _question8_2 == 'Yes' ? const SizedBox(
                  height: 20,
                ) : Container(),
                _question8_2 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question8_3,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question8_2 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    readOnly: true,
                    minLines: 1,
                    maxLines: 10,
                    controller: _question8_3,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: Languages.of(context)!.question8_3_1,
                    ),
                  ),
                ) : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question9,
                    style: const TextStyle(
                      fontSize: 16,
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

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question9,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _question9 == 'Yes' ? const SizedBox(
                  height: 20,
                ) : Container(),
                _question9 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question9_1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question9 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    readOnly: true,
                    minLines: 1,
                    maxLines: 10,
                    controller: _question9_1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: Languages.of(context)!.question9_1_1,
                    ),
                  ),
                ) : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question10,
                    style: const TextStyle(
                      fontSize: 16,
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

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question10,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _question10 == 'Yes' ? const SizedBox(
                  height: 20,
                ) : Container(),
                _question10 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question10_1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question10 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    readOnly: true,
                    minLines: 1,
                    maxLines: 10,
                    controller: _question10_1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: Languages.of(context)!.question10_1_1,
                    ),
                  ),
                ) : Container(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question11,
                    style: const TextStyle(
                      fontSize: 16,
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

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerYes,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'No',
                        groupValue: _question11,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.answerNo,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                _question11 == 'Yes' ? const SizedBox(
                  height: 20,
                ) : Container(),
                _question11 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    Languages.of(context)!.question11_1,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ) : Container(),
                _question11 == 'Yes'? Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'bySkin',
                        groupValue: _question11_2,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.bySkin,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                      const Spacer(),
                      Radio(
                        value: 'byBlood',
                        groupValue: _question11_2,
                        onChanged: (value) {

                        },
                      ),
                      Text(
                        Languages.of(context)!.byBlood,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ) : Container(),
                _question11 == 'Yes'? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  child: TextFormField(
                    readOnly: true,
                    minLines: 1,
                    maxLines: 10,
                    controller: _question11_1,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      hintText: Languages.of(context)!.question11_1_1,
                    ),
                  ),
                ) : Container(),
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
        width: MediaQuery.of(context).size.width / 1.5,
        height: 50,
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                Languages.of(context)!.cancel,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              const Icon(
                Icons.close,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
