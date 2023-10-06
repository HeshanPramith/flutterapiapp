import 'package:apiapp/main.dart';
import 'package:apiapp/pages/firebaseclouddata.dart';
import 'package:apiapp/pages/firebaseclouddataedit.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserDetailPage extends StatefulWidget {
  static const routeName = '/UserDetailPage';
  final String documentId;
  final String fname;
  final String lname;
  final String mobile;
  final String email;
  final String country;
  final String dob;
  final String location;
  final String maritalStatus;
  final String nationality;

  const UserDetailPage({
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
  State<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends State<UserDetailPage> {
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
            'User Detail',
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
                  builder: (context) => const Firebaseclouddata(),
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
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  child: const Text("Edit User"),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditUserDetailScreen(
                          documentId: widget.documentId,
                          fname: widget.fname,
                          lname: widget.lname,
                          mobile: widget.mobile,
                          email: widget.email,
                          country: widget.country,
                          dob: widget.dob,
                          location: widget.location,
                          maritalStatus: widget.maritalStatus,
                          nationality: widget.nationality,
                        ),
                      ),
                    );
                  },
                ),
                const Icon(
                  Icons.person_search_outlined,
                  size: 80.0,
                  color: Colors.red,
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  '${widget.fname} ${widget.lname}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                if (widget.mobile != 'N/A') Text('Mobile: ${widget.mobile}'),
                if (widget.mobile != 'N/A')
                  const SizedBox(
                    height: 10.0,
                  ),
                if (widget.email != 'N/A') Text('Email: ${widget.email}'),
                if (widget.email != 'N/A')
                  const SizedBox(
                    height: 10.0,
                  ),
                if (widget.country != 'N/A') Text('Country: ${widget.country}'),
                if (widget.country != 'N/A')
                  const SizedBox(
                    height: 10.0,
                  ),
                if (widget.dob != 'N/A') Text('Date of Birth: ${widget.dob}'),
                if (widget.dob != 'N/A')
                  const SizedBox(
                    height: 10.0,
                  ),
                if (widget.location != 'N/A')
                  Text('Location: ${widget.location}'),
                if (widget.location != 'N/A')
                  const SizedBox(
                    height: 10.0,
                  ),
                if (widget.maritalStatus != 'N/A')
                  Text('Marital Status: ${widget.maritalStatus}'),
                if (widget.maritalStatus != 'N/A')
                  const SizedBox(
                    height: 10.0,
                  ),
                if (widget.nationality != 'N/A')
                  Text('Nationality: ${widget.nationality}'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
