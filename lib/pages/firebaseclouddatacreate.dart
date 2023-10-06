// ignore_for_file: library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController maritalController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New User'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: mobileController,
                decoration: const InputDecoration(labelText: 'Mobile'),
              ),
              TextField(
                controller: countryController,
                decoration: const InputDecoration(labelText: 'Country'),
              ),
              TextField(
                controller: dobController,
                decoration: const InputDecoration(labelText: 'Date of Birth'),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: locationController,
                decoration: const InputDecoration(labelText: 'Town'),
              ),
              TextField(
                controller: maritalController,
                decoration: const InputDecoration(labelText: 'Marital Status'),
              ),
              TextField(
                controller: nationalityController,
                decoration: const InputDecoration(labelText: 'Nationality'),
              ),
              ElevatedButton(
                onPressed: () {
                  saveUser();
                },
                child: const Text('Save User'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void saveUser() {
    String firstName = firstNameController.text;
    String lastName = lastNameController.text;
    String mobile = mobileController.text;
    String country = countryController.text;
    String dob = dobController.text;
    String email = emailController.text;
    String location = locationController.text;
    String nationality = nationalityController.text;
    String maritalStatus = maritalController.text;

    FirebaseFirestore.instance.collection('users').add(
      {
        'fname': firstName,
        'lname': lastName,
        'mobile': mobile,
        'country': country,
        'dob': dob,
        'email': email,
        'location': location,
        'nationality': nationality,
        'maritalStatus': maritalStatus,
      },
    ).then(
      (_) {
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.green,
            content: Center(child: Text('User created successfully')),
            duration: Duration(seconds: 2),
          ),
        );
      },
    ).catchError(
      (error) {
        print('Error adding user: $error');

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.red,
            content: Center(child: Text('Error adding user: $error')),
            duration: const Duration(seconds: 2),
          ),
        );
      },
    );
  }
}
