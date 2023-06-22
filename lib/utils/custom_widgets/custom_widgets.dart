//TODO: My Custom Button For Dashboards

//TODO : My Custom Button Widget

import 'package:flutter/material.dart';
import 'package:pet_paradise/Commons/edituser.dart';
import 'package:pet_paradise/Commons/login_page.dart';
import 'package:pet_paradise/Commons/mybookings.dart';
import 'package:pet_paradise/Commons/myorders.dart';
import 'package:pet_paradise/Commons/mypets.dart';
import 'package:pet_paradise/petPanda_Module/cart.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:pet_paradise/utils/responsive_controller.dart';

import 'package:pet_paradise/utils/size_config.dart';

Widget MyButton(
    {required void Function()? onPressed,
    required String title,
    required Color color,
    required Color textColor,
    double? fontSize,
    Color? splashColor,
    double? height,
    double? borderRadius,
    double? width,
    String? fontFamily}) {
  return SizedBox(
    height: height ?? 48,
    width: width,
    child: MaterialButton(
      onPressed: onPressed,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10)),
      color: color,
      splashColor: splashColor ?? MyColors.PARRIT_GREEN,
      child: Text(
        title,
        style: TextStyle(color: textColor, fontFamily: fontFamily, fontSize: fontSize ?? 18, fontWeight: FontWeight.w700),
      ),
    ),
  );
}

/// InputDecoration for Login and Sign up TextFields
InputDecoration textFieldDecorationWithIcon({required String hint, IconData? icon, double? borderRadius}) {
  return InputDecoration(
    hintText: hint,
    prefixIcon: Icon(icon),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
    ),
  );
}

Widget drawer(
  context,
) {
  return Drawer(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Colors.amber,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  //borderRadius: radius(100),
                ),
                child: Image.asset(
                  'assets/images/use1.jpg',
                  height: 58,
                  width: 58,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Ahmar', style: TextStyle(color: Colors.white, fontSize: 18)),
                      Text('03104747899', style: TextStyle(color: Colors.black)),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EditUserPage()));
                    },
                  )
                ],
              ),
            ],
          ),
        ),
        ListTile(
          minLeadingWidth: 0,
          title: const Text("My pets", style: TextStyle()),
          leading: const Icon(Icons.access_time_rounded, color: Colors.blue),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyPets()));
          },
        ),
        ListTile(
          minLeadingWidth: 0,
          title: const Text("My Bookings", style: TextStyle()),
          leading: const Icon(Icons.star_border, color: Colors.brown),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyBookings()));
          },
        ),

        ListTile(
          minLeadingWidth: 0,
          title: const Text("Cart", style: TextStyle()),
          leading: const Icon(Icons.trolley, color: Colors.brown),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Cart(), // Replace CartPage with your actual cart page
              ),
            );
          },
        ),
        ListTile(
          minLeadingWidth: 0,
          title: const Text("My Orders", style: TextStyle()),
          leading: const Icon(Icons.payment, color: Colors.amber),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => MyOrders()));
          },
        ),
        // ListTile(
        //   minLeadingWidth: 0,
        //   title: const Text("Notification", style: TextStyle()),
        //   leading: const Icon(Icons.notifications_none_outlined, color: Colors.amber),
        //   onTap: () {},
        // ),
        // ListTile(
        //   minLeadingWidth: 0,
        //   title: const Text("My favourites", style: TextStyle()),
        //   leading: const Icon(Icons.star_border, color: Colors.brown),
        //   onTap: () {},
        // ),
        ListTile(
          title: const Text('LogOut'),
          leading: const Icon(Icons.exit_to_app),
          onTap: () {
            Navigator.pop(context);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
            );
          },
        ),
      ],
    ),
  );
}

/// InputDecoration for Login and Sign up TextFields
InputDecoration textFieldDecorationWithOutIcon({required String hint, double? borderRadius}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: const TextStyle(
      fontSize: 13,
    ),
    counter: const Offstage(),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius ?? 5),
    ),
  );
}

///Login and SignUp Button
Widget loginAndSignUpButton({required Function onPressed, required String title}) {
  return MaterialButton(
    onPressed: onPressed(),
    textColor: Colors.black,
    minWidth: 139,
    height: 39,
    color: MyColors.MATERIAL_LIGHT_GREEN,
    child: Text(title),
  );
}

/// Main Dashboard Card

Widget dashboardCard({required Function onTap, required String logoImgPath, required String title}) {
  return GestureDetector(
    onTap: onTap(),
    child: SizedBox(
      height: 250,
      width: MyAppSize.width! * 44,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(image: AssetImage(logoImgPath)),
            Text(title),
          ],
        ),
      ),
    ),
  );
}

///Background Widget
Widget backgroundWidget() {
  return SizedBox(
    width: MyAppSize.width,
    child: const Image(
      image: AssetImage("assets/images/rectDesign.png"),
      alignment: Alignment.topRight,
    ),
  );
}

/// MyAppBar with TransparentBackground
AppBar transparentAppBar({required BuildContext context, String? centerTitle}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0,
    centerTitle: centerTitle == null ? false : true,
    title: Text(centerTitle ?? ''),
    leading: GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
      },
      // child: const Icon(
      //   Icons.arrow_back,
      //   color: MyColors.MATERIAL_LIGHT_GREEN,
      // ),
    ),
  );
}

/// Right and Left Padding for All Pages
Padding leftAndRightPadding({required Widget child}) {
  return Padding(
    padding: EdgeInsets.only(right: MyAppSize.width! * 0.05, left: MyAppSize.width! * 0.05),
    child: child,
  );
}

///Code Verification TextField
Widget codeVerificationTextField({required BuildContext context, required TextEditingController controller, double? width, required int digitNumber}) {
  return SizedBox(
      width: width ?? MyAppSize.width! * 0.14,
      height: 55,
      child: TextField(
          decoration: textFieldDecorationWithOutIcon(
            hint: "-",
            borderRadius: 10,
          ),
          textAlign: TextAlign.center,
          maxLength: 1,
          showCursor: false,
          autofocus: true,
          keyboardType: TextInputType.number,
          onChanged: (str) {
            if (digitNumber > 1 && digitNumber < 6) {
              if (str.length == 1) {
                FocusScope.of(context).nextFocus();
              } else if (str.isEmpty) {
                FocusScope.of(context).previousFocus();
              }
            } else if (digitNumber == 1) {
              if (str.length == 1) {
                FocusScope.of(context).nextFocus();
              }
            } else {
              if (str.isEmpty) {
                FocusScope.of(context).previousFocus();
              } else {
                FocusScope.of(context).unfocus();
              }
            }
          }));
}

///Clickable Text
Widget clickAbleText(
    {required String text, required void Function() onTap, bool? enable, bool? underLine, double? textSize, Color? textColor, TextAlign? textAlign, FontWeight? fontWeight, String? fontFamily}) {
  return GestureDetector(
    onTap: enable == true ? onTap : null,
    child: Text(
      text,
      style: TextStyle(
        color: textColor ?? Colors.black,
        decoration: underLine == null ? TextDecoration.none : TextDecoration.underline,
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: textSize ?? 13,
        fontFamily: fontFamily,
      ),
      textAlign: textAlign ?? TextAlign.start,
    ),
  );
}

///Seller Center Profile Card

Widget sellerCenterCard({required BuildContext buildContext}) {
  return SizedBox(
    width: MyAppSize.width,
    height: 325.0,
    child: Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("Please Complete Profile "),
          ListView.builder(itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: Text("${index + 1}"),
              title: const Text("Button"),
              trailing: const Icon(Icons.abc),
            );
          }),
        ],
      ),
    ),
  );
}

///Important Text
Widget importantText({required String text, double? fontSize, Color? textColor}) {
  return Row(
    children: [
      const Text(
        "*",
        style: TextStyle(color: Colors.red),
      ),
      Text(
        text,
        style: TextStyle(color: textColor ?? Colors.grey, fontSize: fontSize ?? 13, fontFamily: 'Itim-Regular'),
      )
    ],
  );
}

///ReadOnly Text Field
Widget myCustomTextFiled({required BuildContext context, required TextEditingController controller, required String hint, bool important = false}) {
  return SizedBox(
      height: 30,
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          label: important ? importantText(text: hint) : Text(hint),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        ),
      ));
}

///Custom Body
Widget customBodyWithCenterTextAppBar({
  required BuildContext context,
  required String appBarTitle,
  required Responsive responsiveScreens,
  //SellerBottomNavBar? bottomNavigationBar
}) {
  return Scaffold(
    //bottomNavigationBar: bottomNavigationBar,
    backgroundColor: MyColors.WHITE_WITH_GREEN_SHADE,
    appBar: transparentAppBar(context: context, centerTitle: appBarTitle),
    body: responsiveScreens,
  );
}

///Seller Profile Container
Widget sellerProfileContainer({required String tittle, required Function onTap, bool? topBorder, bool? bootomBorder}) {
  return GestureDetector(
      onTap: onTap(),
      child: Column(
        children: [
          Container(
            height: topBorder == null ? 0 : 1,
            color: MyColors.GREEN_LIGHT_SHADE,
          ),
          Container(
            height: 50,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: Text(
                    tittle,
                    style: const TextStyle(fontSize: 15, fontFamily: 'Itim-Regular'),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: MyColors.GREEN,
                )
              ],
            ),
          ),
          Container(
            height: bootomBorder == null ? 0 : 1,
            color: MyColors.GREEN_LIGHT_SHADE,
          ),
        ],
      ));
}

/// Seller Tools Button
Widget sellerToolButton({required Function() onTape, required String title, required String imgPath}) {
  return GestureDetector(
    onTap: onTape,
    child: SizedBox(
      height: 100,
      width: 65,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(image: AssetImage(imgPath)),
          const SizedBox(
            height: 5,
          ),
          Text(
            title,
            style: const TextStyle(fontFamily: 'itim-Regular', fontSize: 14),
          )
        ],
      ),
    ),
  );
}

///Seller Notification custom Container
Widget customContainerForSellerNotification({required String imgName, required String title}) {
  return Container(
    height: 80,
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 15,
          ),
          child: Image(
            image: AssetImage("assets/images/$imgName"),
          ),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          title,
          style: const TextStyle(fontSize: 15, fontFamily: 'Itim-Regular'),
        )
      ],
    ),
  );
}

void showSnackBarMsg(BuildContext context, String msg, {bool error = false}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      msg,
      style: TextStyle(fontFamily: 'Itim-Regular', color: error == false ? Colors.white : Colors.red),
    ),
    backgroundColor: MyColors.MATERIAL_LIGHT_GREEN,
  ));
}
