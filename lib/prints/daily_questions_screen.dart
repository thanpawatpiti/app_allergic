import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:allergic_app/localization/language/languages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sizer/sizer.dart';

class DailyQuestionDetailScreen extends StatefulWidget {
  const DailyQuestionDetailScreen({Key? key, required this.survey})
      : super(key: key);

  final DocumentSnapshot survey;

  @override
  State<DailyQuestionDetailScreen> createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionDetailScreen> {
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

  @override
  void initState() {
    super.initState();
    _getUsername();
    _setData();
    print(widget);
    print(widget.survey);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Color SetIconColor(double value) {
    if (value <= 2.0) {
      return Colors.green;
    } else if (value > 2.0 && value <= 4.0) {
      return Colors.lightGreen;
    } else if (value > 4.0 && value <= 6.0) {
      return Colors.yellow;
    } else if (value > 6.0 && value <= 8.0) {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  IconData setIconType(double value) {
    if (value <= 2.0) {
      return Icons.sentiment_very_satisfied_outlined;
    } else if (value > 2.0 && value <= 4.0) {
      return Icons.sentiment_satisfied_alt_rounded;
    } else if (value > 4.0 && value <= 6.0) {
      return Icons.sentiment_dissatisfied;
    } else if (value > 6.0 && value <= 8.0) {
      return Icons.sentiment_dissatisfied_outlined;
    } else {
      return Icons.sentiment_very_dissatisfied_sharp;
    }
  }

  Future _setData() async {
    setState(() {
      _dailyQuestion1 = widget.survey['question1'];
      _dailyQuestion2 = widget.survey['question2'];
      _dailyQuestion3 = widget.survey['question3'];
      _dailyQuestion4 = widget.survey['question4'];
      _dailyQuestion5 = widget.survey['question5'];
      _dailyQuestion6 = widget.survey['question6'];
      _dailyQuestion7 = widget.survey['question7'];
    });
  }

  Future _getUsername() async {
    storage.read(key: 'username').then((value) {
      setState(() {
        _username = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 10),
                      child: Text(
                        Languages.of(context)!.questionDaily,
                        style: const TextStyle(
                          fontSize: 30,
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
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.dailyQuestion1,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Text(
                                Languages.of(context)!.dailyQuestion1_1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.totalScore +
                                  "${_dailyQuestion1}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          setIconType(_dailyQuestion1),
                          color: SetIconColor(_dailyQuestion1),
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.75,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(
                                Languages.of(context)!.dailyQuestion2,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.75,
                              child: Text(
                                Languages.of(context)!.dailyQuestion2_1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.totalScore + "${_dailyQuestion2}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          setIconType(_dailyQuestion2),
                          color: SetIconColor(_dailyQuestion2),
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.dailyQuestion3,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.75,
                              child: Text(
                                Languages.of(context)!.dailyQuestion3_1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.totalScore + "${_dailyQuestion3}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          setIconType(_dailyQuestion3),
                          color: SetIconColor(_dailyQuestion3),
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.dailyQuestion4,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.75,
                              child: Text(
                                Languages.of(context)!.dailyQuestion4_1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.totalScore + "${_dailyQuestion4}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          setIconType(_dailyQuestion4),
                          color: SetIconColor(_dailyQuestion4),
                          size: 30.sp,
                        ),
                      )
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
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.dailyQuestion5,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.75,
                              child: Text(
                                Languages.of(context)!.dailyQuestion5_1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.totalScore + "${_dailyQuestion5}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          setIconType(_dailyQuestion5),
                          color: SetIconColor(_dailyQuestion5),
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.dailyQuestion6,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.75,
                              child: Text(
                                Languages.of(context)!.dailyQuestion6_1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.totalScore + "${_dailyQuestion6}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          setIconType(_dailyQuestion6),
                          color: SetIconColor(_dailyQuestion6),
                          size: 30.sp,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  color: Colors.grey[200],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.dailyQuestion7,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.75,
                              child: Text(
                                Languages.of(context)!.dailyQuestion7_1,
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              Languages.of(context)!.totalScore + "${_dailyQuestion7}",
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          setIconType(_dailyQuestion7),
                          color: SetIconColor(_dailyQuestion7),
                          size: 30.sp,
                        ),
                      )
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
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: MediaQuery.of(context).size.width / 1.5,
        height: 50,
        child: ElevatedButton(
          onPressed: () async {
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.close),
              const SizedBox(
                width: 10,
              ),
              Text(Languages.of(context)!.cancel),
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
