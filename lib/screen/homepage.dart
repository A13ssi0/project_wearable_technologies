import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/screen/steppage.dart';
import 'package:provider/provider.dart';

import '../classes/clockTimer.dart';
import '../utils/NavBar.dart';
import '../utils/plotSleep.dart';
import 'heartpage.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'homepage';
  static var database;

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    super.initState();
    Provider.of<Clock>(context, listen: false).startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text(Homepage.routename),
      ),
      drawer: const NavBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, HeartPage.routename);
              },
              child: const Card(
                elevation: 10,
                child: Text(
                  'Heart',
                  style: TextStyle(fontSize: 20),
                ),
                // ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, Steppage.routename);
              },
              child: const Card(
                elevation: 10,
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
                  child: Text(
                    'Steps',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Card(
                child: SizedBox(
                  height: 300,
                  child: plotSleep(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  //build
  }

  Future<void> kk() async {
    await creatingDatabase();
  }

  Future<void> creatingDatabase() async {
  }
} //Page
