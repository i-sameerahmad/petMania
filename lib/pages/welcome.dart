import 'package:flutter/material.dart';
import 'package:pet_paradise/pages/login.dart';
import 'package:pet_paradise/widget/text_btn.dart';
import '../components/styles.dart';

class Welcome extends StatefulWidget {
  static const String id = 'Welcome';

  const Welcome({Key? key}) : super(key: key);

  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return Container(
            color: appColor,
            height: height,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 52),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                      text: 'Welcome \n to ',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'bold',
                          fontSize: 40),
                      children: [
                        TextSpan(
                          text: 'Pet Mania',
                          style: TextStyle(
                              color: appColor3,
                              fontFamily: 'bold',
                              fontSize: 40),
                        ),
                      ]),
                ),
                Column(
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const ImageIcon(AssetImage('assets/images/google.png'),
                            color: appColor),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: appColorDark, backgroundColor: Colors.white,
                          shadowColor: appColor,
                          elevation: 3,
                          shape: (RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          )),
                        ),
                        label: RichText(
                          text: const TextSpan(
                              text: 'Continue with ',
                              style: TextStyle(color: appColor, fontSize: 14),
                              children: [
                                TextSpan(
                                    text: 'Google',
                                    style: TextStyle(
                                        color: appColor,
                                        fontFamily: 'bold',
                                        fontSize: 14)),
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black54, padding: const EdgeInsets.all(14),
                          side: const BorderSide(
                            color: Colors.white,
                          ),
                          backgroundColor: Colors.transparent,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const Login()),
                          );
                        },
                        child: const Text("Register with Email",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Dont have an account?",
                      style: TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                    MyTextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const Login()));
                        },
                        colors: Colors.white,
                        text: "Sign In")
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
