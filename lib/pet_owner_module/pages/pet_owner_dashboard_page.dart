import 'package:flutter/material.dart';
import 'package:pet_mania/pet_owner_module/module/get_started_page_data.dart';
import 'package:pet_mania/Commons/get_started_page.dart';
import 'package:pet_mania/utils/appConstants.dart';
import 'package:pet_mania/utils/custom_widgets/custom_widgets.dart';
import 'package:pet_mania/utils/responsive_controller.dart';
import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class PetOwnerDashboard extends StatefulWidget {
  var generalAppUser;
  var petOwner;
  @override
  PetOwnerDashboard({Key? key, required this.generalAppUser, required this.petOwner}) : super(key: key);

  //Get Started with Blog Page Data
  // static final GetStartedPageData getStartedWithBlogs = GetStartedPageData(
  // pageTitle: "Blogs & Articles",
  // subTitle: "Publish Your Own  Passion In Your Own Way ",
  // imgUrl:
  //     "https://images.unsplash.com/photo-1501504905252-473c47e087f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
  // pageName: BLOGSANDARTICLES);

  //Get Started with Adopt a pet Page Data
  static final GetStartedPageData getStartedWithAdoptAPet = GetStartedPageData(
      pageTitle: "MAKE  A NEW FRIEND",
      subTitle: "Instant access to thousands of veterans.You may simply get in touch with them and schedule appointments at times that work for you.",
      imgUrl: "https://images.unsplash.com/photo-1450778869180-41d0601e046e?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=986&q=80",
      pageName: ADOPTAPET);

  //Get Started with Breeder Page Data
  static final GetStartedPageData getStartedWithBreeder = GetStartedPageData(
      pageTitle: "FIND THE BEST BREEDER FOR YOUR PET",
      subTitle: "Instant access to thousands of Breeders. You may simply get in touch with them and schedule appointments at times that work for you.",
      imgUrl: "https://images.unsplash.com/photo-1602612142771-04b0adfca46d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      pageName: BREEDER);

  //Get Started with Trainer Page Data
  static final GetStartedPageData getStartedWithTrainer = GetStartedPageData(
      pageTitle: "FIND THE BEST PETS FOR YOUR PET",
      subTitle: "Instant access to thousands of trainers.You may simply get in touch with them and schedule appointments at times that work for you.",
      imgUrl: "https://images.unsplash.com/photo-1484190929067-65e7edd5a22f?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      pageName: PETS);

  //Get Started with Vet Page Data
  static final GetStartedPageData getStartedWithVet = GetStartedPageData(
      pageTitle: "FIND THE BEST VETERINARIAN FOR YOUR PET",
      subTitle: "Instant access to thousands of veterans.You may simply get in touch with them and schedule appointments at times that work for you.",
      imgUrl: "https://images.unsplash.com/photo-1628009368231-7bb7cfcb0def?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=870&q=80",
      pageName: VATERINARIAN);
  static final GetStartedPageData getStartedWithPetPanda = GetStartedPageData(
      pageTitle: "Pet Panda",
      subTitle: "Publish Your Own  Passion In Your Own Way ",
      imgUrl: "https://images.unsplash.com/photo-1501504905252-473c47e087f8?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=774&q=80",
      pageName: PETPANDA);
  @override
  State<PetOwnerDashboard> createState() => _PetOwnerDashboardState();
}

class _PetOwnerDashboardState extends State<PetOwnerDashboard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    MyAppSize.config(MediaQuery.of(context));
    return Scaffold(
      body: Responsive(
        mobile: mobile(context, widget.generalAppUser),
        web: webUI(),
        tablet: tabletUI(),
      ),
    );
  }

  ///Sliver AppBar
  SliverAppBar myDashboardAppBar({required String title, required generalAppUser}) {
    return SliverAppBar(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, color: Colors.white, fontFamily: 'Itim-Regular'),
      ),
      pinned: false,
      elevation: 5,
      automaticallyImplyLeading: false,
      actions: const [
        Padding(
          padding: EdgeInsets.all(12.0),
          child: CircleAvatar(
            backgroundColor: Colors.black,
            maxRadius: 30,
          ),
        )
      ],
      expandedHeight: 200,
      backgroundColor: MyColors.MATERIAL_LIGHT_GREEN,
      flexibleSpace: FlexibleSpaceBar(
        background: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(left: 14, right: 16),
                child: Text(
                  "Dear ${generalAppUser['name']} You Have Registered 5 Pets",
                  style: const TextStyle(fontFamily: 'Itim-Regular', fontSize: 18),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Padding(
                padding: const EdgeInsets.all(8.0),
                child: MyButton(
                  onPressed: () {},
                  title: 'Your Pets Here',
                  color: Colors.yellow,
                  textColor: Colors.black,
                  //fontFamily : ' Itim-Regular',
                ))
          ],
        ),
        collapseMode: CollapseMode.parallax,
      ),
    );
  }

  ///generate card Data List
  List<MyDashboardCardData> generateCardData() {
    return <MyDashboardCardData>[
      MyDashboardCardData(title: PETS, imgPath: "assets/images/trainerLogo.png"),
      MyDashboardCardData(title: VATERINARIAN, imgPath: "assets/images/veterinariansLogo.png"),
      MyDashboardCardData(title: BREEDER, imgPath: "assets/images/breedersLogo.png"),
      MyDashboardCardData(title: PETPANDA, imgPath: "assets/images/petPandaLogo.png"),
      MyDashboardCardData(title: ADOPTAPET, imgPath: "assets/images/adoptPetLogo.png"),
      MyDashboardCardData(title: BLOGSANDARTICLES, imgPath: "assets/images/blogs&ArticlesLogo.png"),
    ];
  }

  /// Dashboard Grid
  SliverGrid myDashboardGrid(appUser) {
    List<MyDashboardCardData> gridCardData = generateCardData();
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 250, mainAxisSpacing: 2, crossAxisSpacing: 2),
      delegate: SliverChildBuilderDelegate((BuildContext context, int index) {
        return Card(
          elevation: 1,
          shadowColor: Colors.green,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: InkWell(
            splashColor: MyColors.MATERIAL_LIGHT_GREEN,
            onTap: () {
              if (gridCardData[index].title == PETS) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetStartedPage(
                              pageData: PetOwnerDashboard.getStartedWithTrainer,
                              appUser: appUser,
                            )));
              } else if (gridCardData[index].title == VATERINARIAN) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetStartedPage(
                              pageData: PetOwnerDashboard.getStartedWithVet,
                              appUser: appUser,
                            )));
              } else if (gridCardData[index].title == BREEDER) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetStartedPage(
                              pageData: PetOwnerDashboard.getStartedWithBreeder,
                              appUser: appUser,
                            )));
              } else if (gridCardData[index].title == PETPANDA) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetStartedPage(
                              pageData: PetOwnerDashboard.getStartedWithPetPanda,
                              appUser: appUser,
                            )));
              } else if (gridCardData[index].title == ADOPTAPET) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => GetStartedPage(
                              pageData: PetOwnerDashboard.getStartedWithAdoptAPet,
                              appUser: appUser,
                            )));
              }
              // else if (gridCardData[index].title == BLOGSANDARTICLES) {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //           builder: (context) => GetStartedPage(
              //                 pageData: PetOwnerDashboard.getStartedWithBlogs,
              //                 appUser: appUser,
              //               )));
              // }
            },
            borderRadius: BorderRadius.circular(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(flex: 4, child: Image(image: AssetImage(gridCardData[index]._imgPath))),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    gridCardData[index]._title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: MyColors.DARK_BROWN, fontSize: 17, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),
                  ),
                ))
              ],
            ),
          ),
        );
      }, childCount: gridCardData.length),
    );
  }

  ///Mobile UI
  Widget mobile(BuildContext context, appUser) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        myDashboardAppBar(title: "Hello ${appUser['name']}!", generalAppUser: appUser),
        SliverPadding(
          padding: EdgeInsets.only(left: MyAppSize.width! * 0.05, right: MyAppSize.width! * 0.05, bottom: MyAppSize.height! * 0.05),
          sliver: myDashboardGrid(appUser),
        )
      ],
    );
  }
}

///Clas To Hold Card Data
class MyDashboardCardData {
  late final String _imgPath;
  late final String _title;

  MyDashboardCardData({required String imgPath, required String title}) {
    _imgPath = imgPath;
    _title = title;
  }

  String get title => _title;

  String get imgPath => _imgPath;
}
