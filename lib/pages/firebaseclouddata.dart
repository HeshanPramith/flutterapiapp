// ignore_for_file: use_build_context_synchronously

import 'package:apiapp/main.dart';
import 'package:apiapp/pages/firebaseclouddatacreate.dart';
import 'package:apiapp/pages/firebaseclouddatadetail.dart';
import 'package:apiapp/pages/home.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Firebaseclouddata extends StatefulWidget {
  static const routeName = '/firebaseclouddata';
  const Firebaseclouddata({super.key});

  @override
  State<Firebaseclouddata> createState() => _FirebaseclouddataState();
}

class _FirebaseclouddataState extends State<Firebaseclouddata> {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');

  List<DocumentSnapshot> users = [];

  @override
  void initState() {
    super.initState();
    _loadUsers(); // Load users initially
  }

  Future<void> _loadUsers() async {
    final querySnapshot = await _usersCollection.get();
    setState(() {
      users = querySnapshot.docs;
    });
  }

  void _deleteUser(String documentId) async {
    try {
      await _usersCollection.doc(documentId).delete();
      setState(() {
        users.removeWhere((user) => user.id == documentId);
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Center(child: Text('User deleted successfully')),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (e) {
      print('Error deleting user: $e');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Center(child: Text('Error deleting user: $e')),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return Theme(
      data: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Firestore Cloud Data',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const Home(
                    firstName: '',
                    lastName: '',
                  ),
                ),
              );
            },
          ),
          actions: [
            Switch(
              value: isDarkMode,
              onChanged: (value) {
                Provider.of<ThemeProvider>(context, listen: false)
                    .toggleTheme();
              },
            ),
            IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacementNamed(SignIn.routeName);
              },
              icon: const Icon(
                Icons.logout,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            const SizedBox(
              height: 15.0,
            ),
            Padding(
              padding: const EdgeInsets.only(
                right: 15.0,
                left: 15.0,
              ),
              child: Row(
                children: [
                  const Text(
                    'User List',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const AddUserScreen(),
                      ));
                    },
                    child: const Text('Add New User'),
                  ),
                ],
              ),
            ),
            StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Text('No Data');
                } else {
                  final users = snapshot.data!.docs;

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 5.0,
                      ),
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          final userData =
                              users[index].data() as Map<String, dynamic>;
                          final documentId = users[index].id;
                          final mobile = userData['mobile'] ?? 'N/A';
                          final fname = userData['fname'] ?? 'N/A';
                          final lname = userData['lname'] ?? 'N/A';
                          final email = userData['email'] ?? 'N/A';
                          final country = userData['country'] ?? 'N/A';
                          final dob = userData['dob'] ?? 'N/A';
                          final location = userData['location'] ?? 'N/A';
                          final maritalStatus =
                              userData['maritalStatus'] ?? 'N/A';
                          final nationality = userData['nationality'] ?? 'N/A';

                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              left: 10.0,
                              right: 10.0,
                            ),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => UserDetailPage(
                                      documentId: documentId,
                                      fname: fname,
                                      lname: lname,
                                      mobile: mobile,
                                      email: email,
                                      country: country,
                                      location: location,
                                      maritalStatus: maritalStatus,
                                      nationality: nationality,
                                      dob: dob,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 8.0,
                                  ),
                                  child: ListTile(
                                    leading: const CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 14, 184, 8),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    title: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        if (fname != 'N/A' && lname != 'N/A')
                                          Text(
                                            '$fname $lname',
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        if (mobile != 'N/A')
                                          const SizedBox(
                                            height: 5.0,
                                          ),
                                        if (mobile != 'N/A')
                                          Text(
                                            mobile,
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                        const SizedBox(
                                          height: 5.0,
                                        ),
                                        if (email != 'N/A')
                                          Text(
                                            '$email',
                                            style: const TextStyle(
                                              fontSize: 14,
                                            ),
                                          ),
                                      ],
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        _deleteUser(documentId);
                                      },
                                      icon: const Icon(
                                        Icons.delete_forever,
                                        color: Colors.red,
                                        size: 24.0,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
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
