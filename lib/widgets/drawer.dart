import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/screens/auth/profile.dart';
import 'package:health_care/screens/home/home_screen.dart';
import 'package:http/http.dart' as http;


class ButtonWidget extends StatefulWidget {
  final IconData icon;
  final String text;
  final VoidCallback onClicked;

  const ButtonWidget({
    Key? key,
    required this.icon,
    required this.text,
    required this.onClicked,
  }) : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) => ElevatedButton(
    style: ElevatedButton.styleFrom(
      minimumSize: Size.fromHeight(50),
    ),
    child: buildContent(),
    onPressed: widget.onClicked,
  );

  Widget buildContent() => Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(widget.icon, size: 28),
      SizedBox(width: 16),
      Text(
        widget.text,
        style: TextStyle(fontSize: 22, color: Colors.white),
      ),
    ],
  );


}



class NavigationDrawerWidget extends StatefulWidget {
  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  var image;
  bool imageStatus = false;
  void getImage()async{
    setState(() {
      imageStatus = true;
    });
    await http.get(Uri.parse(Urls.baseUrl+"docto.png")).then((value) {
      if(value.statusCode==200)
        {
          setState(() {
            image = NetworkImage(Urls.baseUrl+"doctor.png");
            imageStatus = false;
          });
        }
      else{
        setState(() {
          image = AssetImage("assets/user.png");
          imageStatus = false;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getImage();
  }

  @override
  Widget build(BuildContext context) {
    final name = UserLoginData.displayName;
    final email = UserLoginData.username;

    return Drawer(
      child: Material(
        color: kPrimary,
        child: ListView(
          children: <Widget>[
            buildHeader(
              image: image,
              name: name,
              email: email,
              onClicked: ()=>{},
              status: imageStatus
              // onClicked: () => Navigator.of(context).push(MaterialPageRoute(
              //   builder: (context) => UserPage(
              //     name: 'Sarah Abs',
              //     urlImage: urlImage,
              //   ),
              // )),
            ),
            Container(
              padding: padding,
              child: Column(
                children: [
                  buildMenuItem(
                    text: 'Home',
                    icon: FontAwesomeIcons.home,
                    onClicked: () {
                      Navigator.pushNamedAndRemoveUntil(context, "/HomeScreen", (route) => false);
                    },
                  ),
                  // const SizedBox(height: 16),
                  // buildMenuItem(
                  //   text: 'Favourites',
                  //   icon: Icons.favorite_border,
                  //   onClicked: () => selectedItem(context, 1),
                  // ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'My Appointments',
                    icon: FontAwesomeIcons.calendarCheck,
                    onClicked: () => selectedItem(context, 2),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'My Orders',
                    icon: FontAwesomeIcons.luggageCart,
                    onClicked: () => selectedItem(context, 3),
                  ),
                  const SizedBox(height: 24),
                  Divider(color: Colors.white70),
                  const SizedBox(height: 24),
                  buildMenuItem(
                    text: 'My Profile',
                    icon: FontAwesomeIcons.user,
                    onClicked: () {
                      Navigator.push(
                          context,
                          new MaterialPageRoute(builder: (BuildContext context) => Profile()));
                    },
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Settings',
                    icon: FontAwesomeIcons.cog,
                    onClicked: () => selectedItem(context, 5),
                  ),
                  const SizedBox(height: 16),
                  buildMenuItem(
                    text: 'Sign Out',
                    icon: FontAwesomeIcons.signOutAlt,
                    onClicked: () {
                      setState(() {
                        UserLoginData.token = "";
                        UserLoginData.userId = "";
                        UserLoginData.username = "";
                        UserLoginData.displayName = "";
                        UserLoginData.email = "";
                        UserLoginData.image = "";
                        UserLoginData.isActive = "";
                        UserLoginData.isSuperUser = "";
                        UserLoginData.isAdmin = "";
                        UserLoginData.phone = "";
                        UserLoginData.city = "";
                        UserLoginData.country = "";
                        UserLoginData.area = "";
                        UserLoginData.postalCode = "";
                      });
                      Navigator.pushNamedAndRemoveUntil(context, "/LoginScreen", (route) => false);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildHeader({
    required bool status,
    required var image,
    required String name,
    required String email,
    required VoidCallback onClicked,
  }) {

      return InkWell(
        onTap: onClicked,
        child: Container(
          padding: padding.add(EdgeInsets.symmetric(vertical: 40)),
          child: Row(
            children: [
              status ? CircularProgressIndicator(color: kGeneralWhite,) : CircleAvatar(radius: 30, backgroundImage: image,),
              SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: authSubTextStyle1,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    email,
                    style: kFormTextStyle1,
                  ),
                ],
              ),
              Spacer(),
              CircleAvatar(
                radius: 24,
                backgroundColor: Color.fromRGBO(30, 60, 168, 1),
                child: Icon(Icons.arrow_right, color: Colors.white),
              )
            ],
          ),
        ),
      );}

  Widget buildSearchField() {
    final color = Colors.white;

    return TextField(
      style: TextStyle(color: color),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        hintText: 'Search',
        hintStyle: TextStyle(color: color),
        prefixIcon: Icon(Icons.search, color: color),
        filled: true,
        fillColor: Colors.white12,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: BorderSide(color: color.withOpacity(0.7)),
        ),
      ),
    );
  }

  Widget buildMenuItem({
    required String text,
    required IconData icon,
    VoidCallback? onClicked,
  }) {
    final color = Colors.white;
    final hoverColor = Colors.white70;

    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(text, style: kFormTextStyle1),
      hoverColor: hoverColor,
      onTap: onClicked,
    );
  }

  void selectedItem(BuildContext context, int index) {
    Navigator.of(context).pop();

    // switch (index) {
    //   case 0:
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => PeoplePage(),
    //     ));
    //     break;
    //   case 1:
    //     Navigator.of(context).push(MaterialPageRoute(
    //       builder: (context) => FavouritesPage(),
    //     ));
    //     break;
    // }
  }
}
