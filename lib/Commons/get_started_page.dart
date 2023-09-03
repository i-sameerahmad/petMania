// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_mania/AdoptAPet/landingAdoptpet.dart';
import 'package:pet_mania/AdoptAPet/petshop.dart';
import 'package:pet_mania/Backend/Pet/pet.dart';
import 'package:pet_mania/Backend/doctor.dart';
import 'package:pet_mania/Backend/product.dart';
import 'package:pet_mania/Commons/varifiedPetsHome.dart';
import 'package:pet_mania/blogs_module/module/blog_module.dart';
import 'package:pet_mania/blogs_module/pages/blogs_selection_page.dart';
import 'package:pet_mania/petPanda_Module/petPandaLandingPage.dart';
import 'package:pet_mania/utils/appConstants.dart';
import 'package:pet_mania/utils/responsive_controller.dart';
import 'package:pet_mania/pet_owner_module/module/get_started_page_data.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:pet_mania/vet_module/vetLandingPage.dart';
import '../utils/size_config.dart';

class GetStartedPage extends StatelessWidget {
  late final GetStartedPageData pageData;
  var appUser;
  final DoctorNotifier _doctorNotifier = DoctorNotifier();
  final ProductNotifier _productNotifier = ProductNotifier();
  final PetNotifier _petNotifier = PetNotifier();

  GetStartedPage({Key? key, required this.pageData, required this.appUser}) : super(key: key);

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
          child: Icon(
            Icons.arrow_back,
            color: MyColors.MATERIAL_LIGHT_GREEN,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Responsive(
        mobile: mobile(context, pageData: pageData, appUser: appUser),
        tablet: tabletUI(),
        web: webUI(),
      ),
    );
  }

  /// Mobile
  Widget mobile(BuildContext context, {required GetStartedPageData pageData, required appUser}) {
    List<Blog> list = List.empty(growable: true);
    return Stack(
      children: [
        SizedBox(
          width: MyAppSize.width,
          child: Image(
            image: AssetImage("assets/images/rectDesign.png"),
            alignment: Alignment.topRight,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: MyAppSize.width! * 0.1, right: MyAppSize.width! * 0.1),
                child: Text(
                  pageData.pageName,
                  style: TextStyle(fontFamily: ' Itim-Regular', fontSize: 20, fontWeight: FontWeight.bold, color: MyColors.DARK_BROWN),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 340,
                width: MyAppSize.width,
                child: CircleAvatar(
                  backgroundColor: MyColors.MATERIAL_LIGHT_GREEN,
                  backgroundImage: NetworkImage(pageData.imageUrl),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.only(left: MyAppSize.width! * 0.1, right: MyAppSize.width! * 0.1),
                child: Text(
                  pageData.pageSubTitle,
                  style: TextStyle(color: MyColors.LIGHT_PINK, fontStyle: FontStyle.italic, fontFamily: ' Itim-Regular', fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(bottom: MyAppSize.height! * 0.08),
          child: Container(
            alignment: Alignment.bottomCenter,
            child: MaterialButton(
              onPressed: () async {
                if (pageData.pageName == BLOGSANDARTICLES) {
                  print(appUser);
                  navigateToiNextScreen(context, BlogSelectionPage(appUser: appUser));
                } else if (pageData.pageName == ADOPTAPET) {
                  print('adopt a pet');
                  navigateToiNextScreen(context, ADOPTPET());
                } else if (pageData.pageName == PETPANDA) {
                  _productNotifier.fetchProducts().then((products) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PetPandaLanding(products: products)),
                    );
                  }).catchError((error) {
                    print(error);
                  });
                } else if (pageData.pageName == PETS) {
                  _petNotifier.fetchPets().then((pets) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PETSHOP(pets: pets)),
                    );
                  }).catchError((error) {
                    print(error);
                  });
                  print(PETS);
                } else if (pageData.pageName == VERIFIED) {
                  _petNotifier.fetchVerifiedPets().then((pets) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VARIFIEDPETSHOP(pets: pets)),
                    );
                  }).catchError((error) {
                    print(error);
                  });
                  print(PETS);
                } else if (pageData.pageName == 'VETERINARIAN') {
                  _doctorNotifier.fetchDoctors().then((doctors) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => VatLanding(doctors: doctors)),
                    );
                  }).catchError((error) {
                    print(error);
                  });
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                      "Something went Wrong",
                    ),
                    backgroundColor: MyColors.MATERIAL_LIGHT_GREEN,
                  ));
                }
              },
              color: MyColors.MATERIAL_LIGHT_GREEN,
              height: 39,
              minWidth: MyAppSize.width,
              child: Text(
                "Get Started",
              ),
            ),
          ),
        )
      ],
    );
  }

  /// Navigate To NextScreen
  navigateToiNextScreen(BuildContext context, var screen) {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => screen));
  }
}
