// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_paradise/Backend/Auth/auth.dart';
import 'package:pet_paradise/Commons/login_page.dart';
import 'package:pet_paradise/utils/custom_widgets/custom_widgets.dart';

import '../../utils/form_validation_controller.dart';
import '../../utils/responsive_controller.dart';
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

//Text Editing Controller
TextEditingController nameController = TextEditingController();
TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController rePasswordController = TextEditingController();
TextEditingController phoneController = TextEditingController();

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  //Form key and Auto Validate
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool autoValidate = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  final AuthNotifer _auth = AuthNotifer();
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

//SignUp Form UI
  Widget formUI(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Sign Up",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: ' Itim-Regular',
              fontSize: 27,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          //Name Field
          SizedBox(
            height: 50,
            child: TextFormField(
              validator: (arg) {
                if (arg != null) {
                  MyFormValidator.validateName(name: arg);
                }
                return null;
              },
              controller: nameController,
              keyboardType: TextInputType.text,
              decoration: textFieldDecorationWithIcon(
                  hint: "Enter Name", icon: Icons.person),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          //E-mail Field
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: textFieldDecorationWithIcon(
                  hint: "Enter Email", icon: Icons.voicemail),
              validator: (arg) {
                if (arg != null) {
                  MyFormValidator.validateEmail(email: arg);
                }
                return null;
              },
            ),
          ),
          SizedBox(
            height: 15,
          ),
          //Password Field

          //Password Field
          SizedBox(
            height: 50,
            child: TextFormField(
              validator: (arg) {
                if (arg != null) {
                  final passwordError =
                      MyFormValidator.validatePassword(password: arg);
                  if (passwordError != null) {
                    return passwordError;
                  }
                }
                return null;
              },
              controller: passwordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: textFieldDecorationWithIcon(
                  hint: "Enter Password", icon: Icons.lock_open),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          //Re-Enter Password Field
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: rePasswordController,
              obscureText: true,
              keyboardType: TextInputType.text,
              decoration: textFieldDecorationWithIcon(
                  hint: "Re-enter Password", icon: Icons.lock_open),
              validator: (arg) {
                if (arg != null) {
                  MyFormValidator.validatePassword(password: arg);
                }
                return null;
              },
            ),
          ),

          SizedBox(
            height: 15,
          ),
          //SignUp Button
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                minWidth: 139,
                height: 39,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                onPressed: () async {
                  if (passwordController.text == rePasswordController.text) {
                    _auth.register(
                      emailController.text,
                      passwordController.text,
                      nameController.text,
                      context,
                    );
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Password Error"),
                          content:
                              Text("The passwords you entered do not match."),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text("OK"),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                textColor: Colors.black,
                color: MyColors.MATERIAL_LIGHT_GREEN,
                child: Text("Sign Up"),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Already have an account?"),
              GestureDetector(
                onTap: () {
                  print("tannn tnnna");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
                child: Text(
                  " Login",
                  style: TextStyle(
                      color: MyColors.MATERIAL_LIGHT_GREEN,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  /// Mobile
  Widget mobile(BuildContext context) {
    return Stack(
      children: [
        backgroundWidget(),
        SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(
                left: MyAppSize.width! * 0.05, right: MyAppSize.width! * 0.05),
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
                  "Welcome\nTo Pet Paradise~",
                  style: TextStyle(
                      fontFamily: ' Itim-Regular',
                      fontSize: 27,
                      fontWeight: FontWeight.bold),
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
                      child: formUI(context)),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
