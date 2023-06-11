import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const appColor = Color(0xFF4592E8);
const appColor2 = Color(0xFF4552CB);
const appColor3 = Color(0xFFF1A852);
const appColorDark = Color(0xFF2E1E7A);

const backgroundColor = Color.fromARGB(255, 243, 243, 243);

blackHeading(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 22, fontFamily: 'bold', color: Colors.black),
  );
}

centerkHeading(val) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Text(
      val,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24, fontFamily: 'bold', color: appColorDark),
    ),
  );
}

blackHeadingSmall(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 20, fontFamily: 'bold', color: Colors.black),
  );
}

blackText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: Colors.black),
  );
}

boldText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: 'bold'),
  );
}

blackBoldText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 18, fontFamily: 'bold', color: Colors.black),
  );
}

MediumText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 16, fontFamily: 'medium', color: Colors.black),
  );
}

centerText(val) {
  return Text(
    val,
    textAlign: TextAlign.center,
    style: const TextStyle(fontSize: 14, color: appColorDark),
  );
}

greyBoldText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 15, fontFamily: 'medium', color: Colors.black54),
  );
}

greyText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 14, color: Colors.black54),
  );
}

greyTextSmall(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 12, color: Colors.black54),
  );
}

smallText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 10, color: Colors.black54),
  );
}

appcolorText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 12, color: appColor, fontFamily: 'semibold'),
  );
}

colorText(val) {
  return Text(
    val,
    style: const TextStyle(fontSize: 16, color: appColor, fontFamily: 'semibold'),
  );
}

textField(hint, icn, TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: hint,
        suffixIcon: Icon(
          icn,
          size: 18,
          color: Colors.black12,
        ),
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
      ),
    ),
  );
}

numField(hint, icn, TextEditingController controller) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
        FilteringTextInputFormatter.digitsOnly
      ],
      decoration: InputDecoration(
        labelText: hint,
        suffixIcon: Icon(
          icn,
          size: 18,
          color: Colors.black12,
        ),
        labelStyle: const TextStyle(color: Colors.black54, fontSize: 12),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: appColor),
        ),
      ),
    ),
  );
}

SearchBox() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    decoration: const BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.all(Radius.circular(30))),
    child: TextField(
      onChanged: (String txt) {},
      style: const TextStyle(
        fontSize: 14,
      ),
      cursorColor: appColor,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(color: Colors.black38, fontSize: 14),
        suffixIcon: Icon(
          Icons.search,
          color: Colors.black45,
        ),
      ),
    ),
  );
}
