import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pet_mania/Backend/Review/doctorReview.dart';
import 'package:pet_mania/Backend/doctor.dart';
import 'package:pet_mania/Commons/chat.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:pet_mania/vet_module/vatConfirmation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VatConsultScreen extends StatefulWidget {
  final int userId;
  final int doctorId;

  const VatConsultScreen({Key? key, required this.userId, required this.doctorId}) : super(key: key);

  @override
  State<VatConsultScreen> createState() => _VatConsultScreenState();
}

class _VatConsultScreenState extends State<VatConsultScreen> {
  ImagePicker imagePicker = ImagePicker();
  late final String imgUrl;
  late File? imgFile = null;
  late DateTime selectedDate = DateTime.now();
  String userName = "";

  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userName = prefs.getString('userName')!;
    });
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
  }

  Future<void> getImgFromGallery() async {
    try {
      var pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);
      setState(() {
        imgFile = File(pickedFile!.path);
        print("Image Picker path: ${imgFile?.path}");
      });
    } catch (e) {
      print("Image Picker Error: ${e.toString()}");
    }
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  final DoctorNotifier _notifier = DoctorNotifier();

  TextEditingController helpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [],
        title: Text(
          'Vet Consultation',
          style: TextStyle(
            fontFamily: 'Itim-Regular',
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      backgroundColor: Color(0xfffdee9bf),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0),
                child: Row(
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        fontFamily: 'Itim-Regular',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.MATERIAL_LIGHT_GREEN,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
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
                      'Attach Image',
                      style: TextStyle(
                        fontFamily: 'Itim-Regular',
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
                    onTap: getImgFromGallery,
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
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Text(
                      'Select Date',
                      style: TextStyle(
                        fontFamily: 'Itim-Regular',
                        fontSize: 30,
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  decoration: BoxDecoration(
                    color: MyColors.MATERIAL_LIGHT_GREEN,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${selectedDate.toLocal()}'.split(' ')[0],
                          style: TextStyle(
                            fontFamily: 'Itim-Regular',
                            fontSize: 17,
                          ),
                        ),
                        Icon(Icons.calendar_today),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
        child: InkWell(
          onTap: () {
            String description = helpController.text;
            if (description.trim().isEmpty) {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Error'),
                    content: Text('Please provide a description.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('OK'),
                      ),
                    ],
                  );
                },
              );
            } else {
              String formattedDate = selectedDate.toLocal().toString().split(' ')[0];

              _notifier.addAppointment(description, userName, imgFile, formattedDate, widget.userId, widget.doctorId);
              Navigator.push(context, MaterialPageRoute(builder: (context) => VatConfirmation()));
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: MyColors.MATERIAL_LIGHT_GREEN,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Next",
                    style: TextStyle(
                      fontFamily: 'Itim-Regular',
                      fontSize: 17,
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
