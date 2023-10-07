import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../localization/language/languages.dart';

class NoseQuestionScreen extends StatefulWidget {
  const NoseQuestionScreen({super.key});
  @override
  State<NoseQuestionScreen> createState() => _NoseQuestionScreenState();
}

class _NoseQuestionScreenState extends State<NoseQuestionScreen> {
  double _dailyQuestion1 = 0;
  double _dailyQuestion2 = 0;
  double _dailyQuestion3 = 0;
  double _dailyQuestion4 = 0;

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
                    padding: EdgeInsets.only(left: 15, top: 15),
                    child: Text(
                      Languages.of(context)!.questionDaily,
                      style: TextStyle(
                        fontSize: 17.sp,
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
                    fontSize: 10.sp,
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
                          fontSize: 7.sp,
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
                          fontSize: 7.sp,
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
                          fontSize: 7.sp,
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
                          fontSize: 7.sp,
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
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 15.w,
                  height: 7.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      print("question 1 score: ${_dailyQuestion1}");
                      print("question 2 score: ${_dailyQuestion2}");
                      print("question 3 score: ${_dailyQuestion3}");
                      print("question 4 score: ${_dailyQuestion4}");

                      //List<double> eyeValue = [_dailyQuestion5, _dailyQuestion6, _dailyQuestion7];
                      Map<String, double> noseValue = {
                        "_dailyQuestion1": _dailyQuestion1,
                        "_dailyQuestion2": _dailyQuestion2,
                        "_dailyQuestion3": _dailyQuestion3,
                        "_dailyQuestion4": _dailyQuestion4,
                      };
                      Navigator.pop(context, noseValue);
                    },
                    child: Text(
                      Languages.of(context)!.saveDailyquestion,
                      style: TextStyle(
                          fontSize: 10.sp
                      ),
                    ),
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
