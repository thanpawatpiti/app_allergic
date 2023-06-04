import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:allergic_app/localization/language/languages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DailyQuestionDetailScreen extends StatefulWidget {
  const DailyQuestionDetailScreen({Key? key, required this.survey}) : super(key: key);

  final DocumentSnapshot survey;

  @override
  State<DailyQuestionDetailScreen> createState() => _DailyQuestionScreenState();
}

class _DailyQuestionScreenState extends State<DailyQuestionDetailScreen> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  int _dailyQuestion1 = 0;
  int _dailyQuestion2 = 0;
  int _dailyQuestion3 = 0;
  int _dailyQuestion4 = 0;
  int _dailyQuestion5 = 0;
  int _dailyQuestion6 = 0;
  int _dailyQuestion7 = 0;

  String? _username;

  @override
  void initState() {
    super.initState();
    _getUsername();
    _setData();
  }

  @override
  void dispose() {
    super.dispose();
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
                color: Colors.grey[200],
                child: Column(
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
                      child: Text(
                        Languages.of(context)!.dailyQuestion1_1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sentiment_very_satisfied,
                            color: _dailyQuestion1 == 1 ? Colors.blue : Colors.green,
                            size: _dailyQuestion1 == 1 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_satisfied,
                            color: _dailyQuestion1 == 2 ? Colors.blue : Colors.green[300],
                            size: _dailyQuestion1 == 2 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_neutral,
                            color: _dailyQuestion1 == 3 ? Colors.blue : Colors.orange,
                            size: _dailyQuestion1 == 3 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: _dailyQuestion1 == 4 ? Colors.blue : Colors.red[200],
                            size: _dailyQuestion1 == 4 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: _dailyQuestion1 == 5 ? Colors.blue : Colors.red,
                            size: _dailyQuestion1 == 5 ? 40 : 20,
                          ),
                        ],
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion2_1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sentiment_very_satisfied,
                            color: _dailyQuestion2 == 1 ? Colors.blue : Colors.green,
                            size: _dailyQuestion2 == 1 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_satisfied,
                            color: _dailyQuestion2 == 2 ? Colors.blue : Colors.green[300],
                            size: _dailyQuestion2 == 2 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_neutral,
                            color: _dailyQuestion2 == 3 ? Colors.blue : Colors.orange,
                            size: _dailyQuestion2 == 3 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: _dailyQuestion2 == 4 ? Colors.blue : Colors.red[200],
                            size: _dailyQuestion2 == 4 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: _dailyQuestion2 == 5 ? Colors.blue : Colors.red,
                            size: _dailyQuestion2 == 5 ? 40 : 20,
                          ),
                        ],
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion3_1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sentiment_very_satisfied,
                            color: _dailyQuestion3 == 1 ? Colors.blue : Colors.green,
                            size: _dailyQuestion3 == 1 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_satisfied,
                            color: _dailyQuestion3 == 2 ? Colors.blue : Colors.green[300],
                            size: _dailyQuestion3 == 2 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_neutral,
                            color: _dailyQuestion3 == 3 ? Colors.blue : Colors.orange,
                            size: _dailyQuestion3 == 3 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: _dailyQuestion3 == 4 ? Colors.blue : Colors.red[200],
                            size: _dailyQuestion3 == 4 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: _dailyQuestion3 == 5 ? Colors.blue : Colors.red,
                            size: _dailyQuestion3 == 5 ? 40 : 20,
                          ),
                        ],
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion4_1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sentiment_very_satisfied,
                            color: _dailyQuestion4 == 1 ? Colors.blue : Colors.green,
                            size: _dailyQuestion4 == 1 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_satisfied,
                            color: _dailyQuestion4 == 2 ? Colors.blue : Colors.green[300],
                            size: _dailyQuestion4 == 2 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_neutral,
                            color: _dailyQuestion4 == 3 ? Colors.blue : Colors.orange,
                            size: _dailyQuestion4 == 3 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: _dailyQuestion4 == 4 ? Colors.blue : Colors.red[200],
                            size: _dailyQuestion4 == 4 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: _dailyQuestion4 == 5 ? Colors.blue : Colors.red,
                            size: _dailyQuestion4 == 5 ? 40 : 20,
                          ),
                        ],
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
                color: Colors.grey[200],
                child: Column(
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
                      child: Text(
                        Languages.of(context)!.dailyQuestion5_1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sentiment_very_satisfied,
                            color: _dailyQuestion5 == 1 ? Colors.blue : Colors.green,
                            size: _dailyQuestion5 == 1 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_satisfied,
                            color: _dailyQuestion5 == 2 ? Colors.blue : Colors.green[300],
                            size: _dailyQuestion5 == 2 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_neutral,
                            color: _dailyQuestion5 == 3 ? Colors.blue : Colors.orange,
                            size: _dailyQuestion5 == 3 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: _dailyQuestion5 == 4 ? Colors.blue : Colors.red[200],
                            size: _dailyQuestion5 == 4 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: _dailyQuestion5 == 5 ? Colors.blue : Colors.red,
                            size: _dailyQuestion5 == 5 ? 40 : 20,
                          ),
                        ],
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion6_1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sentiment_very_satisfied,
                            color: _dailyQuestion6 == 1 ? Colors.blue : Colors.green,
                            size: _dailyQuestion6 == 1 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_satisfied,
                            color: _dailyQuestion6 == 2 ? Colors.blue : Colors.green[300],
                            size: _dailyQuestion6 == 2 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_neutral,
                            color: _dailyQuestion6 == 3 ? Colors.blue : Colors.orange,
                            size: _dailyQuestion6 == 3 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: _dailyQuestion6 == 4 ? Colors.blue : Colors.red[200],
                            size: _dailyQuestion6 == 4 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: _dailyQuestion6 == 5 ? Colors.blue : Colors.red,
                            size: _dailyQuestion6 == 5 ? 40 : 20,
                          ),
                        ],
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
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        Languages.of(context)!.dailyQuestion7_1,
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.sentiment_very_satisfied,
                            color: _dailyQuestion7 == 1 ? Colors.blue : Colors.green,
                            size: _dailyQuestion7 == 1 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_satisfied,
                            color: _dailyQuestion7 == 2 ? Colors.blue : Colors.green[300],
                            size: _dailyQuestion7 == 2 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_neutral,
                            color: _dailyQuestion7 == 3 ? Colors.blue : Colors.orange,
                            size: _dailyQuestion7 == 3 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_dissatisfied,
                            color: _dailyQuestion7 == 4 ? Colors.blue : Colors.red[200],
                            size: _dailyQuestion7 == 4 ? 40 : 20,
                          ),
                          Icon(
                            Icons.sentiment_very_dissatisfied,
                            color: _dailyQuestion7 == 5 ? Colors.blue : Colors.red,
                            size: _dailyQuestion7 == 5 ? 40 : 20,
                          ),
                        ],
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
