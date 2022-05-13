import 'package:flutter/material.dart';

class Steppage extends StatelessWidget {
  const Steppage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'step';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Steppage.routename),
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  } //build

} //Page
