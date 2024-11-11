// import 'package:flutter/cupertino.dart';
// ignore_for_file: camel_case_types

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:AAG/Pages/homescreen.dart';

class add1 extends StatefulWidget {
  const add1({super.key});

  @override
  State<add1> createState() => _Add1State();
}

class _Add1State extends State<add1> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color.fromARGB(255, 124, 217, 231),
        child: const Center(
            child: Text(
          'Add_1 Pop Up',
          style: TextStyle(
              fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
        )),
      ),
    );
  }
}










// decoration: const BoxDecoration(
//             image: DecorationImage(
//           image: AssetImage(
//             'lib/images/aag.png',
//           ),
//           fit: BoxFit.fill,
//         )),
//         child: const Center(
//             child: Text(
//           'WinzoClone',
//           style: TextStyle(
//               fontSize: 34, fontWeight: FontWeight.w700, color: Colors.white),
//         )),

//  decoration: const BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage( 'https://s3-alpha-sig.figma.com/img/6999/cfa9/095e0c850cc3c1638607b8eae697faa4?Expires=1719792000&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=n36rwabuNo-qiHV2g1l75A1RotFL~Jzvfl4j5FviZhmQBqeZyxgtvYwUKCEys1Hp0huUaMc1ekuiQIZmuzyP6YchItL44OE5QvkP5v5MUn5w~amkEMvQCY9bV2qrV4IGDPF6PrhdyR~OtZXW885uwHqeOXZbtbhPSKz-qpSMVS8mbp79EWCwlkfA7eVs~a7BIde1dNXtRwwWsXh2MTU9657OqXX6f-iScWVrkT5Vm1BY~C-62XI6b7LP4gfTuaxDCTndjSZGXQ1Am-Q0POXyG-KiKJrYW2QJw~dsjnA0VrSXWjGtBo7eWqBu2vrKsH1jcyah9Y2tgaFwf0EQRUBmcA__',))),

//                   