import 'package:flutter/material.dart';
import 'package:apiapp/models/data.dart';

class DataDetailPage extends StatelessWidget {
  final Data dataItem;

  const DataDetailPage({super.key, required this.dataItem});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail View'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              dataItem.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'User: ${dataItem.userName}',
              style: const TextStyle(fontSize: 18),
            ),
            Text(dataItem.numViews),
            Image.network(dataItem.badge),
            Text(dataItem.date),
          ],
        ),
      ),
    );
  }
}
