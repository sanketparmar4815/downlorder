// ignore_for_file: strict_raw_type, duplicate_ignore

import 'package:downlorder/homepage/mainpage.dart';
import 'package:downlorder/main.dart';
import 'package:downlorder/otherpage/otherpage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String? packageName ;
  String? version;
  String? buildNumber;
  String? buildSignature;

  @override
  void initState() {
    super.initState();
    // forpermission();
    // forinfi();
  }

  @override
  Widget build(BuildContext context) {
    final screens = <Widget>[
      MainHomePage(selectedScreenIndex: selectedstatus),
      const OtherPage(),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: selectedScreenIndex == 0
            ? AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xff190019),
                  Color(0xff2B124C),
                  Color(0xff522B5B),
                  Color(0xff854F6C),
                  Color(0xffDFB6B2),
                  Color(0xffFBE4D8),
                ],
              ),
            ),
          ),
          elevation: 1,
          backgroundColor: Colors.black26,
          title: DropdownButton(
            items: items.map((String items) {
              return DropdownMenuItem(
                value: items,
                child: Text(
                  items,
                  style: const TextStyle(color: Colors.white),
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
            icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white),
          ),
        )
            : null,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {

            await locator<SharedPreferences>().setString("abc", "hello sanket");
            await locator<SharedPreferences>().setString("appName","$appName" );
            await locator<SharedPreferences>().setString("packageName","$packageName" );
            await locator<SharedPreferences>().setString("version","$version" );
            await locator<SharedPreferences>().setString("buildNumber","$buildNumber" );
            await locator<SharedPreferences>().setString("buildSignature","$buildSignature" );
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
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
              icon: Icon(Icons.add_circle_outline_sharp),
              label: "More Tool",
            )
          ],
        ),
        body: screens[selectedScreenIndex],
      ),
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

// Future<void> forpermission() async {
//   final statuses = await [
//     Permission.manageExternalStorage,
//     Permission.storage,
//   ].request();
//
//   if (statuses[Permission.storage] == PermissionStatus.granted &&
//       statuses[Permission.manageExternalStorage] ==
//           PermissionStatus.granted) {
//     getStatus1();
//   }
// }
//
// void getStatus1() {
//   final directory = Directory(
//     "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses",
//   );
//
//   if (directory.existsSync()) {
//     final item = directory.listSync();
//
//     filesList = item.toList();
//   } else {
//     print("no whastup");
//   }
//
//   // ignore: omit_local_variable_types
//   for (int i = 0; i < filesList.length; i++) {
//     if (filesList[i].toString().contains(".mp4")) {
//       statusmp4.add(filesList[i]);
//     } else if (filesList[i].toString().contains(".jpg")) {
//       statusjpg.add(filesList[i]);
//     } else {
//       filesList.removeAt(i);
//     }
//   }
//   setState(() {
//     Homepage.viewAllSatatus = filesList;
//     print("77777777777777777777777777777777777777");
//     print("${Homepage.viewAllSatatus}");
//   });
// }
}
