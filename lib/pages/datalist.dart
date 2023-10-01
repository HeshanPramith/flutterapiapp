import 'package:apiapp/components/listview.dart';
import 'package:apiapp/models/data.dart';
import 'package:apiapp/services/service.dart';
import 'package:flutter/material.dart';

class Datalist extends StatelessWidget {
  static const routeName = '/datalist';
  const Datalist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'API Data List Page',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: FutureBuilder<List<Rocket>?>(
        future: RocketService.getRockets(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text(
                'Error',
              ),
            );
          } else if (snapshot.hasData) {
            List<Rocket>? rockets = snapshot.data;
            print(snapshot.data);
            return Container(
              padding: const EdgeInsets.all(
                10,
              ),
              child: rockets == null
                  ? const Text('Empty')
                  : RocketListView(rockets: rockets),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
