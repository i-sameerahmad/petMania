// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pet_mania/utils/colors.dart';
import 'package:pet_mania/utils/responsive_controller.dart';

class BlogReadingPage extends StatefulWidget {
  const BlogReadingPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BlogReadingPage> createState() => _BlogReadingPageState();
}

class _BlogReadingPageState extends State<BlogReadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Responsive(
        mobile: mobile(context),
        tablet: tabletUI(),
        web: webUI(),
      ),
    );
  }

  ///Mobile UI
  Widget mobile(context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          iconTheme: IconThemeData(color: MyColors.GREEN_LIGHT_SHADE),
          pinned: true,
          expandedHeight: 200,
          backgroundColor: Colors.white,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(image: NetworkImage('https://www.shutterstock.com/image-photo/fried-cod-fish-filet-green-260nw-1075892291.jpg'), fit: BoxFit.fill),
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20), bottomRight: Radius.circular(20))),
            ),
          ),
        ),
        SliverFillRemaining(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "First Blog",
                      style: TextStyle(fontSize: 25, fontFamily: 'Itim-Regular'),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    "Food is the substance we eat every day for energy and strength. There are many different types of food, such as fruits, vegetables, rice, and pasta. We need to eat a variety of foods to get all the essential nutrients the body needs. Not eating a healthy and balanced diet leads to weakness and deficiency diseases.",
                    style: TextStyle(fontSize: 15, fontFamily: 'Itim-Regular'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
