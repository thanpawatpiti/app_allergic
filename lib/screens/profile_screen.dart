import 'package:allergic_app/localization/language/languages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final storage = const FlutterSecureStorage(
  aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  TextEditingController usernameController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();

  String _language = 'en';
  String _id = '';
  String? genderSelected;
  late String profileImage = '';

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
      _getUserName();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getUserName() async {
    storage.read(key: 'id').then((value) {
      setState(() {
        _id = value.toString();
      });
    });

    storage.read(key: 'username').then((value) {
      setState(() {
        usernameController.text = value.toString();
      });
    });

    storage.read(key: 'name').then((value) {
      setState(() {
        nameController.text = value.toString();
      });
    });

    storage.read(key: 'surname').then((value) {
      setState(() {
        surnameController.text = value.toString();
      });
    });

    storage.read(key: 'dateOfBirth').then((value) {
      setState(() {
        dateOfBirthController.text = value.toString();
      });
    });

    storage.read(key: 'gender').then((value) {
      if (value != '') {
        setState(() {
          if (_language == 'th') {
            final g = value.toString() == 'Male' ? 'ผู้ชาย' : 'ผู้หญิง';
            genderSelected = g;
          } else {
            genderSelected = value.toString();
          }
        });
      }
    });

    storage.read(key: 'profile').then((value) {
      setState(() {
        profileImage = value.toString();
      });
    });
  }

  Future _updateUser() async {
    EasyLoading.show(status: Languages.of(context)!.loading);
    await FirebaseFirestore.instance.collection('users').doc(_id).update({
      'name': nameController.text,
      'surname': surnameController.text,
      'dateOfBirth': dateOfBirthController.text,
      'gender': _language == 'en' ? genderSelected : genderSelected == 'ผู้ชาย' ? 'Male' : 'Female',
    }).then((value) {
      EasyLoading.dismiss();
      storage.write(key: 'name', value: nameController.text);
      storage.write(key: 'surname', value: surnameController.text);
      storage.write(key: 'dateOfBirth', value: dateOfBirthController.text);
      storage.write(key: 'gender', value: genderSelected);
      EasyLoading.showSuccess(Languages.of(context)!.success);
    }).catchError((error) {
      print(error);
      EasyLoading.dismiss();
    });
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                  const Spacer(),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: profileImage == '' ? const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                    'assets/images/user.png',
                  )
                ) : CircleAvatar(
                  radius: 50,
                  backgroundImage: NetworkImage(
                    profileImage,
                  ),
                ),
              ),
              const SizedBox(
                height: 80,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      readOnly: true,
                      controller: usernameController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        border: InputBorder.none,
                        labelText: Languages.of(context)!.username,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        border: InputBorder.none,
                        labelText: Languages.of(context)!.name,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      controller: surnameController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person),
                        border: InputBorder.none,
                        labelText: Languages.of(context)!.surname,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: TextFormField(
                      onTap: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          minTime: DateTime(1900, 1, 1),
                          maxTime: DateTime(DateTime.now().year - 1, 12, 31),
                          onConfirm: (date) {
                            dateOfBirthController.text =
                                DateFormat('dd/MM/yyyy').format(date);
                          },
                          currentTime: dateOfBirthController.text == ''
                              ? DateTime.now()
                              : DateFormat('dd/MM/yyyy')
                                  .parse(dateOfBirthController.text),
                          locale:
                              _language == 'en' ? LocaleType.en : LocaleType.th,
                        );
                      },
                      readOnly: true,
                      controller: dateOfBirthController,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.calendar_month),
                        border: InputBorder.none,
                        labelText: Languages.of(context)!.dateOfBirth,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
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
                        items: genderList.map((item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        )).toList(),
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
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white),
                  ),
                  child: TextButton(
                    onPressed: () => _updateUser(),
                    child: const Text('Save',
                        style: TextStyle(color: Colors.white)),
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
