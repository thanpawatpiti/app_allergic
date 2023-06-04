import 'package:allergic_app/localization/language/languages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  String _id = '';

  @override
  void initState() {
    super.initState();
    _getID();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  _getID() async {
    await storage.read(key: 'id').then((value) {
      setState(() {
        _id = value!;
      });
    });
  }

  Future _chanePassword(context) async {
    EasyLoading.show(status: Languages.of(context)!.loading);
    final user = FirebaseFirestore.instance
        .collection('users')
        .doc(_id)
        .get();

    user.then((value) {
      if (value.exists) {
        if (value.data()!['password'] == _oldPasswordController.text) {
          if (_newPasswordController.text == _confirmPasswordController.text) {
            FirebaseFirestore.instance
                .collection('users')
                .doc(_id)
                .update({'password': _newPasswordController.text}).then((value) {
              EasyLoading.dismiss();
              Navigator.pop(context);
            });
          } else {
            EasyLoading.dismiss();
            EasyLoading.showError(Languages.of(context)!.confirmPasswordNotMatch);
          }
        } else {
          EasyLoading.dismiss();
          EasyLoading.showError(Languages.of(context)!.oldPasswordNotMatch);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(Languages.of(context)!.userNotFound);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 30,
                      ),
                    ),
                    Text(
                      Languages.of(context)!.changePassword,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: _oldPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Languages.of(context)!.oldPassword,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Languages.of(context)!.passwordFieldEmpty;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: _newPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Languages.of(context)!.newPassword,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Languages.of(context)!.passwordFieldEmpty;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: Languages.of(context)!.confirmPassword2,
                      prefixIcon: const Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return Languages.of(context)!.passwordFieldEmpty;
                      }
                      if (value != _newPasswordController.text) {
                        return Languages.of(context)!.passwordNotMatch;
                      }
                      return null;
                    },
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      _chanePassword(context);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                      child: Text(
                        Languages.of(context)!.changePassword,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
