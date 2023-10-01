import 'package:apiapp/models/data.dart';
import 'package:flutter/material.dart';

class RocketListView extends StatelessWidget {
  late final List<Rocket> rockets;

  // ignore: prefer_const_constructors_in_immutables
  RocketListView({super.key, required this.rockets});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: rockets.length,
      itemBuilder: (context, index) {
        Rocket rocket = rockets[index];

        return Card(
          child: ListTile(
            title: Text(rocket.name),
            subtitle: Text(rocket.firstFlight),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          ),
        );
      },
    );
  }
}
