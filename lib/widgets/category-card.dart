import 'package:flutter/material.dart';
import 'package:health_care/config/extention.dart';
import 'package:health_care/config/text_styles.dart';
import 'package:health_care/config/themes.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({Key? key}) : super(key: key);

  @override
  _CategoryCardState createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 6/8,

    );
  }
}
