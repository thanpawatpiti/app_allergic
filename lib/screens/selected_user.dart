import 'package:allergic_app/localization/language/languages.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SelectedUserScreen extends StatefulWidget {
  const SelectedUserScreen({Key? key}) : super(key: key);

  @override
  State<SelectedUserScreen> createState() => _SelectedUserScreenState();
}

class _SelectedUserScreenState extends State<SelectedUserScreen> {
  final storage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  Future _getUser() async {
    var result = await FirebaseFirestore.instance
        .collection('users')
        .where('userType', isEqualTo: 'user')
        .get();

    return result.docs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context, 'back');
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.only(right: 40),
                  child: Text(Languages.of(context)!.selectedUserBack, style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            FutureBuilder(
              future: _getUser(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pop(context, snapshot.data[index].data()['username']);
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                  spreadRadius: 0.0,
                                  offset: Offset(0.0, 0.0),
                                ),
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.person,
                                    size: 40,
                                  ),
                                  Text(
                                    '${snapshot.data[index].data()['name']} ${snapshot.data[index].data()['surname']}',
                                    style: const TextStyle(
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
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
    );
  }
}
