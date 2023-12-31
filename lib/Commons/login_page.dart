// ignore_for_file: prefer_const_constructors

import 'package:pet_mania/Backend/Auth/auth.dart';
import 'package:pet_mania/Commons/reset_password_page.dart';
import 'package:pet_mania/Commons/signup_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pet_mania/utils/custom_widgets/custom_widgets.dart';
import 'package:pet_mania/utils/responsive_controller.dart';
import 'package:pet_mania/utils/colors.dart';
import '../../utils/size_config.dart';

//Text Editing Controller
TextEditingController loginEmailController = TextEditingController();
TextEditingController loginPasswordController = TextEditingController();
@override
void dispose() {
  loginEmailController.dispose();
  loginPasswordController.dispose();
  // super.dispose();
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool progressIndicator = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  final AuthNotifier _auth = AuthNotifier();
  @override
  Widget build(BuildContext context) {
    MyAppSize.config(MediaQuery.of(context));
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: transparentAppBar(context: context),
        body: Responsive(
          mobile: mobile(context),
          tablet: tabletUI(),
          web: webUI(),
        ));
  }

  //TODO : Mobile
  Widget mobile(BuildContext context) {
    return Stack(
      children: [
        backgroundWidget(),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: MyAppSize.width! * 0.05, right: MyAppSize.width! * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                //Logo Image
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                      height: 180,
                      width: 180,
                      child: Image(
                          image: AssetImage(
                        "assets/images/logo.png",
                      ))),
                ),
                //Text Descriptions
                Text(
                  "Welcome\nTo Pet Mania~",
                  style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 27, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  " A dream-filled Paradise",
                  style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 16),
                ),
                SizedBox(
                  height: 20,
                ),
                //Login Card
                Card(
                  elevation: 5,
                  shadowColor: MyColors.MATERIAL_LIGHT_GREEN,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: MyAppSize.width! * 0.025,
                      right: MyAppSize.width! * 0.025,
                      top: 20,
                      bottom: 30,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          "Login",
                          style: TextStyle(fontWeight: FontWeight.bold, fontFamily: ' Itim-Regular', fontSize: 27),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //TODO : Email Field
                        SizedBox(
                          height: 50,
                          child: TextFormField(
                            controller: loginEmailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: textFieldDecorationWithIcon(hint: "Enter Email", icon: Icons.voicemail),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //TODO:Password Field
                        SizedBox(
                          height: 50,
                          child: TextField(
                            controller: loginPasswordController,
                            obscureText: true,
                            keyboardType: TextInputType.text,
                            decoration: textFieldDecorationWithIcon(
                              hint: "Enter Password",
                              icon: Icons.lock_open_rounded,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //TODO: Forgot Password
                        clickAbleText(
                            enable: true,
                            text: "Forgot Password?",
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => ResetPasswordPage()));
                            },
                            textColor: MyColors.RED,
                            fontWeight: FontWeight.bold,
                            textAlign: TextAlign.end),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MaterialButton(
                              minWidth: 139,
                              height: 39,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              onPressed: () async {
                                _auth.login(loginEmailController.text, loginPasswordController.text, context);
                              },
                              textColor: Colors.black,
                              color: MyColors.MATERIAL_LIGHT_GREEN,
                              child: Text("Login"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),

                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?"),
                            clickAbleText(
                                enable: true,
                                text: " SignUp",
                                onTap: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
                                },
                                underLine: true,
                                textColor: MyColors.MATERIAL_LIGHT_GREEN,
                                fontWeight: FontWeight.bold),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
