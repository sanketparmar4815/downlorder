// ignore_for_file: strict_raw_type, duplicate_ignore

import 'dart:ui';

import 'package:downlorder/homepage/mainpage.dart';
import 'package:downlorder/otherpage/otherpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int selectedScreenIndex = 0;
  int selectedstatus = 0;

  String dropdownvalue = 'PHOTO & VIDEO';

  List<String> items = [
    'PHOTO & VIDEO',
    'PHOTO',
    'VIDEO',
  ];
  String? appName;
  String? packageName;

  String? version;
  String? buildNumber;
  String? buildSignature;

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      MainHomePage(selectedScreenIndex: selectedstatus),
      const OtherPage(),
    ];
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: selectedScreenIndex == 0
          ? AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              flexibleSpace: ClipRect(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(),
                ),
              ),
              title: DropdownButton(
                borderRadius: BorderRadius.circular(10),
                dropdownColor: Colors.grey,
                style: const TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold,),
                items: items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: const TextStyle(color: Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownvalue = newValue!;
                    if (newValue == 'PHOTO & VIDEO') {
                      setState(() {
                        selectedstatus = 0;
                      });
                    } else if (newValue == 'PHOTO') {
                      setState(() {
                        selectedstatus = 1;
                      });
                    } else {
                      setState(() {
                        selectedstatus = 2;
                      });
                    }

                    print("dropdownvalue ===>  $newValue");
                  });
                },
                value: dropdownvalue,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: Colors.white,
                ),
              ),
            )
          : null,
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () async {
      //
      //     await locator<SharedPreferences>().setString("abc", "hello sanket");
      //     await locator<SharedPreferences>().setString("appName","$appName" );
      //     await locator<SharedPreferences>().setString("packageName","$packageName" );
      //     await locator<SharedPreferences>().setString("version","$version" );
      //     await locator<SharedPreferences>().setString("buildNumber","$buildNumber" );
      //     await locator<SharedPreferences>().setString("buildSignature","$buildSignature" );
      //   },
      // ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        currentIndex: selectedScreenIndex,
        onTap: selectScreen,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(
              FontAwesomeIcons.whatsapp,
            ),
            label: "WhatsApp",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle_outline_sharp,
            ),
            label: "More Tool",
          )
        ],
      ),

      body: screens[selectedScreenIndex],
    );
  }

  void selectScreen(int index) {
    setState(() {
      selectedScreenIndex = index;
    });
  }

//   Future<void> forinfi() async {
//     PackageInfo packageInfo = await PackageInfo.fromPlatform();
// appName = packageInfo.appName;
//      packageName = packageInfo.packageName;
//      version = packageInfo.version;
//      buildNumber = packageInfo.buildNumber;
//      buildSignature = packageInfo.buildSignature;
//
//     print("----------------------------------------------------");
//     print("device info");
//     print("${appName}");
//     print("${packageName}");
//     print("${version}");
//     print("${buildNumber}");
//     print("${buildSignature}");
//
//   }
}
