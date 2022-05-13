import 'package:flutter/material.dart';

class Mealpage extends StatelessWidget {
  const Mealpage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'meal';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(Mealpage.routename),
      ),
      body: const Center(
        child: Text('Hello, world!'),
      ),
    );
  } //build

} //Page
