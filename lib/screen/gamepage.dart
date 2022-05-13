import 'package:flutter/material.dart';

class Gamepage extends StatelessWidget {
  const Gamepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'game';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Gamepage.routename),
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  } //build

} //Page
