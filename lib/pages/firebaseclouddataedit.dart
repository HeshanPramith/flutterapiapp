// ignore_for_file: library_private_types_in_public_api, must_be_immutable

import 'dart:io';
import 'package:apiapp/components/countrymapping.dart';
import 'package:apiapp/main.dart';
import 'package:apiapp/pages/firebaseclouddatadetail.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:country_list_pick/country_list_pick.dart';

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
  String image;

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
    required this.image,
  });

  @override
  _EditUserDetailScreenState createState() => _EditUserDetailScreenState();
}

class _EditUserDetailScreenState extends State<EditUserDetailScreen> {
  final _formKey = GlobalKey<FormState>();
  final List<String> maritalStatuses = ['Single', 'Married'];
  String editedFname = '';
  String editedLname = '';
  String editedMobile = '';
  String editedEmail = '';
  String editedCountry = '';
  String editedDob = '';
  String editedLocation = '';
  String selectedMaritalStatus = '';
  String editedNationality = '';
  String editedImage = '';

  DateTime? selectedDate;

  TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    super.initState();
    editedFname = widget.fname;
    editedLname = widget.lname;
    editedMobile = widget.mobile;
    editedEmail = widget.email;
    editedCountry = widget.country;
    dobController.text = widget.dob;
    editedLocation = widget.location;
    selectedMaritalStatus = widget.maritalStatus;
    editedNationality = widget.nationality;
    editedImage = widget.image;
  }

  Future<void> uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file == null) return;
    String uniqueFilename = DateTime.now().millisecondsSinceEpoch.toString();
    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImages = referenceRoot.child('images');
    Reference referenceImageToUpload = referenceDirImages.child(uniqueFilename);
    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {
        editedImage = imageUrl;
      });
    } catch (e) {
      // Handle the error here
    }
  }

  String imageUrl = '';

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: Colors.green,
        content: Center(child: Text('User Details Updated Successfully')),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void showErrorSnackbar(String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Center(child: Text(errorMessage)),
        duration: const Duration(seconds: 2),
      ),
    );
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
              'Edit User',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25.0),
                    child: Text(
                      '$editedFname $editedLname',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(100.0),
                        child: Image.network(
                          widget.image,
                          width: 100.0,
                          height: 100.0,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  SizedBox(
                    width: 205.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        await uploadImage();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color.fromARGB(255, 190, 190, 190)),
                        elevation: const MaterialStatePropertyAll(0),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.change_circle_outlined,
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Change Profile Picture'),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: CountryListPick(
                          appBar: AppBar(
                            centerTitle: true,
                            title: const Text(
                              'Select Country',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ),
                          initialSelection:
                              CountryCodeHelper.getCountryCodeFromName(
                                  widget.country),
                          onChanged: (CountryCode? code) {
                            setState(() {
                              editedCountry = code!.name!;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: maritalStatuses
                        .map(
                          (status) => Row(
                            children: [
                              Radio(
                                value: status,
                                groupValue: selectedMaritalStatus,
                                onChanged: (value) {
                                  setState(() {
                                    selectedMaritalStatus = value as String;
                                  });
                                },
                              ),
                              Text(status),
                            ],
                          ),
                        )
                        .toList(),
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
                          keyboardType: TextInputType.number,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          decoration:
                              const InputDecoration(labelText: 'Mobile'),
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
                          controller: dobController,
                          onTap: () async {
                            DateTime? selectedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (selectedDate != null) {
                              setState(() {
                                dobController.text = selectedDate
                                    .toLocal()
                                    .toString()
                                    .split(' ')[0];
                              });
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'DOB',
                            suffixIcon: Icon(Icons.calendar_month),
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please select a date of birth';
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
                          initialValue: widget.email,
                          onChanged: (value) {
                            setState(() {
                              editedEmail = value;
                            });
                          },
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
                        child: TextFormField(
                          initialValue: widget.location,
                          onChanged: (value) {
                            setState(() {
                              editedLocation = value;
                            });
                          },
                          decoration: const InputDecoration(labelText: 'Town'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a location';
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
                          initialValue: widget.nationality,
                          onChanged: (value) {
                            setState(() {
                              editedNationality = value;
                            });
                          },
                          decoration:
                              const InputDecoration(labelText: 'Nationality'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a nationality';
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
                  SizedBox(
                    width: 155.0,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          String formattedDate = selectedDate != null
                              ? selectedDate!.toLocal().toString().split(' ')[0]
                              : dobController.text;
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
                              'dob': formattedDate,
                              'location': editedLocation,
                              'maritalStatus': selectedMaritalStatus,
                              'nationality': editedNationality,
                              'image': editedImage,
                            },
                          ).then(
                            (_) {
                              showSnackbar('Changes saved successfully');
                              final updatedUserDetailPage = UserDetailPage(
                                documentId: widget.documentId,
                                fname: editedFname,
                                lname: editedLname,
                                mobile: editedMobile,
                                email: editedEmail,
                                country: editedCountry,
                                dob: formattedDate,
                                location: editedLocation,
                                maritalStatus: selectedMaritalStatus,
                                nationality: editedNationality,
                                image: editedImage,
                              );
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        updatedUserDetailPage),
                              );
                            },
                          ).catchError((error) {
                            showErrorSnackbar('Error saving changes: $error');
                          });
                        }
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.file_upload_outlined),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text('Save Changes'),
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
}
