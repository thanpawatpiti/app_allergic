import 'dart:io';

import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:allergic_app/localization/language/languages.dart';
import 'package:allergic_app/localization/locale_constant.dart';
import 'package:allergic_app/screens/change_password_screen.dart';
import 'package:allergic_app/screens/languate_screen.dart';
import 'package:allergic_app/screens/profile_screen.dart';
import 'package:allergic_app/views/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  String name = '';
  String typeUser = '';
  late String profileImage = '';
  String _id = '';
  String registerType = '';
  String _language = 'en';

Uri _url = Uri.parse("https://pdpa.pro/policies/view/th/zqs2VSemv9incYfAiVvszK4a");

  @override
  void initState() {
    super.initState();
    storage.read(key: 'language').then((value) {
      if (value == 'th') {
        setState(() {
          _language = 'th';
          _url = Uri.parse("https://pdpa.pro/policies/view/th/zqs2VSemv9incYfAiVvszK4a");
        });
      } else {
        setState(() {
          _language = 'en';
          _url = Uri.parse("https://pdpa.pro/policies/view/en/zqs2VSemv9incYfAiVvszK4a");
        });
      }
    });
    _getUserName();
    _getTypeUser();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future _getUserName() async {
    await storage.read(key: 'id').then((value) {
      setState(() {
        _id = value.toString();
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
          name += ' ${value.toString()}';
        });
      }
    });

    await storage.read(key: 'profile').then((value) {
      setState(() {
        profileImage = value.toString();
      });
    });
  }

  Future _getTypeUser() async {
    await storage.read(key: 'userType').then((value) {
      setState(() {
        typeUser = value.toString();
      });
    });

    await storage.read(key: 'registerType').then((value) {
      setState(() {
        registerType = value.toString();
      });
    });
  }

  Future<OkCancelResult> showAlertDialog(BuildContext context) async {
    return await showOkCancelAlertDialog(
      context: context,
      title: Languages.of(context)!.logout,
      message: Languages.of(context)!.logoutDescription,
      okLabel: Languages.of(context)!.ok,
      cancelLabel: Languages.of(context)!.cancel,
      isDestructiveAction: true,
      barrierDismissible: false,
    );
  }

  Future<OkCancelResult> showAlertDialogDelete(BuildContext context) async {
    return await showOkCancelAlertDialog(
      context: context,
      title: Languages.of(context)!.deleteAccount,
      message: Languages.of(context)!.deleteAccountDescription,
      okLabel: Languages.of(context)!.ok,
      cancelLabel: Languages.of(context)!.cancel,
      isDestructiveAction: true,
      barrierDismissible: false,
    );
  }

  Future _pickImage(ImageSource source, context) async {
    final ImagePicker picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      EasyLoading.show(status: Languages.of(context)!.loading);
      final image = File(pickedFile.path);
      final storageReference = FirebaseStorage.instance.ref().child(
          'profile/${DateTime.now().toString().replaceAll(' ', '')}.jpg');
      final uploadTask = storageReference.putFile(image);
      await uploadTask.whenComplete(() async {
        final url = await storageReference.getDownloadURL();
        _updateProfile(url, context);
      });
    }
  }

  Future _updateProfile(String url, context) async {
    await FirebaseFirestore.instance.collection('users').doc(_id).update({
      'profile': url,
    }).then((value) async {
      EasyLoading.dismiss();
      await storage.write(key: 'profile', value: url);
      setState(() {
        profileImage = url;
      });
      EasyLoading.showSuccess(Languages.of(context)!.success);
    }).catchError((error) {
      print(error);
      EasyLoading.dismiss();
    });
  }

  Future _webViewPrivacyPolicy(context) async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future _deleteAccount() async {
    EasyLoading.show(status: Languages.of(context)!.loading);
    await FirebaseFirestore.instance
        .collection('users')
        .doc(_id)
        .delete()
        .then((value) async {
      await storage.deleteAll();
      EasyLoading.dismiss();
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
        (Route<dynamic> route) => false,
      );
    }).catchError((error) {
      print(error);
      EasyLoading.dismiss();
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
              Padding(
                padding: const EdgeInsets.only(left: 20, top: 10),
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                child: profileImage == '' || profileImage == 'null'
                    ? const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage('assets/images/user.png'),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(profileImage),
                      ),
              ),
              const SizedBox(
                height: 20,
              ),
              registerType == 'app'
                  ? Center(
                      child: GestureDetector(
                        onTap: () => _pickImage(ImageSource.gallery, context),
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.5,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Colors.yellow[200],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 10,
                                ),
                                const Icon(
                                  Icons.upload,
                                  color: Colors.black,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  Languages.of(context)!.uploadPhoto,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ProfileScreen()))
                        .then((value) {
                      _getUserName();
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.person,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.of(context)!.account,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              registerType == 'app'
                  ? Center(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ChangePasswordScreen()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 0.8,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 20,
                                ),
                                const Icon(
                                  Icons.lock,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  Languages.of(context)!.changePassword,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const Spacer(),
                                const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 20,
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Container(),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: GestureDetector(
                  onTap: () => _webViewPrivacyPolicy(context),
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.privacy_tip,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.of(context)!.privacyPolicy,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LanguateScreen()))
                        .then((value) {
                          if (value != null) {
                            setState(() {
                              _language = value;
                              _url = Uri.parse("https://pdpa.pro/policies/view/"+value+"/zqs2VSemv9incYfAiVvszK4a");
                            });
                            changeLanguage(context, value);
                            storage.write(key: 'language', value: value);
                            Phoenix.rebirth(context);
                          }
                    });
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.language,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.of(context)!.chooseLanguage,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            _language == 'en' ? 'English' : 'ไทย',
                            style: const TextStyle(
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Icon(
                            Icons.arrow_forward_ios,
                            size: 20,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final result = await showAlertDialogDelete(context);
                    if (result == OkCancelResult.ok) {
                      await _deleteAccount();
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.red[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.remove_circle,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.of(context)!.deleteAccount,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: GestureDetector(
                  onTap: () async {
                    final result = await showAlertDialog(context);
                    if (result == OkCancelResult.ok) {
                      storage.delete(key: 'id');
                      storage.delete(key: 'username');
                      storage.delete(key: 'name');
                      storage.delete(key: 'surname');
                      storage.delete(key: 'gender');
                      storage.delete(key: 'dateOfBirth');
                      storage.delete(key: 'tokenFCM');
                      storage.delete(key: 'isLogin');
                      storage.delete(key: 'userType');
                      storage.delete(key: 'registerType');
                      storage.delete(key: 'profile');
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                          (route) => false);
                    }
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(),
                      child: Row(
                        children: [
                          const SizedBox(
                            width: 20,
                          ),
                          const Icon(
                            Icons.logout,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            Languages.of(context)!.logout,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
