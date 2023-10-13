import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';

import '../localization/language/languages.dart';

class EyeQuestionScreen extends StatefulWidget {
  const EyeQuestionScreen({super.key});
  @override
  State<EyeQuestionScreen> createState() => _EyeQuestionScreenState();
}

class _EyeQuestionScreenState extends State<EyeQuestionScreen> {
  double _dailyQuestion5 = 0;
  double _dailyQuestion6 = 0;
  double _dailyQuestion7 = 0;

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
                        fontSize: 18.sp,
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
                  Languages.of(context)!.eyeSickness,
                  style: TextStyle(
                    fontSize: 14.sp,
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
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion5_1,
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
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
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion6_1,
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
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
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion7_1,
                        style: TextStyle(
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
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
                height: 30,
              ),
              Center(
                child: SizedBox(
                  width: 20.w,
                  height: 5.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueAccent, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      //List<double> eyeValue = [_dailyQuestion5, _dailyQuestion6, _dailyQuestion7];
                      Map<String, double> eyeValue = {
                        "_dailyQuestion5": _dailyQuestion5,
                        "_dailyQuestion6": _dailyQuestion6,
                        "_dailyQuestion7": _dailyQuestion7,
                      };
                      Navigator.pop(context, eyeValue);
                    },
                    child: Text(
                      Languages.of(context)!.saveDailyquestion,
                      style: TextStyle(
                        fontSize: 12.sp
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
