import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/models/Post.dart';
import 'package:health_care/services/api_funtions/vendor_functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/post_card.dart';
import 'package:health_care/widgets/snackbars.dart';
import 'package:health_care/widgets/vendor_drawer.dart';

import '../../config/light_color.dart';
import '../../config/styles.dart';
import '../../config/text_styles.dart';

class AllPosts extends StatefulWidget {
  const AllPosts({Key? key}) : super(key: key);

  @override
  State<AllPosts> createState() => _AllPostsState();
}

class _AllPostsState extends State<AllPosts> {

  bool status = false;
  var posts = [];

  void getPosts() async
  {
      setState(() {
        status = true;
      });
      await getAllPosts().then((value) {
        var data = jsonDecode(value.body);
        setState(() {
          status = false;
        });
        if(value.statusCode == 200)
          {
            print(data);
            data = data['post'] as List;
            posts = data.map((e) => Post.fromJson(e)).toList();
          }
        else
          {
            ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess(data['message']));
          }
      });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return Text("All Posts", style: secondaryBigHeadingTextStyle).p16;
  }

  Widget _searchField() {
    return Container(
      height: 55,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(13)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: LightColor.grey.withOpacity(.3),
            blurRadius: 15,
            offset: Offset(5, 5),
          )
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          border: InputBorder.none,
          hintText: "Search",
          hintStyle: TextStyles.body.subTitleColor,
          suffixIcon: SizedBox(
              width: 50,
              child: Icon(Icons.search, color: kPrimary)
                  .alignCenter
                  .ripple(() {}, borderRadius: BorderRadius.circular(13))),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: ThirdDrawer(),
      body: status ? Center(child: CircularProgressIndicator(color: kPrimary,),) : ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          _searchField(),
          ListView.builder(
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (BuildContext context, int index){
              return PostCard(post: posts[index]);
            }
          )
        ],
      ),
    );
  }
}
