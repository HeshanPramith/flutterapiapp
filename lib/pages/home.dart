import 'package:apiapp/main.dart';
import 'package:apiapp/pages/datalist.dart';
import 'package:apiapp/pages/firebaseclouddata.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  final String firstName;
  final String lastName;
  const Home({
    Key? key,
    required this.firstName,
    required this.lastName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    List<String> nameParts = (user?.displayName ?? '').split(' ');
    String firstName = nameParts.isNotEmpty ? nameParts[0] : '';
    String lastName = nameParts.length > 1 ? nameParts[1] : '';
    String email = user?.email ?? '';
    bool isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;

    return Theme(
      data: ThemeData(
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Colors.green,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Data List API',
            style: TextStyle(
              fontSize: 16,
            ),
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
          elevation: 4.0,
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'API Data Tester By Heshan',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Welcome, $firstName $lastName',
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Email: $email',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(Datalist.routeName);
                    },
                    child: const Text('Go to API Data List'),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.of(context)
                          .pushNamed(Firebaseclouddata.routeName);
                    },
                    child: const Text('Firebase Cloud Data List'),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
