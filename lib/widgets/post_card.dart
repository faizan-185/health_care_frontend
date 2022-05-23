import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/models/Post.dart';
import 'package:health_care/screens/vendor/post_details.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import '../config/dimensions.dart';
import '../config/styles.dart';

class PostCard extends StatefulWidget {
  Post post;
  PostCard({Key? key, required this.post}) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, new MaterialPageRoute(builder: (context) => PostDetails(post: widget.post)));
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, bottom: 5.0, left: 16.00, right: 16.00),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(20)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                offset: Offset(1, 1),
                blurRadius: 8,
                color: Colors.blueGrey.withOpacity(0.8),
              )
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(Urls.baseUrl + widget.post.hospital.image),
                      radius: 40,
                    ),
                    SizedBox(width: 15,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                            width: 200,
                            child: Text(widget.post.hospital.hospitalName, style: normalBlackTitleTextStyle,)),
                        SizedBox(height: 5,),
                        SizedBox(
                          width: 200,
                          child: Text(widget.post.hospital.area + widget.post.hospital.city + widget.post.hospital.country + ", " + widget.post.hospital.postalCode, style: style13500,),
                        ),
                      ],
                    )
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.phone, color: kPrimary, size: 15),
                      onPressed: (){
                        UrlLauncher.launch("tel://${widget.post.hospital.phoneNo}");
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.post.hospital.phoneNo, style: listTileTitle,),
                    SizedBox(
                      width: 40,
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.mapMarkedAlt, color: kPrimary, size: 15),
                      onPressed: (){
                        String query = Uri.encodeComponent(widget.post.hospital.hospitalName+" "+widget.post.hospital.area + widget.post.hospital.city + widget.post.hospital.country);
                        String googleUrl = "https://www.google.com/maps/search/?api=1&query=$query";
                        UrlLauncher.launch(googleUrl);
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Open Map", style: listTileTitle,),
                  ],
                ),
                SizedBox(height: 5,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: BoxConstraints(),
                      icon: Icon(FontAwesomeIcons.at, color: kPrimary, size: 15),
                      onPressed: (){
                        UrlLauncher.launch('mailto:${widget.post.hospital.email}');
                      },
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(widget.post.hospital.email, style: listTileTitle,),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Item Required", style: listTilePrice,),
                    SizedBox( width: screenSize.width * 0.5, child: Text(widget.post.title, style: listTileTitle,))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Description", style: listTilePrice,),
                    SizedBox( width: screenSize.width * 0.5, child: Text(widget.post.description, style: style13500,))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Quantity", style: listTilePrice,),
                    SizedBox( width: screenSize.width * 0.5, child: Text(widget.post.quantity + " Items", style: listTileTitle,))
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Category", style: listTilePrice,),
                    SizedBox( width: screenSize.width * 0.5, child: Text(widget.post.category, style: listTileTitle,))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
