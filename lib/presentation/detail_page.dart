import 'package:flutter/material.dart';
import 'package:helios_test/core/model/user.dart';

class DetailPage extends StatelessWidget {
  static const String routeName = '/DetailPage';

  final User user;

  const DetailPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Name: ${user.name.first} ${user.name.last}'),
            Text('Email : ${user.email}'),
          ]
        ),
      )
    );
  }
}
