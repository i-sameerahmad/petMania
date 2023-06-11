// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:pet_paradise/blogs_module/pages/add_blog.dart';
import 'package:pet_paradise/utils/appConstants.dart';
import 'package:pet_paradise/utils/custom_widgets/custom_widgets.dart';
import 'package:pet_paradise/utils/responsive_controller.dart';

import '../../utils/colors.dart';
import '../../utils/size_config.dart';

class BloggerDashboard extends StatefulWidget {
  const BloggerDashboard({
    Key? key,
  }) : super(key: key);

  @override
  State<BloggerDashboard> createState() => _BloggerDashboardState();
}

class _BloggerDashboardState extends State<BloggerDashboard> {
  @override
  void initState() {
    super.initState();
    //widget._query = FirebaseHelper.BLOGS_REF;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: transparentAppBar(context: context),
      extendBodyBehindAppBar: true,
      body: Responsive(
        mobile: mobile(context),
        tablet: tabletUI(),
        web: webUI(),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddBlog()));
          },
          backgroundColor: MyColors.YELLOW,
          tooltip: "Add new Blog.",
          child: Icon(
            Icons.add,
            color: MyColors.MATERIAL_LIGHT_GREEN,
          ),
        ),
      ),
    );
  }

  ///mobile
  Widget mobile(context) {
    return Stack(
      children: [
        backgroundWidget(),

        ///Header
        SizedBox(
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 48, // Image radius
                backgroundImage: Image.asset(NOIMAGE,
                        height: 180,
                        width: 180,
                        fit: BoxFit.cover,
                        alignment: Alignment.center)
                    .image,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Usama",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          fontFamily: 'Itim-Regular'),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),

        // List of Blogs
        Padding(padding: EdgeInsets.only(top: 150), child: getMyBlogsList()),
      ],
    );
  }

  ///blog card
  Widget blogCard() {
    return Padding(
      padding: EdgeInsets.only(
          left: MyAppSize.width! * 0.05,
          right: MyAppSize.width! * 0.05,
          bottom: 10),
      child: Card(
        color: MyColors.LIGHT_GREEN,
        child: Container(
          height: 170,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [MyColors.GREEN40, MyColors.GRADIENT_YELLOW],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  CircleAvatar(
                    maxRadius: 60,
                    backgroundColor: Colors.white,
                    backgroundImage: NetworkImage(
                      'https://www.shutterstock.com/image-photo/fried-cod-fish-filet-green-260nw-1075892291.jpg',
                    ),
                  ),
                  SizedBox(
                    width: 40,
                  ),
                  Text("Fooodeee")
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  "12 Reads",
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      color: Colors.grey,
                      fontFamily: ' Itim-Regular',
                      fontSize: 13),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getMyBlogsList() {
    return Expanded(
        child: ListView.separated(
            itemCount: 2,
            separatorBuilder: (context, index) {
              return Divider(
                thickness: 4,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return blogCard();
            }));
  }
}
