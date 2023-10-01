import 'package:apiapp/components/detail.dart';
import 'package:apiapp/models/data.dart';
import 'package:flutter/material.dart';

class DataListView extends StatelessWidget {
  late final List<Data> dataall;

  // ignore: prefer_const_constructors_in_immutables
  DataListView({super.key, required this.dataall});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: dataall.length,
      itemBuilder: (context, index) {
        Data rocket = dataall[index];

        return Card(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(50.0),
              child: Image.network(
                rocket.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(rocket.title),
            subtitle: Text(rocket.userName),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DataDetailPage(dataItem: rocket),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
