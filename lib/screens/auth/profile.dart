import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:health_care/config/data_classes.dart';
import 'package:health_care/config/dimensions.dart';
import 'package:health_care/config/styles.dart';
import 'package:health_care/config/urls.dart';
import 'package:health_care/widgets/appbar.dart';
import 'package:health_care/widgets/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
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
    return SizedBox(width: screenSize.width, child: Text("Patient Profile", style: secondaryBigHeadingTextStyle));
  }
  bool status = false;
  var image;
  bool imageStatus = false;
  void getImage()async{
    setState(() {
      status = true;
    });
    await http.get(Uri.parse(Urls.baseUrl+"doctor.png")).then((value) async {
      if(value.statusCode==200)
      {
          image = NetworkImage(Urls.baseUrl+"doctor.png");
          final documentDirectory = await getApplicationDocumentsDirectory();

          final file = File(join(documentDirectory.path, 'imagetest.png'));

          file.writeAsBytesSync(value.bodyBytes);

          setState(() {
            status = false;
            imageFile = file;
          });
      }
      else{
          image = AssetImage("assets/user.png");
          final documentDirectory = await getApplicationDocumentsDirectory();

          final file = File(join(documentDirectory.path, 'imagetest.png'));

          file.writeAsBytesSync(image.bodyBytes);

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

        ],
      ),
    );
  }
}
