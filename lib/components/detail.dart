import 'package:apiapp/main.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:flutter/material.dart';
import 'package:apiapp/models/data.dart';
import 'package:provider/provider.dart';

class DataDetailPage extends StatelessWidget {
  final Data dataItem;

  const DataDetailPage({super.key, required this.dataItem});

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
            'Detail View',
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
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  dataItem.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  dataItem.userName,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(dataItem.numViews),
                const SizedBox(
                  height: 30,
                ),
                Image.network(dataItem.badge),
                const SizedBox(
                  height: 30,
                ),
                Text(dataItem.date),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
