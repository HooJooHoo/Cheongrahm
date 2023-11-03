// ignore: unused_import
import 'dart:async';
import 'package:cheongrahm/common/custom_icons_icons.dart';
import 'package:flutter/material.dart';
import 'package:cheongrahm/screens/home_screen.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(milliseconds: 1200),
        (() => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const HomeScreen())))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF4CAF50),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 50,
          ),
          const Text(
            "청원중 · 청원고 · 청원여고",
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w600),
          ),
          const Text(
            "급식 안내 어플리케이션",
            style: TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 130,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                CustomIcons.DefalultNameofIcon,
                color: Colors.white,
                size: 110,
              ),
              SizedBox(
                width: 14,
              )
            ],
          ),
          const Text(
            "청람",
            style: TextStyle(
                color: Colors.white, fontSize: 50, fontWeight: FontWeight.w800),
          ),
          const SizedBox(
            height: 200,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 34,
                height: 30,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/cheongwonicon.png'))),
              ),
              const SizedBox(
                width: 5,
              ),
              const Text(
                "청 원 학 원",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 18),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
