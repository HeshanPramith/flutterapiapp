// ignore_for_file: library_private_types_in_public_api

import 'dart:io';
import 'package:apiapp/main.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:country_list_pick/country_list_pick.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  _AddUserScreenState createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController countryController =
      TextEditingController(text: 'Sri Lanka');
  final TextEditingController dobController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController maritalController = TextEditingController();
  final TextEditingController nationalityController = TextEditingController();
  final TextEditingController imageController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ))!;

    if (picked != DateTime.now()) {
      dobController.text = picked.toLocal().toString().split(' ')[0];
    }
  }

  String imageUrl = '';
  Image? selectedImage;
  String? selectedMaritalStatus;

  void _uploadImage(XFile? file) async {
    if (file == null) return;
    String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFilename);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        selectedImage = Image.file(File(file.path));
      });
    } catch (e) {
      // Handle error
    }
  }

  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Theme(
        data: ThemeData(
          brightness: isDarkMode ? Brightness.dark : Brightness.light,
          primarySwatch: Colors.green,
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Add New User',
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
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20.0,
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(38, 8, 158, 76)),
                      elevation: MaterialStateProperty.all<double>(0),
                    ),
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                "Select Image Source",
                                style: TextStyle(
                                  fontSize: 16.0,
                                ),
                              ),
                            ),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  leading: const Icon(Icons.camera),
                                  title: const Text("Camera"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    XFile? file = await ImagePicker()
                                        .pickImage(source: ImageSource.camera);
                                    _uploadImage(file);
                                  },
                                ),
                                ListTile(
                                  leading: const Icon(Icons.photo),
                                  title: const Text("Gallery"),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    XFile? file = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    _uploadImage(file);
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: selectedImage ??
                            const Icon(
                              Icons.add_a_photo,
                              color: Colors.black26,
                              size: 50.0,
                            ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  CountryListPick(
                    appBar: AppBar(
                      centerTitle: true,
                      title: const Text(
                        'Select Country',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                    theme: CountryTheme(
                      isShowFlag: true,
                      isShowTitle: true,
                      isShowCode: false,
                      isDownIcon: true,
                      showEnglishName: true,
                    ),
                    initialSelection: '+94',
                    onChanged: (CountryCode? code) {
                      if (code != null) {
                        countryController.text = code.name!;
                      }
                    },
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<String>(
                        value: 'Single',
                        groupValue: selectedMaritalStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedMaritalStatus = value;
                          });
                        },
                      ),
                      const Text('Single'),
                      Radio<String>(
                        value: 'Married',
                        groupValue: selectedMaritalStatus,
                        onChanged: (value) {
                          setState(() {
                            selectedMaritalStatus = value;
                          });
                        },
                      ),
                      const Text('Married'),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: firstNameController,
                          style: const TextStyle(fontSize: 14.0),
                          decoration:
                              const InputDecoration(labelText: 'First Name'),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: TextField(
                          controller: lastNameController,
                          style: const TextStyle(fontSize: 14.0),
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: mobileController,
                          style: const TextStyle(fontSize: 14.0),
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration:
                              const InputDecoration(labelText: 'Mobile'),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: TextField(
                          controller: dobController,
                          style: const TextStyle(fontSize: 14.0),
                          onTap: () => _selectDate(context),
                          decoration: InputDecoration(
                            labelText: 'Date of Birth',
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.calendar_month),
                              onPressed: () => _selectDate(context),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: emailController,
                          style: const TextStyle(fontSize: 14.0),
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter an email';
                            } else if (!isValidEmail(value)) {
                              return 'Please enter a valid email address';
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
                        child: TextField(
                          controller: locationController,
                          style: const TextStyle(fontSize: 14.0),
                          decoration: const InputDecoration(labelText: 'Town'),
                        ),
                      ),
                      const SizedBox(
                        width: 16.0,
                      ),
                      Expanded(
                        child: TextField(
                          controller: nationalityController,
                          style: const TextStyle(fontSize: 14.0),
                          decoration:
                              const InputDecoration(labelText: 'Nationality'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 120.0,
                    child: ElevatedButton(
                      onPressed: () {
                        saveUser();
                      },
                      child: const Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Add User'),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
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
    String maritalStatus = selectedMaritalStatus ?? '';

    if (imageUrl.isNotEmpty) {
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
          'image': imageUrl,
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
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: Colors.red,
              content: Center(child: Text('Error adding user: $error')),
              duration: const Duration(seconds: 2),
            ),
          );
        },
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Center(child: Text('Please upload an image')),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
