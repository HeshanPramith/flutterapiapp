import 'package:apiapp/components/listview.dart';
import 'package:apiapp/main.dart';
import 'package:apiapp/models/data.dart';
import 'package:apiapp/pages/signin.dart';
import 'package:apiapp/services/service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Datalist extends StatelessWidget {
  static const routeName = '/datalist';
  const Datalist({super.key});

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
            'API Data List Page',
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
        body: FutureBuilder<List<Data>?>(
          future: DataService.getDataall(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  'Error',
                ),
              );
            } else if (snapshot.hasData) {
              List<Data>? dataall = snapshot.data;
              return Container(
                padding: const EdgeInsets.all(
                  10,
                ),
                child: dataall == null
                    ? const Text('Empty')
                    : DataListView(dataall: dataall),
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
