// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:pet_mania/utils/custom_widgets/custom_widgets.dart';
import 'package:pet_mania/utils/responsive_controller.dart';

class AddBlog extends StatefulWidget {
  var appUser;
  late String blogID;
  late final String imgUrl;
  late File? imgFile;
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  AddBlog({
    Key? key,
  }) : super(key: key);

  @override
  State<AddBlog> createState() => _AddBlogState();
}

class _AddBlogState extends State<AddBlog> {
  @override
  void initState() {
    super.initState();
  }

  getImgFromGallery() async {
    try {
      var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        widget.imgFile = File(pickedFile!.path);
        print("Image Picker path:${widget.imgFile?.path} ");
      });
    } catch (e) {
      print("Image Picker Error : ${e.toString()}");
    }
  }

  ImagePicker imagePicker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: transparentAppBar(context: context),
      body: Responsive(
        mobile: mobile(context, widget.appUser),
        tablet: tabletUI(),
        web: webUI(),
      ),
    );
  }

  ///mobile UI
  Widget mobile(BuildContext context, appUser) {
    return Stack(
      children: [
        backgroundWidget(),
        SingleChildScrollView(
          child: leftAndRightPadding(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 50,
                ),
                Center(
                  child: Image.asset(
                    "assets/images/add_blog_logo.png",
                    height: 120,
                    width: 120,
                  ),
                ),
                Text(
                  "Create a blog and everyone will be able to read it. Inform people of your knowledge about your pet.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: ' Itim-Regular', fontSize: 14),
                ),
                SizedBox(
                  height: 40,
                ),

                ///Add Title TextField
                Text(
                  "Title",
                  style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                TextFormField(
                  controller: widget._titleController,
                  decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.GREEN40, width: 0)),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.GREEN40, width: 0)),
                      hintText: "Blog Title",
                      filled: true,
                      fillColor: MyColors.GREEN40),
                ),
                SizedBox(
                  height: 20,
                ),

                ///Add Image
                Text(
                  "Upload a picture",
                  style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                GestureDetector(
                  onTap: () {
                    getImgFromGallery();
                  },
                  child: Container(
                    color: MyColors.GREEN40,
                    height: 100,
                    child: Center(
                      child: widget.imgFile?.path == null ? Icon(Icons.add_a_photo) : Image(image: FileImage(widget.imgFile!), fit: BoxFit.cover),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                ///Add blog Content
                Text(
                  "Write Something",
                  style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  color: MyColors.GREEN40,
                  height: 170,
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      controller: widget._contentController,
                      textAlign: TextAlign.start,
                      maxLines: 7,
                      maxLength: 1500,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.GREEN40, width: 0)),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColors.GREEN40, width: 0)),
                        hintText: "Blog Content",
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                MyButton(onPressed: () async {}, title: "Upload Your Blog", color: MyColors.GREEN_LIGHT_SHADE, textColor: Colors.black, borderRadius: 0)
              ],
            ),
          ),
        )
      ],
    );
  }
}
