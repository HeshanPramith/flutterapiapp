// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'package:apiapp/main.dart';
import 'package:apiapp/pages/firebaseclouddatadetail.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditUserDetailScreen extends StatefulWidget {
  static const routeName = '/EditUserDetailScreen';
  final String documentId;
  String fname;
  String lname;
  String mobile;
  String email;
  String country;
  String dob;
  String location;
  String maritalStatus;
  String nationality;

  EditUserDetailScreen({
    super.key,
    required this.documentId,
    required this.fname,
    required this.lname,
    required this.mobile,
    required this.email,
    required this.country,
    required this.dob,
    required this.location,
    required this.maritalStatus,
    required this.nationality,
  });

  @override
  _EditUserDetailScreenState createState() => _EditUserDetailScreenState();
}

class _EditUserDetailScreenState extends State<EditUserDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  String editedFname = '';
  String editedLname = '';
  String editedMobile = '';
  String editedEmail = '';
  String editedCountry = '';
  String editedDob = '';
  String editedLocation = '';
  String editedMaritalStatus = '';
  String editedNationality = '';

  @override
  void initState() {
    super.initState();
    editedFname = widget.fname;
    editedLname = widget.lname;
    editedMobile = widget.mobile;
    editedEmail = widget.email;
    editedCountry = widget.country;
    editedDob = widget.dob;
    editedLocation = widget.location;
    editedMaritalStatus = widget.maritalStatus;
    editedNationality = widget.nationality;
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
            'Edit User Detail',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
          centerTitle: true,
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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Icon(
                  Icons.person_search_outlined,
                  size: 80.0,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.fname,
                        onChanged: (value) {
                          setState(() {
                            editedFname = value;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'First Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a first name';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.lname,
                        onChanged: (value) {
                          setState(() {
                            editedLname = value;
                          });
                        },
                        decoration:
                            const InputDecoration(labelText: 'Last Name'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a last name';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.mobile,
                        onChanged: (value) {
                          setState(() {
                            editedMobile = value;
                          });
                        },
                        decoration: const InputDecoration(labelText: 'Mobile'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a mobile';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Expanded(
                      child: TextFormField(
                        initialValue: widget.country,
                        onChanged: (value) {
                          setState(() {
                            editedCountry = value;
                          });
                        },
                        decoration: const InputDecoration(labelText: 'Country'),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a country';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15.0,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FirebaseFirestore.instance
                          .collection('users')
                          .doc(widget.documentId)
                          .update(
                        {
                          'fname': editedFname,
                          'lname': editedLname,
                          'mobile': editedMobile,
                          'email': editedEmail,
                          'country': editedCountry,
                          'dob': editedDob,
                          'location': editedLocation,
                          'maritalStatus': editedMaritalStatus,
                          'nationality': editedNationality,
                        },
                      ).then(
                        (_) {
                          final updatedUserDetailPage = UserDetailPage(
                            documentId: widget.documentId,
                            fname: editedFname,
                            lname: editedLname,
                            mobile: editedMobile,
                            email: editedEmail,
                            country: editedCountry,
                            dob: editedDob,
                            location: editedLocation,
                            maritalStatus: editedMaritalStatus,
                            nationality: editedNationality,
                          );
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => updatedUserDetailPage),
                          );
                        },
                      );
                    }
                  },
                  child: const Text('Save Changes'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
