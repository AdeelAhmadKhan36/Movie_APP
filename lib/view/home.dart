import 'dart:ffi';

import 'package:api_app/res/constants/app_colors.dart';
import 'package:flutter/material.dart';

class Hoome_Screen extends StatefulWidget {
  const Hoome_Screen({super.key});

  @override
  State<Hoome_Screen> createState() => _Hoome_ScreenState();
}

class _Hoome_ScreenState extends State<Hoome_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Movie App",
          style: TextStyle(
              color: Color(kLight.value),
              backgroundColor: Color(kDarkBlue.value)),
        ),
      ),
    );
  }
}
