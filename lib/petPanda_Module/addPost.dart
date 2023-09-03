// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_mania/Commons/chat.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:pet_mania/vet_module/vatConfirmation.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController categoryController = TextEditingController();
  TextEditingController helpController = TextEditingController();

  ImagePicker imagePicker = ImagePicker();
  late final String imgUrl;
  late File? imgFile;
  bool isAdoptChecked = false;
  getImgFromGallery() async {
    try {
      var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        imgFile = File(pickedFile!.path);
        print("Image Picker path:${imgFile?.path} ");
      });
    } catch (e) {
      print("Image Picker Error : ${e.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              Icons.chat,
            ),
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => Chat()),
              // );
            },
          )
        ],
        title: Text(
          'Add Product',
          style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 30, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xfffdee9bf),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                child: Row(
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: ' Itim-Regular',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(color: MyColors.MATERIAL_LIGHT_GREEN, borderRadius: BorderRadius.all(Radius.circular(20))),
                  height: 170,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: helpController,
                      textAlign: TextAlign.start,
                      maxLines: 7,
                      maxLength: 1500,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.GREEN40, width: 0)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.GREEN40, width: 0)),
                        hintText: "Description..",
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                child: Row(
                  children: [
                    Text(
                      'Attatch Image',
                      style: TextStyle(
                        fontFamily: ' Itim-Regular',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      getImgFromGallery();
                    },
                    child: Container(
                      color: MyColors.GREEN40,
                      height: 100,
                      child: Center(
                        child: imgFile?.path == null ? Icon(Icons.add_a_photo) : Image(image: FileImage(imgFile!), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 15),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      color: MyColors.MATERIAL_LIGHT_GREEN,
                      border: Border.all(color: Colors.black38, width: 3), //border of dropdown button
                      borderRadius: BorderRadius.circular(50), //border raiuds of dropdown button
                      boxShadow: <BoxShadow>[
                        //apply shadow on Dropdown button
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.57), //shadow for button
                            blurRadius: 5) //blur radius of shadow
                      ]),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 30,
                      right: 30,
                    ),
                    child: DropdownButton(
                      hint: Text("Gender"),
                      items: [
                        //add items in the dropdown
                        DropdownMenuItem(
                          child: Text(
                            "Male",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: "Male",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Female",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: "Female",
                        ),
                        DropdownMenuItem(
                          child: Text(
                            "Other",
                            style: TextStyle(color: Colors.black),
                          ),
                          value: "Other",
                        ),
                      ],
                      onChanged: (value) {
                        //get value when changed
                        setState(() {
                          categoryController.text = value!;
                        });

                        print("You have selected $value");
                      },
                      icon: Padding(
                          //Icon at tail, arrow bottom is default icon
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(Icons.arrow_circle_down_sharp)),
                      iconEnabledColor: Colors.white, //Icon color
                      style: TextStyle(
                          //te
                          color: Colors.white, //Font color
                          fontSize: 20 //font size on dropdown button
                          ),

                      dropdownColor: MyColors.MATERIAL_LIGHT_GREEN, //dropdown background color
                      underline: Container(), //remove underline
                      isExpanded: true, //make true to make width 100%
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => VatConfirmation()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
                  child: Container(
                    decoration: BoxDecoration(color: MyColors.MATERIAL_LIGHT_GREEN, borderRadius: BorderRadius.all(Radius.circular(20))),
                    height: 50,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(
                          "Next",
                          style: TextStyle(
                            fontFamily: ' Itim-Regular',
                            fontSize: 17,
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios)
                      ]),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
