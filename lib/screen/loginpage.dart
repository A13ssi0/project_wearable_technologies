import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/utils/palette.dart';
import 'package:project_wearable_technologies/utils/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  static const route = '/';
  static const routename = 'login';

  @override
  State<Loginpage> createState() => _LoginpageState();
}

class _LoginpageState extends State<Loginpage> {
  TextEditingController Usernamecontroller = TextEditingController();

  TextEditingController Passwordcontroller = TextEditingController();
  String error = '';
  @override
  void initState() {
    super.initState();
    excuteLogin();
  }

  Future<void> excuteLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      Login();
    }
  }

  Future<void> Login() async {
    final prefs = await SharedPreferences.getInstance();
    String? userId = await FitbitConnector.authorize(
        context: context,
        clientID: Strings.fitbitClientID,
        clientSecret: Strings.fitbitClientSecret,
        redirectUri: Strings.fitbitRedirectUri,
        callbackUrlScheme: Strings.fitbitCallbackScheme);

    Strings.writeUserId(userId!);
    prefs.setString('user', userId);
    prefs.setString('UserName', Usernamecontroller.text);
    prefs.setString('Password', Passwordcontroller.text);
    prefs.setInt('Money', 5000);
    prefs.setString('DayLogin', DateFormat('yyyy-MM-dd').format(DateTime.now()));

    Navigator.pushNamed(context, Homepage.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.color2,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 500,
          decoration: BoxDecoration(
              color: Palette.color3,
              border: Border.all(
                width: 0,
                color: Colors.amberAccent,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(50))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              title(),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 13, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/Jigglypuffwe.gif',
                    width: MediaQuery.of(context).size.width * 0.65,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
                      child: TextField(//colore tasto login
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        controller: Usernamecontroller,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'UserName',
                            hintText: 'Enter UserName',
                            contentPadding: EdgeInsets.fromLTRB(12, 6, 8, 0)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
                      child: TextField(
                        style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                        controller: Passwordcontroller,
                        obscureText: true,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Password',
                            contentPadding: EdgeInsets.fromLTRB(12, 6, 8, 0)),
                      ),
                    ),
                  ),
                  Text(
                    error,
                    style: const TextStyle(color: Colors.red),
                  )
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(12, 12, 12, 2),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Palette.color1,
                        ),
                        onPressed: () async {
                          if (Usernamecontroller.text != Strings.LoginUserName ||
                              Passwordcontroller.text != Strings.LoginPassword) {
                            setState(() {
                              error = 'Attenzione uno dei campi è errato';
                            });

                            return;
                          }
                          setState(() {
                            error = '';
                          });
                          // Obtain shared preferences.
                          Login();

                          return;

                        },


                        child: const Text('Login')),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
  Widget title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 25,
        ),
        Row(
          children: [
            const SizedBox(
              width: 30,
            ),
            Text('Welcome', textAlign: TextAlign.start, style: TextStyle(fontSize: 40, color: Palette.color4, fontFamily: 'Lobster')),
          ],
        ),
        const SizedBox(
          height: 23,
        ),
      ],
    );
  }
} //Page



  //build

//Page
