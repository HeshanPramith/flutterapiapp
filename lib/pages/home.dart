import 'package:apiapp/pages/datalist.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  static const routeName = '/home';
  final Function(bool)? toggleDatkmode;
  final bool? isDark;
  const Home({Key? key, this.toggleDatkmode, this.isDark}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Data List API',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
        actions: [
          CupertinoSwitch(value: isDark ?? false, onChanged: toggleDatkmode)
        ],
        elevation: 4.0,
        centerTitle: true,
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
                const Text(
                  'Your Home Screen Content Goes Here',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                OutlinedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed(Datalist.routeName);
                  },
                  child: const Text('Go to API Data List Page'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
