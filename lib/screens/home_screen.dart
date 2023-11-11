import 'package:allergic_app/localization/language/languages.dart';
import 'package:allergic_app/prints/daily_questions_screen.dart';
import 'package:allergic_app/prints/questions_screen.dart';
import 'package:allergic_app/screens/questions_screen.dart';
import 'package:allergic_app/screens/select_dailyquestion_screen.dart';
import 'package:allergic_app/screens/selected_user.dart';
import 'package:allergic_app/screens/setting_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );
  String name = '';
  String profileImage = '';
  String username = '';
  String _userType = 'user';

  String _language = 'en';
  String _locale = 'en_US';
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.week;

  bool _preTest = false;
  double _age = 0;

  late String _date =
      DateFormat('dd-MM-yyyy').format(DateTime.now()).toString();

  String selectedUser2 = '';

  @override
  void initState() {
    super.initState();
    _getUserName();
    storage.read(key: 'dateOfBirth').then((value) {
      if (value != null) {
        if (value != '') {
          setState(() {
            _age = DateTime.now()
                    .difference(DateFormat('dd/MM/yyyy').parse(value))
                    .inDays /
                365;
          });
        }
      }
    });
    storage.read(key: 'language').then((value) {
      if (value == 'th') {
        setState(() {
          _language = 'th';
        });
      } else {
        setState(() {
          _language = 'en';
        });
      }
      _language == 'th'
          ? setState(() {
              _locale = 'th_TH';
            })
          : setState(() {
              _locale = 'en_US';
            });
    });
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getUserName() async {
    await storage.read(key: 'userType').then((value) {
      setState(() {
        _userType = value.toString();
      });
    });

    await storage.read(key: 'username').then((value) {
      setState(() {
        username = value.toString();
      });
    });

    await storage.read(key: 'name').then((value) {
      if (value != null) {
        setState(() {
          name = value.toString();
        });
      }
    });

    await storage.read(key: 'surname').then((value) {
      if (value != null) {
        setState(() {
          name += ' $value';
        });
      }
    });

    await storage.read(key: 'profile').then((value) {
      if (value != null) {
        setState(() {
          profileImage = value.toString();
        });
      }
    });
    preTest();
  }

  Future preTest() async {
    if (_userType == 'user') {
      await FirebaseFirestore.instance
          .collection('surveys')
          .where('type', isEqualTo: 'pre')
          .where('username', isEqualTo: username.toString())
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          setState(() {
            _preTest = true;
          });
        } else {
          setState(() {
            _preTest = false;
          });
        }
      });
    }
  }

  Future _getData() async {
    if (_userType == 'user') {
      var result = await FirebaseFirestore.instance
          .collection('surveys')
          .where('username', isEqualTo: username.toString())
          .where('date', isEqualTo: _date)
          .where('type', isEqualTo: 'daily')
          .get();

      return result.docs;
    } else {
      if (selectedUser2 == '') {
        var result = await FirebaseFirestore.instance
            .collection('surveys')
            .where('date', isEqualTo: _date)
            .get();

        return result.docs;
      } else {
        var result = await FirebaseFirestore.instance
            .collection('surveys')
            .where('username', isEqualTo: selectedUser2.toString())
            .where('date', isEqualTo: _date)
            .get();

        return result.docs;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedUser = Languages.of(context)!.selectedUser;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.h, vertical: 4.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(35),
                      child: profileImage == '' || profileImage == 'null'
                          ? Image.asset(
                              'assets/images/user.png',
                              width: 7.h,
                              height: 10.w,
                              fit: BoxFit.fill,
                            )
                          : Image.network(
                              profileImage,
                              width: 9.h,
                              height: 18.w,
                              fit: BoxFit.cover,
                            ),
                    ),
                    Container(
                      width: 5.h,
                      height: 10.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all()),
                      child: IconButton(
                        icon: const Icon(
                          Icons.settings,
                        ),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SettingScreen();
                            },
                          )).then((value) {
                            _getUserName();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TableCalendar(
                locale: _locale,
                focusedDay: _focusedDay,
                firstDay: DateTime(2023),
                lastDay: DateTime.now(),
                calendarFormat: _calendarFormat,
                daysOfWeekVisible: false,
                headerStyle: HeaderStyle(
                    titleTextStyle: TextStyle(fontSize: 11.sp),
                    formatButtonTextStyle: TextStyle(fontSize:7.sp)),
                calendarStyle: CalendarStyle(
                  weekendDecoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.rectangle,
                  ),
                  defaultDecoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.rectangle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.rectangle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.white),
                    shape: BoxShape.rectangle,
                  ),
                ),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    _date = DateFormat('dd-MM-yyyy')
                        .format(_selectedDay)
                        .toString();
                  });
                  _getData();
                },
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onPageChanged: (focusedDay) {
                  _focusedDay = focusedDay;
                },
                onFormatChanged: (format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                },
              ),
              SizedBox(
                height: _userType == 'admin' ? 15 : 30,
              ),
              _userType == 'admin'
                  ? Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return const SelectedUserScreen();
                            },
                          )).then((value) {
                            if (value.toString() != 'back') {
                              setState(() {
                                selectedUser2 = value.toString();
                              });
                              _getData();
                            }
                          });
                        },
                        child: Row(
                          children: [
                            Text(
                              Languages.of(context)!.filter,
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                            const Text(' : ',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            Text(
                                selectedUser2 == ''
                                    ? selectedUser
                                    : selectedUser2,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20)),
                            selectedUser2 == ''
                                ? const Icon(Icons.arrow_drop_down,
                                    color: Colors.black)
                                : GestureDetector(
                                    onTap: () => setState(() {
                                          selectedUser2 = '';
                                        }),
                                    child: const Icon(Icons.close,
                                        color: Colors.red)),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              FutureBuilder(
                future: _getData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          setState(() {
                            _getData();
                          });
                        },
                        child: ListView.builder(
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                if (snapshot.data[index]['type'] == 'daily') {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return DailyQuestionDetailScreen(
                                        survey: snapshot.data[index],
                                      );
                                    },
                                  )).then((value) => _getData());
                                } else {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (context) {
                                      return QuestionDetailScreen(
                                        survey: snapshot.data[index],
                                      );
                                    },
                                  )).then((value) => _getData());
                                }
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 7,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.indigoAccent,
                                      child: Text(
                                        snapshot.data[index]['score']
                                            .toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    title: _userType == 'admin'
                                        ? Text(
                                            snapshot.data[index]['my_name']
                                                .toString(),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        : Text(
                                            DateFormat('dd/MM/yyyy HH:mm:ss')
                                                .format(snapshot.data[index]
                                                        ['datetime']
                                                    .toDate()),
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data[index]['type'] ==
                                                  'daily'
                                              ? Languages.of(context)!
                                                  .dailySurvey
                                              : Languages.of(context)!
                                                  .preSurvey,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        _userType == 'admin'
                                            ? Text(
                                                DateFormat(
                                                        'dd/MM/yyyy HH:mm:ss')
                                                    .format(snapshot.data[index]
                                                            ['datetime']
                                                        .toDate()),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              )
                                            : Container(),
                                      ],
                                    ),
                                    trailing:
                                        getIcon(snapshot.data[index]['score']),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: _userType == 'admin'
            ? Container()
            : FloatingActionButton(
                onPressed: () {
                  if (_preTest) {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const SelectDailyQuestion()))
                        .then((value) => _getData());
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => QuestionScreen(
                                  age: _age,
                                ))).then((value) {
                      // set 3 sec to call _getData() function
                      Future.delayed(const Duration(seconds: 3), () {
                        print('call _getData()${_getData()}');
                        _getData();
                        preTest();
                      });
                    });
                  }
                },
                backgroundColor: Colors.indigoAccent,
                child: Image.asset(
                  'assets/images/surveyor.png',
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  getIcon(data) {
    if (data >= 1 && data <= 7) {
      return const Icon(
        Icons.sentiment_very_satisfied,
        color: Colors.green,
      );
    } else if (data >= 8 && data <= 14) {
      return Icon(
        Icons.sentiment_satisfied,
        color: Colors.green[300],
      );
    } else if (data >= 15 && data <= 21) {
      return const Icon(
        Icons.sentiment_neutral,
        color: Colors.orange,
      );
    } else if (data >= 22 && data <= 28) {
      return Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.red[200],
      );
    } else {
      return const Icon(
        Icons.sentiment_dissatisfied,
        color: Colors.red,
      );
    }
  }
}
