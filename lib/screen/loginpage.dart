import 'package:fitbitter/fitbitter.dart';
import 'package:flutter/material.dart';
import 'package:project_wearable_technologies/repository/databaseRepository.dart';
import 'package:project_wearable_technologies/screen/homepage.dart';
import 'package:project_wearable_technologies/utils/palette.dart';
import 'package:project_wearable_technologies/utils/strings.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Loginpage extends StatefulWidget {
  Loginpage({Key? key}) : super(key: key);

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
  void initState()  {
    super.initState();
    excuteLogin();

  }
  Future<void> excuteLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user')!=null){
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
    prefs.setString('user', userId!);
    prefs.setString('UserName', Usernamecontroller.text);
    prefs.setString('Password', Passwordcontroller.text);

    Navigator.pushNamed(context, Homepage.routename);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.color4,
      appBar: AppBar(
        backgroundColor: Palette.color5,
        title: Text(Loginpage.routename),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 500,
          decoration: BoxDecoration(
              color: Palette.color2,
              border: Border.all(
                width: 0,
                color: Colors.amberAccent,
              ),
              borderRadius: BorderRadius.all(Radius.circular(50))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 13, 0, 0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/Jigglypuff2.jpg',
                    width: MediaQuery.of(context).size.width*0.65,
                  ),

                ),
              ),

              Text(
                'Bentornato',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 0, 32, 12),
                      child: TextField(
                        controller: Usernamecontroller,
                        decoration: InputDecoration(
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
                        controller: Passwordcontroller,
                        obscureText: true,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Password',
                            hintText: 'Password',
                            contentPadding: EdgeInsets.fromLTRB(12, 6, 8, 0)),
                      ),
                    ),
                  ),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  )
                ],
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [


                    Container(
                      margin: EdgeInsets.fromLTRB(12, 12, 12, 2),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Palette.color5,
                          ),
                          onPressed: () async {
                            if (Usernamecontroller.text !=
                                    Strings.LoginUserName ||
                                Passwordcontroller.text !=
                                    Strings.LoginPassword) {
                              setState(() {
                                error = 'Attenzione uno dei campi è errato';
                              });

                              return;
                            }
                            setState(() {
                              error = '';
                            });
                            print(Strings.userId);
                            // Obtain shared preferences.
                           Login();

                          },
                          child: const Text('Login')),
                    ),
                    // ElevatedButton(
                    // style: ElevatedButton.styleFrom(
                    // primary: Palette.color5,
                    //),
                    //onPressed: () async {
                    //await FitbitConnector.unauthorize(
                    //clientID: Strings.fitbitClientID,
                    //clientSecret: Strings.fitbitClientSecret,
                    //);
                    // },
                    //child: const Text('Tap to Unauthorize')
                    // ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

  //build

//Page
