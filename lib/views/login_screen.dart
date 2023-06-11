import 'dart:convert';
import 'dart:math';
import 'dart:io' show Platform;

import 'package:allergic_app/localization/language/languages.dart';
import 'package:allergic_app/screens/home_screen.dart';
import 'package:allergic_app/views/register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:http/http.dart' as http;
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  final storang = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  String tokenFCM = '';

  @override
  void initState() {
    super.initState();
    _getToken();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future _getToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    if (fcmToken != null) {
      setState(() {
        tokenFCM = fcmToken.toString();
      });
    }
  }

  Future _loginByUsername(context) async {
    if (_formKey.currentState!.validate()) {
      EasyLoading.show(status: Languages.of(context)!.loading);
      final result = await FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: _usernameController.text)
          .get();
      if (result.docs.isNotEmpty) {
        EasyLoading.dismiss();
        final user = result.docs.first;
        if (user['password'] != _passwordController.text) {
          EasyLoading.showError(Languages.of(context)!.passwordNotMatch);
        } else {
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.id)
              .update({'tokenFCM': tokenFCM});
          EasyLoading.showSuccess(Languages.of(context)!.loginSuccess);
          storang.write(key: 'id', value: user.id);
          storang.write(key: 'username', value: user['username']);
          storang.write(key: 'name', value: user['name']);
          storang.write(key: 'surname', value: user['surname']);
          storang.write(key: 'gender', value: user['gender']);
          storang.write(key: 'dateOfBirth', value: user['dateOfBirth']);
          storang.write(key: 'tokenFCM', value: tokenFCM);
          storang.write(key: 'isLogin', value: 'true');
          storang.write(key: 'userType', value: user['userType']);
          storang.write(key: 'registerType', value: user['registerType']);
          storang.write(key: 'profile', value: user['profile']);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => const HomeScreen())),
              (route) => false);
        }
      } else {
        EasyLoading.dismiss();
        EasyLoading.showError(Languages.of(context)!.usernameNotFound);
      }
    }
  }

  Future _loginWithGoogle(BuildContext context) async {
    EasyLoading.show(status: Languages.of(context)!.loading);
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );

    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: googleUser?.email)
            .where('registerType', isEqualTo: 'google')
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            final user = value.docs.first;
            FirebaseFirestore.instance
                .collection('users')
                .doc(user.id)
                .update({'tokenFCM': tokenFCM});
            EasyLoading.dismiss();
            EasyLoading.showSuccess(Languages.of(context)!.loginSuccess);
            storang.write(key: 'id', value: user.id);
            storang.write(key: 'username', value: user['username']);
            storang.write(key: 'name', value: user['name']);
            storang.write(key: 'surname', value: user['surname']);
            storang.write(key: 'gender', value: user['gender']);
            storang.write(key: 'dateOfBirth', value: user['dateOfBirth']);
            storang.write(key: 'tokenFCM', value: tokenFCM);
            storang.write(key: 'isLogin', value: 'true');
            storang.write(key: 'userType', value: user['userType']);
            storang.write(key: 'registerType', value: user['registerType']);
            storang.write(key: 'profile', value: user['profile'] ?? '');

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: ((context) => const HomeScreen())),
                (route) => false);
          } else {
            EasyLoading.dismiss();
            List<String>? name = googleUser?.displayName?.split(' ');
            FirebaseFirestore.instance.collection('users').doc().set({
              'username': googleUser?.email,
              'password': Random().nextInt(1000000).toString(),
              'name': name![0] != '' ? name[0] : '',
              'surname': name[1] != '' ? name[1] : '',
              'dateOfBirth': '',
              'gender': '',
              'userType': 'user',
              'registerType': 'google',
              'registerDate': DateTime.now().toString(),
              'tokenFCM': tokenFCM,
              'profile': googleUser?.photoUrl,
            }).then((value) {
              FirebaseFirestore.instance
                  .collection('users')
                  .where('username', isEqualTo: googleUser?.email)
                  .where('registerType', isEqualTo: 'google')
                  .get()
                  .then((value) {
                final user = value.docs.first;
                EasyLoading.showSuccess(Languages.of(context)!.loginSuccess);
                storang.write(key: 'id', value: user.id);
                storang.write(key: 'username', value: googleUser?.email);
                storang.write(key: 'name', value: name[0] != '' ? name[0] : '');
                storang.write(
                    key: 'surname', value: name[1] != '' ? name[1] : '');
                storang.write(key: 'gender', value: '');
                storang.write(key: 'dateOfBirth', value: '');
                storang.write(key: 'tokenFCM', value: tokenFCM);
                storang.write(key: 'isLogin', value: 'true');
                storang.write(key: 'userType', value: 'user');
                storang.write(key: 'registerType', value: 'google');
                storang.write(key: 'profile', value: googleUser?.photoUrl);

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const HomeScreen())),
                    (route) => false);
              });
            });
          }
        }).catchError((e) {
          EasyLoading.dismiss();
          print(e);
        });
      } else {
        EasyLoading.dismiss();
      }
    } else {
      EasyLoading.dismiss();
    }
  }

  Future _loginWithFacebook(BuildContext context) async {
    EasyLoading.show(status: Languages.of(context)!.loading);
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      final graphResponse = await http.get(Uri.parse(
          'https://graph.facebook.com/v2.12/me?fields=name,first_name,last_name,email&access_token=${accessToken.token}'));
      final profile = json.decode(graphResponse.body);
      FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: profile['email'])
          .where('registerType', isEqualTo: 'facebook')
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          final user = value.docs.first;
          FirebaseFirestore.instance
              .collection('users')
              .doc(user.id)
              .update({'tokenFCM': tokenFCM});
          EasyLoading.dismiss();
          EasyLoading.showSuccess(Languages.of(context)!.loginSuccess);
          storang.write(key: 'id', value: user.id);
          storang.write(key: 'username', value: user['username']);
          storang.write(key: 'name', value: user['name']);
          storang.write(key: 'surname', value: user['surname']);
          storang.write(key: 'gender', value: user['gender']);
          storang.write(key: 'dateOfBirth', value: user['dateOfBirth']);
          storang.write(key: 'tokenFCM', value: tokenFCM);
          storang.write(key: 'isLogin', value: 'true');
          storang.write(key: 'userType', value: user['userType']);
          storang.write(key: 'registerType', value: user['registerType']);
          storang.write(key: 'profile', value: user['profile']);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => const HomeScreen())),
              (route) => false);
        } else {
          EasyLoading.dismiss();
          FirebaseFirestore.instance.collection('users').doc().set({
            'username': profile['email'] ?? profile['id'],
            'password': Random().nextInt(1000000).toString(),
            'name': profile['first_name'],
            'surname': profile['last_name'],
            'dateOfBirth': '',
            'gender': '',
            'userType': 'user',
            'registerType': 'facebook',
            'registerDate': DateTime.now().toString(),
            'tokenFCM': tokenFCM,
            'profile': '',
          }).then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .where('username', isEqualTo: profile['email'] ?? profile['id'])
                .where('registerType', isEqualTo: 'facebook')
                .get()
                .then((value) {
              final user = value.docs.first;
              EasyLoading.showSuccess(Languages.of(context)!.loginSuccess);
              storang.write(key: 'id', value: user.id);
              storang.write(
                  key: 'username', value: profile['email'] ?? profile['id']);
              storang.write(key: 'name', value: profile['first_name']);
              storang.write(key: 'surname', value: profile['last_name']);
              storang.write(key: 'gender', value: '');
              storang.write(key: 'dateOfBirth', value: '');
              storang.write(key: 'tokenFCM', value: tokenFCM);
              storang.write(key: 'isLogin', value: 'true');
              storang.write(key: 'userType', value: 'user');
              storang.write(key: 'registerType', value: 'facebook');
              storang.write(key: 'profile', value: user['profile']);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => const HomeScreen())),
                  (route) => false);
            });
          });
        }
      }).catchError((e) {
        EasyLoading.dismiss();
        print(e);
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  Future _loginWithApple(context) async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final oAuthProvider = OAuthProvider('apple.com');
    final credentialApple = oAuthProvider.credential(
      idToken: credential.identityToken,
      accessToken: credential.authorizationCode,
    );
    final authResult =
        await FirebaseAuth.instance.signInWithCredential(credentialApple);
    final user = authResult.user;

    EasyLoading.show(status: Languages.of(context)!.loading);
    if (user != null) {
      FirebaseFirestore.instance
          .collection('users')
          .where('username', isEqualTo: user.email)
          .where('registerType', isEqualTo: 'apple')
          .get()
          .then((value) {
        if (value.docs.isNotEmpty) {
          final userFirebase = value.docs.first;
          FirebaseFirestore.instance
              .collection('users')
              .doc(userFirebase.id)
              .update({'tokenFCM': tokenFCM});
          EasyLoading.dismiss();
          EasyLoading.showSuccess(Languages.of(context)!.loginSuccess);
          storang.write(key: 'id', value: userFirebase.id);
          storang.write(key: 'username', value: userFirebase['username']);
          storang.write(key: 'name', value: userFirebase['name']);
          storang.write(key: 'surname', value: userFirebase['surname']);
          storang.write(key: 'gender', value: userFirebase['gender']);
          storang.write(key: 'dateOfBirth', value: userFirebase['dateOfBirth']);
          storang.write(key: 'tokenFCM', value: tokenFCM);
          storang.write(key: 'isLogin', value: 'true');
          storang.write(key: 'userType', value: userFirebase['userType']);
          storang.write(
              key: 'registerType', value: userFirebase['registerType']);
          storang.write(key: 'profile', value: userFirebase['profile']);

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: ((context) => const HomeScreen())),
              (route) => false);
        } else {
          EasyLoading.dismiss();
          FirebaseFirestore.instance.collection('users').doc().set({
            'username': user.email,
            'password': Random().nextInt(1000000).toString(),
            'name': user.email,
            'surname': '',
            'dateOfBirth': '',
            'gender': '',
            'userType': 'user',
            'registerType': 'apple',
            'registerDate': DateTime.now().toString(),
            'tokenFCM': tokenFCM,
            'profile': '',
          }).then((value) {
            FirebaseFirestore.instance
                .collection('users')
                .where('username', isEqualTo: user.email)
                .where('registerType', isEqualTo: 'google')
                .get()
                .then((value) {
              final user_ = value.docs.first;
              EasyLoading.showSuccess(Languages.of(context)!.loginSuccess);
              storang.write(key: 'id', value: user_.id);
              storang.write(key: 'username', value: user.email);
              storang.write(key: 'name', value: user.email);
              storang.write(key: 'surname', value: '');
              storang.write(key: 'gender', value: '');
              storang.write(key: 'dateOfBirth', value: '');
              storang.write(key: 'tokenFCM', value: tokenFCM);
              storang.write(key: 'isLogin', value: 'true');
              storang.write(key: 'userType', value: 'user');
              storang.write(key: 'registerType', value: 'apple');
              storang.write(key: 'profile', value: user_['profile']);

              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: ((context) => const HomeScreen())),
                  (route) => false);
            });
          });
        }
      }).catchError((e) {
        EasyLoading.dismiss();
        print(e);
      });
    } else {
      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/images/5741215-removebg-preview.png'),
                Text(
                  Languages.of(context)!.signIn,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5.h),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.h, right: 5.h),
                      child: TextFormField(
                        controller: _usernameController,
                        showCursor: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 1.h),
                          icon: const Icon(Icons.person),
                          hintText: Languages.of(context)!.username,
                          border: InputBorder.none,
                        ),
                        validator: (value) => value!.isEmpty
                            ? Languages.of(context)!.usernameCannotBeEmpty
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(5.h),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 2.h, right: 5.h),
                      child: TextFormField(
                        controller: _passwordController,
                        showCursor: true,
                        obscureText: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 3.w, horizontal: 1.h),
                          icon: const Icon(Icons.lock),
                          hintText: Languages.of(context)!.password,
                          border: InputBorder.none,
                        ),
                        validator: (value) => value!.isEmpty
                            ? Languages.of(context)!.passwordCannotBeEmpty
                            : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.h),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.h),
                      border: Border.all(color: Colors.white),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _loginByUsername(context);
                        }
                      },
                      child: Text(
                        Languages.of(context)!.signIn,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 6.sp,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                TextButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterScreen(),
                    ),
                  ).then((value) {
                    if (value != null) {
                      setState(() {
                        _usernameController.text = value;
                      });
                      EasyLoading.showSuccess(
                          Languages.of(context)!.createdSuccessfully);
                    }
                  }),
                  child: Text(
                    Languages.of(context)!.createAccount,
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 4.sp,
                    ),
                  ),
                ),
                SizedBox(height: 3.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (Platform.isIOS)
                        ? GestureDetector(
                            onTap: () async {
                              _loginWithApple(context);
                            },
                            child: Image.asset(
                              'assets/images/apple.png',
                              width: 5.w,
                              height: 5.h,
                            ),
                          )
                        : Container(),
                    SizedBox(width: 3.w),
                    GestureDetector(
                      onTap: () async {
                        _loginWithGoogle(context);
                      },
                      child: Image.asset(
                        'assets/images/google.png',
                        width: 5.w,
                        height: 5.h,
                      ),
                    ),
                    SizedBox(width: 3.w),
                    GestureDetector(
                      onTap: () async {
                        _loginWithFacebook(context);
                      },
                      child: Image.asset(
                        'assets/images/facebook.png',
                        width: 5.w,
                        height: 5.h,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
