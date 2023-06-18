import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:pet_paradise/Backend/Pet/pet.dart';
import 'package:pet_paradise/widget/elevated_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import '../components/styles.dart';

class AddPetDetail extends StatefulWidget {
  static const String id = 'AddPetDetail';

  const AddPetDetail({Key? key}) : super(key: key);

  @override
  _AddPetDetailState createState() => _AddPetDetailState();
}

class _AddPetDetailState extends State<AddPetDetail> {
  int selectID = 1;
  late String _selectGender;
  String dropdownValueSpecies = 'Dog';
  String dropdownValueBreed = 'American Bulldog';
  String dropdownValueSize = 'Select';
  final TextEditingController _petNameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _petDescriptionController = TextEditingController();
  final TextEditingController _petAgeController = TextEditingController();

  final TextEditingController _petPriceController = TextEditingController();

  late File _image;
  final picker = ImagePicker();
  late int userID;

  DateTime currentDate = DateTime.now();
  myPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getInt('userID'));
    setState(() {
      userID = prefs.getInt('userID') ?? 0;
    });
    // print(user_id);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(context: context, initialDate: currentDate, firstDate: DateTime(2015), lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != currentDate) {
      setState(() {
        currentDate = pickedDate;
      });
    }
  }

  // Future getImage() async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);

  //   setState(() {
  //     if (pickedFile != null) {
  //       _image = File(pickedFile.path);
  //     } else {
  //       print('No image selected.');
  //     }
  //   });
  // }

  File? image;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        image = File(pickedFile.path);
      });
    }
  }

  late String _fileName;
  late String _filePath;

  void _openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      setState(() {
        _fileName = result.files.single.name;
        _filePath = result.files.single.path!;
      });
    }
  }

  @override
  void initState() {
    myPrefs();
    super.initState();
    _fileName = '';
    _filePath = '';
  }

  final PetNotifier _petNotifier = PetNotifier();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: appColor),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: const Text(
            'Add pet detail',
            style: TextStyle(color: Colors.black, fontFamily: 'bold'),
          ),
          actions: [TextButton(onPressed: () {}, child: appcolorText('Skip'))],
        ),
        body: _buildBody());
  }

  Widget _buildBody() {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _getImage,
                child: image != null
                    ? Image.file(
                        image!,
                        width: 100.0,
                        height: 100.0,
                        fit: BoxFit.cover,
                      )
                    : const CircleAvatar(
                        radius: 50.0,
                        child: Icon(Icons.camera_alt),
                      ),
              ),
              const SizedBox(height: 24),
              blackBoldText('General information'),
              textField('Pet\'s Name', Icons.check, _petNameController),
              const SizedBox(height: 8),
              textField('Description', Icons.check, _petDescriptionController),
              const SizedBox(height: 8),
              numField('Age', Icons.check, _petAgeController),
              const SizedBox(height: 8),
              numField('Price', Icons.check, _petPriceController),
              const SizedBox(height: 8),
              greyTextSmall('Species of your pet'),
              buildDropDownSpecies(),
              const SizedBox(height: 8),
              // greyTextSmall('Breed'),
              // buildDropDownBreed(),
              // SizedBox(height: 8),
              // greyTextSmall('Size(optional)'),
              // buildDropDownSize(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  greyTextSmall('Gender'),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildSelect('Male', 1),
                      _buildSelect('Female', 2),
                    ],
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: _openFileExplorer,
                          child: const Text('Select PDF'),
                        ),
                        const SizedBox(height: 16),
                        Text('Selected PDF: ${_fileName.isNotEmpty ? _fileName : 'None'}'),
                        if (_filePath.isNotEmpty) Text('File path: $_filePath'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),
              // greyTextSmall('Date of birth'),
              // _buildSelectDate(),
              // SizedBox(height: 30),
              // const SizedBox(height: 8),
              blackBoldText(
                'User details',
              ),
              // Added heading "User details"
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10),
                child: Form(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Name",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: _nameController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Address",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: _addressController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Phone",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: _phoneController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your phone number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        "Email",
                        style: TextStyle(
                          fontFamily: 'Itim-Regular',
                          fontSize: 16,
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(),
                        controller: _emailController,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter your email';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),

              MyElevatedButton(
                  onPressed: () {
                    print(_petNameController.text);
                    print(_petDescriptionController.text);
                    print(_petAgeController.text);
                    print(_petPriceController.text);
                    print(_petNameController.text);
                    print(dropdownValueSpecies);
                    print(_selectGender);
                    print(image);
                    print(userID);

                    _petNotifier.addPet(
                        userID,
                        _petNameController.text,
                        _petDescriptionController.text,
                        _selectGender,
                        dropdownValueSpecies,
                        int.parse(_petAgeController.text),
                        double.parse(_petPriceController.text),
                        image,
                        _filePath.isNotEmpty ? _filePath : null,
                        _nameController.text,
                        _addressController.text,
                        _phoneController.text,
                        _emailController.text,
                        context);
                    // Navigator.push(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => const TabsExample())
                    //         );
                  },
                  colors: appColor,
                  text: 'Save'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelect(title, id) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectID = id;
          _selectGender = selectID == 1 ? 'Male' : 'Female';
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 50),
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black12),
          color: selectID == id ? appColor : Colors.transparent,
          borderRadius: const BorderRadius.all(Radius.circular(50.0)),
        ),
        child: Text(title, style: TextStyle(fontFamily: 'medium', fontSize: 14, color: selectID == id ? Colors.white : Colors.black54)),
      ),
    );
  }

  Widget buildDropDownSpecies() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black26)),
        color: Colors.white,
      ),
      child: DropdownButton<String>(
        underline: const SizedBox(),
        iconSize: 18,
        iconEnabledColor: Colors.black,
        value: dropdownValueSpecies,
        onChanged: (newValue) {
          setState(() {
            dropdownValueSpecies = newValue!;
          });
        },
        items: ['Dog', 'Cat', 'Turtle', 'Monkey'].map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(
              value,
              style: const TextStyle(color: Colors.black, fontSize: 14),
            ),
          );
        }).toList(),
      ),
    );
  }
}
