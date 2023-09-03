import 'package:flutter/material.dart';
import 'package:pet_mania/utils/custom_widgets/custom_widgets.dart';
import 'package:pet_mania/utils/responsive_controller.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:pet_mania/utils/size_config.dart';

TextEditingController resetPasswordEmailController = TextEditingController();

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({Key? key}) : super(key: key);

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  @override
  Widget build(BuildContext context) {
    MyAppSize.config(MediaQuery.of(context));
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back,
            color: MyColors.MATERIAL_LIGHT_GREEN,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Responsive(
        mobile: mobile(context),
        tablet: tabletUI(),
        web: webUI(),
      ),
    );
  }

  ///MOBILE
  Widget mobile(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: MyAppSize.width,
          child: const Image(
            image: AssetImage("assets/images/rectDesign.png"),
            alignment: Alignment.topRight,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: MyAppSize.width! * 0.05, right: MyAppSize.width! * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Image(width: 90, height: 80, image: AssetImage("assets/images/lock.png")),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Forgot Your Password?",
                style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 17, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Enter Your Email Bellow To Reset Your Password",
                style: TextStyle(
                  fontFamily: ' Itim-Regular',
                  fontSize: 13,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 50,
              ),
              TextField(
                controller: resetPasswordEmailController,
                keyboardType: TextInputType.emailAddress,
                decoration: textFieldDecorationWithIcon(hint: "Enter Your Email", icon: Icons.voicemail),
              ),
              const SizedBox(
                height: 50,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    minWidth: 193,
                    height: 39,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    onPressed: () {},
                    textColor: Colors.black,
                    color: MyColors.MATERIAL_LIGHT_GREEN,
                    child: const Text(
                      "Submit",
                      style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
