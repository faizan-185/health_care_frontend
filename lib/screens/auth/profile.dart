import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/api_headers.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/services/api_funtions/profile_functions.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:health_care/widgets/snackbars.dart';
import 'package:health_care/widgets/verido-primary-button.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}
enum AppState {
  free,
  picked,
  cropped,
}

class _ProfileState extends State<Profile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  Widget _header() {
    return SizedBox(width: screenSize.width, child: Text(UserLoginData.displayName, style: secondaryBigHeadingTextStyle));
  }
  Future<File> getImageFileFromAssets(String path) async {
    final byteData = await rootBundle.load('assets/$path');

    final file = File('${(await getTemporaryDirectory()).path}/$path');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));

    return file;
  }

  var data = [UserLoginData.area, UserLoginData.city, UserLoginData.country, UserLoginData.postalCode, UserLoginData.phone];
  var text_state = [false, false, false, false, false];
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  TextEditingController t5 = TextEditingController();


  bool status = false;
  var image;
  bool imageStatus = false;
  void getImage()async{
    setState(() {
      status = true;
    });
    await http.get(Uri.parse(Urls.baseUrl+UserLoginData.image)).then((value) async {
      if(value.statusCode==200)
      {
          image = NetworkImage(Urls.baseUrl+UserLoginData.image);
          final documentDirectory = await getApplicationDocumentsDirectory();

          final file = File(join(documentDirectory.path, 'imagetest.png'));

          file.writeAsBytesSync(value.bodyBytes);

          setState(() {
            status = false;
            imageFile = file;
          });
      }
      else{
          // image = AssetImage("assets/user.png");
          // final documentDirectory = await getApplicationDocumentsDirectory();
          //
          // final file = File(join(documentDirecath, 'imagetest.png'));
          //
          // file.writeAsBytesSync(image.bodyBytes);

        File file = await getImageFileFromAssets('user.png');

          setState(() {
            status = false;
            imageFile = file;
          });
      }
    });
  }
  late AppState state;
  File? imageFile;
  Future<Null> _pickImage() async {
    final pickedImage =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
      });
    }
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile!.path,
        aspectRatioPresets: Platform.isAndroid
            ? [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ]
            : [
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio5x3,
          CropAspectRatioPreset.ratio5x4,
          CropAspectRatioPreset.ratio7x5,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          title: 'Cropper',
        ));
    if (croppedFile != null) {
      imageFile = croppedFile;
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    getImage();
    setState(() {
      state = AppState.free;
    });
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(FontAwesomeIcons.pen);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  @override
  void initState() {
    super.initState();
    getImage();
    state = AppState.free;
  }

  void uploadImage(File f)
  async
  {
    // var req = http.MultipartRequest('POST', Uri.parse(Urls.baseUrl + Urls.uploadImage + UserLoginData.userId));
    // req.files.add(
    //     http.MultipartFile(
    //         'picture',
    //         f.readAsBytes().asStream(),
    //         f.lengthSync(),
    //         filename: "profile"
    //     )
    // );
    // var res = await req.send();
    // print(res.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return status ? Scaffold(body: Center(child: CircularProgressIndicator(color: kPrimary))) : Scaffold(
      key: _scaffoldKey,
      backgroundColor: kBackground,
      appBar: AppBarWidget(sK: _scaffoldKey,),
      drawer: NavigationDrawerWidget(),
      body: ListView(
        padding: EdgeInsets.all(20),
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        children: [
          _header(),
          SizedBox(height: 15,),
          Align(
            alignment: Alignment.center,
            child: Stack(
              children: [
                Container(
                  height: 160,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    image: DecorationImage(
                      image: FileImage(imageFile!),
                      fit: BoxFit.fill
                    ),
                    border: Border.all(
                      width: 2,
                      color: kPrimary,
                      style: BorderStyle.solid,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 10,
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: kPrimary,
                    child: IconButton(
                      iconSize: 15,
                      icon: _buildButtonIcon(),
                      onPressed: (){
                        if (state == AppState.free)
                          _pickImage();
                        else if (state == AppState.picked)
                          _cropImage();
                        else if (state == AppState.cropped) _clearImage();
                      },
                    ),
                  ),
                )
              ],
            ),
          ),

          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0, bottom: 5,),
            child: Text("Area:", style: kLightButtonTextStyle,),
          ),
          Stack(
              alignment: const Alignment(1.0, 1.0),
              children: <Widget>[
                TextField(
                  controller: t1,
                  onChanged: (String s){
                    setState(() {
                      data[0] = s;
                    });
                  },
                  readOnly: !text_state[0],
                    decoration: new InputDecoration(
                      // labelText: "Area",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0))
                      ),
                      hintText: UserLoginData.area == 'null' ? "Enter New" : UserLoginData.area,
                    ),),
                !text_state[0] ? IconButton(icon: new Icon(Icons.edit, color: kPrimary,), onPressed: () {
                  setState(() {
                    text_state[0] = true;
                  });
                }) : IconButton(onPressed: (){
                  setState(() {
                    t1.text = "";
                    data[0] = UserLoginData.area;
                    text_state[0] = false;
                  });
                }, icon: Icon(Icons.cancel, color: kPrimary,))
              ]
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5,),
            child: Text("City:", style: kLightButtonTextStyle,),
          ),
          Stack(
              alignment: const Alignment(1.0, 1.0),
              children: <Widget>[
                TextField(
                  controller: t2,
                  onChanged: (String s){
                    setState(() {
                      data[1] = s;
                    });
                  },
                  readOnly: !text_state[1],
                  decoration: new InputDecoration(
                    // labelText: "Area",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    hintText: UserLoginData.city == 'null' ? "Enter New" : UserLoginData.city,
                  ),),
                !text_state[1] ? IconButton(icon: new Icon(Icons.edit, color: kPrimary,), onPressed: () {
                  setState(() {
                    text_state[1] = true;
                  });
                }) : IconButton(onPressed: (){
                  setState(() {
                    t2.text = "";
                    data[1] = UserLoginData.city;
                    text_state[1] = false;
                  });
                }, icon: Icon(Icons.cancel, color: kPrimary,))
              ]
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5,),
            child: Text("Country:", style: kLightButtonTextStyle,),
          ),
          Stack(
              alignment: const Alignment(1.0, 1.0),
              children: <Widget>[
                TextField(
                  controller: t3,
                  onChanged: (String s){
                    setState(() {
                      data[2] = s;
                    });
                  },
                  readOnly: !text_state[2],
                  decoration: new InputDecoration(
                    // labelText: "Area",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    hintText: UserLoginData.country == 'null' ? "Enter New" : UserLoginData.country,
                  ),),
                !text_state[2] ? IconButton(icon: new Icon(Icons.edit, color: kPrimary,), onPressed: () {
                  setState(() {
                    text_state[2] = true;
                  });
                }) : IconButton(onPressed: (){
                  setState(() {
                    t3.text = "";
                    data[2] = UserLoginData.country;
                    text_state[2] = false;
                  });
                }, icon: Icon(Icons.cancel, color: kPrimary,))
              ]
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5,),
            child: Text("Postal Code:", style: kLightButtonTextStyle,),
          ),
          Stack(
              alignment: const Alignment(1.0, 1.0),
              children: <Widget>[
                TextField(
                  controller: t4,
                  onChanged: (String s){
                    setState(() {
                      data[3] = s;
                    });
                  },
                  readOnly: !text_state[3],
                  decoration: new InputDecoration(
                    // labelText: "Area",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    hintText: UserLoginData.postalCode == 'null' ? "Enter New" : UserLoginData.postalCode,
                  ),),
                !text_state[3] ? IconButton(icon: new Icon(Icons.edit, color: kPrimary,), onPressed: () {
                  setState(() {
                    text_state[3] = true;
                  });
                }) : IconButton(onPressed: (){
                  setState(() {
                    t4.text = "";
                    data[3] = UserLoginData.postalCode;
                    text_state[3] = false;
                  });
                }, icon: Icon(Icons.cancel, color: kPrimary,))
              ]
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5,),
            child: Text("Phone Number:", style: kLightButtonTextStyle,),
          ),
          Stack(
              alignment: const Alignment(1.0, 1.0),
              children: <Widget>[
                TextField(
                  controller: t5,
                  onChanged: (String s){
                    setState(() {
                      data[4] = s;
                    });
                  },
                  readOnly: !text_state[4],
                  decoration: new InputDecoration(
                    // labelText: "Area",
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: kPrimary, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(10.0))
                    ),
                    hintText: UserLoginData.phone == 'null' ? "Enter New" : UserLoginData.phone,
                  ),),
                !text_state[4] ? IconButton(icon: new Icon(Icons.edit, color: kPrimary,), onPressed: () {
                  setState(() {
                    text_state[4] = true;
                  });
                }) : IconButton(onPressed: (){
                  setState(() {
                    t5.text = "";
                    data[4] = UserLoginData.phone;
                    text_state[4] = false;
                  });
                }, icon: Icon(Icons.cancel, color: kPrimary,))
              ]
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: screenSize.width*0.5,
            child: VeridoPrimaryButton(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Save Changes",
                    style: kPrimaryButtonTextStyle,
                  ),
                ],
              ),
              onPressed: () {
                updateData(data, context);
                //print(imageFile);
                //print("i");
                //uploadImage(imageFile!);
              },
            ),
          ),

        ],
      ),
    );
  }

  void updateData(var data, context) async {
    setState(() {
      status = true;
    });
    var response = await updateProfile(data);
    var body = jsonDecode(response.body);
    print(response.statusCode);
    setState(() {
      status = false;
    });
    if (response.statusCode==200)
      {
        ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess(body['message']));
        UserLoginData.phone = data[4];
        UserLoginData.area = data[0];
        UserLoginData.city = data[1];
        UserLoginData.country = data[2];
        UserLoginData.postalCode = data[3];
        text_state[0] = false;
        text_state[1] = false;
        text_state[2] = false;
        text_state[4] = false;
        text_state[3] = false;


      }
    else
      {
        ScaffoldMessenger.of(context).showSnackBar(snackBarError(body['message']));
      }
  }

}
