
import 'package:flutter/material.dart';
import 'package:pet_paradise/blogs_module/module/blog_module.dart';
import 'package:pet_paradise/blogs_module/pages/blogger_dashboard.dart';
import 'package:pet_paradise/blogs_module/pages/blog_reading_page.dart';
import 'package:pet_paradise/utils/colors.dart';
import 'package:pet_paradise/utils/custom_widgets/custom_widgets.dart';
import 'package:pet_paradise/utils/size_config.dart';
import '../../utils/responsive_controller.dart';

class BlogSelectionPage extends StatefulWidget {
  late var _appUser;
  late final List<Blog> _blogsList;
  final TextEditingController searchController = TextEditingController();

  BlogSelectionPage({Key? key, required appUser}) : super(key: key) {
    _appUser = appUser;
    _blogsList = List.empty(growable: true);
  }

  @override
  State<BlogSelectionPage> createState() => _BlogSelectionPageState();
}

class _BlogSelectionPageState extends State<BlogSelectionPage> {
  String searchValue = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //widget._query = FirebaseHelper.BLOGS_REF;
  }

  @override
  Widget build(BuildContext context) {
    print("Build with ${widget._blogsList.length} blogs");
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: transparentAppBar(context: context),
      backgroundColor: Colors.white,
      body: Responsive(
        mobile: mobile(context),
        tablet: tabletUI(),
        web: webUI(),
      ),
    );
  }

  ///mobile
  Widget mobile(context) {
    return Stack(
      children: [
        backgroundWidget(),
        Column(
          children: [
            SizedBox(
              height: 200,
              child: leftAndRightPadding(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Blogs",
                        style: TextStyle(
                            fontFamily: ' Itim-Regular',
                            fontSize: 25,
                            fontWeight: FontWeight.bold),
                      ),
                      clickAbleText(
                          text: "Your Blogs",
                          fontWeight: FontWeight.bold,
                          textSize: 18,
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const BloggerDashboard()));
                          },
                          enable: true),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 55,
                    child: TextField(
                      controller: widget.searchController,
                      decoration: InputDecoration(
                        hintText: "Search by blog title",
                        label: const Text("Search by blog title"),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                        });
                      },
                    ),
                  ),
                ],
              )),
            ),
          ],
        ),
        Padding(
            padding: const EdgeInsets.only(top: 150), child: getAllBlogsList())
      ],
    );
  }

  Widget getAllBlogsList() {
    return Expanded(
        child: ListView.separated(
            itemCount: 3,
            separatorBuilder: (context, index) {
              return const Divider(
                thickness: 4,
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return readBlog(
                child: blogCard(),
              );
            }));
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
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [MyColors.GREEN40, MyColors.GRADIENT_YELLOW],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter),
          ),
          child: const Column(
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
                        'https://www.shutterstock.com/image-photo/fried-cod-fish-filet-green-260nw-1075892291.jpg'),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(
                    'Second Blog',
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Text(
                  "3 Reads",
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

  ///read a blog
  Widget readBlog({required Widget child}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const BlogReadingPage()));
      },
      child: child,
    );
  }
}
