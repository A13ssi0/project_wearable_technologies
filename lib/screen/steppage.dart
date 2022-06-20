import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/utils/manageFitBitData.dart';

class Steppage extends StatelessWidget {
  const Steppage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'step';

  @override
  Widget build(BuildContext context) {
    fetchStep();
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
