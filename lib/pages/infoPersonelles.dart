import 'package:flutter/material.dart';

class infoPersonelles extends StatefulWidget {
  const infoPersonelles({super.key});

  @override
  State<infoPersonelles> createState() => _infoPersonellesState();
}

class _infoPersonellesState extends State<infoPersonelles> {
  @override
  Widget build(BuildContext context) {
    double height =MediaQuery.of(context).size.height;
    double width= MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background0.png"),
            fit: BoxFit.cover
          )
        ),

      ),
    );
  }
}
