import 'package:flutter/material.dart';
import 'package:pet_paradise/pages/tabs.dart';
import 'package:pet_paradise/pages/welcome.dart';
import 'package:pet_paradise/widget/elevated_button.dart';
import 'package:pet_paradise/widget/text_btn.dart';
import '../components/styles.dart';

class Login extends StatefulWidget {
  static const String id = 'Login';

  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: appColor,
        elevation: 0,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
              color: backgroundColor,
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildProfile(),
                      const SizedBox(height: 80),
                      _buildProfileDtl()
                    ],
                  ),
                  Positioned(
                      top: 80,
                      width: MediaQuery.of(context).size.width * 1,
                      child: _buildLoginDetail()),
                ],
              )),
        ],
      ),
    );
  }

  Widget _buildProfile() {
    return Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.35,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        color: appColor,
        child: const Text(
          'Sign In',
          style:
              TextStyle(color: Colors.white, fontSize: 32, fontFamily: 'bold'),
        ));
  }

  Widget _buildLoginDetail() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 20.0,
              )
            ]),
        child: Column(
          children: [
            // textField('Email', Icons.check),
            // textField('Password', Icons.remove_red_eye),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                MyTextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Welcome()));
                    },
                    text: 'Do not remember the password?',
                    colors: appColor),
              ],
            ),
            const SizedBox(height: 30),
            MyElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TabsExample()));
                },
                colors: appColor,
                text: 'Sign In'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileDtl() {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [greyText('Or log in with social account')],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: imageButton('assets/images/apple.png', 'Apple'),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: imageButton('assets/images/google.png', 'Google'),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              blackText('Dont have an account?'),
              MyTextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Login()));
                  },
                  colors: appColor,
                  text: "Sign up")
            ],
          )
        ],
      ),
    );
  }

  imageButton(image, name) {
    return ElevatedButton.icon(
      icon: Image.asset(
        image,
        width: 24,
        height: 24,
      ),
      label: Text(name),
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.black, backgroundColor: Colors.white,
        shadowColor: Colors.black38,
        elevation: 5,
        padding: const EdgeInsets.all(16),
        shape: (RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        )),
      ),
    );
  }
}
