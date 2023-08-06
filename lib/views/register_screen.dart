import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:allergic_app/localization/language/languages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final _keyForm = GlobalKey<FormState>();

  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nameController = TextEditingController();
  final _surnameController = TextEditingController();
  final _dateOfBirthController = TextEditingController();

  String _language = 'en';
  bool acceptConditions = false;
  bool privacyPolicy = false;
  String? genderSelected;

  @override
  void initState() {
    super.initState();
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
    });
  }

  Future _register(context) async {
    if (_keyForm.currentState!.validate()) {
      _keyForm.currentState!.save();

      final result = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: _usernameController.text)
          .get();
      if (result.docs.isNotEmpty) {
        await showAlertDialog(context);
      } else {
        if (genderSelected == 'ผู้ชาย') {
          genderSelected = 'Male';
        }
        if (genderSelected == 'ผู้หญิง') {
          genderSelected = 'Female';
        }
        EasyLoading.show(status: Languages.of(context)!.loading);
        FirebaseFirestore.instance.collection('users').add({
          'username': _usernameController.text,
          'password': _passwordController.text,
          'name': _nameController.text,
          'surname': _surnameController.text,
          'dateOfBirth': _dateOfBirthController.text,
          'gender': genderSelected,
          'userType': 'user',
          'registerType': 'app',
          'registerDate': DateTime.now().toString(),
          'tokenFCM': '',
          'profile': ''
        }).then((value) {
          EasyLoading.dismiss();
          Navigator.pop(context, _usernameController.text);
        }).catchError((error) {
          EasyLoading.dismiss();
          print('Failed to add user: $error');
        });
      }
    }
  }

  Future<OkCancelResult> showAlertDialog(BuildContext context) async {
    return await showOkCancelAlertDialog(
      context: context,
      title: Languages.of(context)!.error,
      message: Languages.of(context)!.usernameAlreadyExists,
      okLabel: Languages.of(context)!.ok,
      isDestructiveAction: true,
      barrierDismissible: false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<String> genderList = [
      Languages.of(context)!.genderMale,
      Languages.of(context)!.genderFemale,
    ];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _keyForm,
            child: Column(
              children: [
                Row(
                  children: [
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
                  height: 40,
                ),
                Text(
                  Languages.of(context)!.createAccount,
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _usernameController,
                        showCursor: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: Languages.of(context)!.username,
                          border: InputBorder.none,
                        ),
                        validator: ((value) {
                          if (value!.isEmpty) {
                            return Languages.of(context)!.usernameFieldEmpty;
                          }
                          return null;
                        }),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        showCursor: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          hintText: Languages.of(context)!.password,
                          border: InputBorder.none,
                        ),
                        validator: (value) => value!.isEmpty
                            ? Languages.of(context)!.passwordFieldEmpty
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        showCursor: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          hintText: Languages.of(context)!.confirmPassword,
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return Languages.of(context)!
                                .confirmPasswordFieldEmpty;
                          } else if (value != _passwordController.text) {
                            return Languages.of(context)!
                                .confirmPasswordNotMatch;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _nameController,
                        showCursor: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: Languages.of(context)!.name,
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return Languages.of(context)!.nameFieldEmpty;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _surnameController,
                        showCursor: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.person),
                          hintText: Languages.of(context)!.surname,
                          border: InputBorder.none,
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return Languages.of(context)!.surnameFieldEmpty;
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: TextFormField(
                        controller: _dateOfBirthController,
                        onTap: () {
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1900, 1, 1),
                            maxTime: DateTime(DateTime.now().year - 1, 12, 31),
                            onConfirm: (date) {
                              _dateOfBirthController.text =
                                  DateFormat('dd/MM/yyyy').format(date);
                            },
                            currentTime: DateTime.now(),
                            locale: _language == 'en'
                                ? LocaleType.en
                                : LocaleType.th,
                          );
                        },
                        readOnly: true,
                        showCursor: true,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.calendar_today),
                          hintText: Languages.of(context)!.dateOfBirth,
                          border: InputBorder.none,
                        ),
                        validator: (value) => value!.isEmpty
                            ? Languages.of(context)!.dateOfBirthFieldEmpty
                            : null,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButtonFormField2(
                          hint: Text(
                            Languages.of(context)!.chooseGender,
                            style: TextStyle(
                              fontSize: 16,
                              color: Theme.of(context).hintColor,
                            ),
                          ),
                          items: genderList
                              .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(
                                      item,
                                      style: const TextStyle(
                                        fontSize: 14,
                                      ),
                                    ),
                                  ))
                              .toList(),
                          value: genderSelected,
                          onChanged: (value) {
                            setState(() {
                              genderSelected = value.toString();
                            });
                          },
                          buttonHeight: 20,
                          buttonWidth: MediaQuery.of(context).size.width * 0.8,
                          itemHeight: 50,
                          validator: (value) => value == null
                              ? Languages.of(context)!.genderFieldEmpty
                              : null,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 25,
                    ),
                    Checkbox(
                      value: acceptConditions,
                      onChanged: _onChangedacceptConditions,
                    ),
                    Text(
                      Languages.of(context)!.acceptConditions,
                      style: TextStyle(
                        color: acceptConditions ? Colors.green : Colors.red,
                      ),
                    ),
                  ],
                ),
                Row(children: [
                  const SizedBox(
                    width: 25,
                  ),
                  Checkbox(
                    value: privacyPolicy,
                    onChanged: _onChangedprivacyPolicy,
                  ),
                  Text(
                    Languages.of(context)!.privacyPolicy,
                    style: TextStyle(
                      color: privacyPolicy ? Colors.green : Colors.red,
                    ),
                  ),
                ]),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: acceptConditions && privacyPolicy
                          ? Colors.blue
                          : Colors.grey,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (acceptConditions && privacyPolicy) {
                          _register(context);
                        }
                      },
                      child: Text(
                        Languages.of(context)!.createAccount,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onChangedacceptConditions(bool? value) {
    setState(() {
      acceptConditions = value!;
    });
  }

  void _onChangedprivacyPolicy(bool? value) {
    setState(() {
      privacyPolicy = value!;
    });
  }
}
