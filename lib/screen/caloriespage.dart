import 'package:flutter/material.dart';

class Caloriespage extends StatelessWidget {
  const Caloriespage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'calories';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Caloriespage.routename),
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  } //build

} //Page
