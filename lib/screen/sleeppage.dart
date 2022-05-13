import 'package:flutter/material.dart';

class Sleeppage extends StatelessWidget {
  const Sleeppage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'sleep';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Sleeppage.routename),
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  } //build

} //Page
