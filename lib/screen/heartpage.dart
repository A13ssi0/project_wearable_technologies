import 'package:flutter/material.dart';

class HeartPage extends StatelessWidget {
  const HeartPage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'heart';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(HeartPage.routename),
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  } //build

} //Page
