import 'package:flutter/material.dart';
import 'package:weather/constants.dart';

class MapPage extends StatelessWidget {
  MapPage({super.key});

  final Constants _constants = Constants();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _constants.primaryColor,
      appBar: AppBar(
        title: const Text("Map"),
        centerTitle: true,
        backgroundColor: _constants.primaryColor,
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/map.png"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      // child: null,
    );
  }
}
