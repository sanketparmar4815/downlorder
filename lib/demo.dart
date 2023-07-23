import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MaterialApp(
    home: demo(
      selectedScreenIndex: 0,
    ),
  ),);
}

// ignore: camel_case_types
class demo extends StatefulWidget {
  const demo({required this.selectedScreenIndex, super.key});

  final int selectedScreenIndex;

  @override
  State<demo> createState() => _demoState();
}

// ignore: camel_case_types
class _demoState extends State<demo> {
  bool isLoading = false;

  List<File> filesList = [];


  @override
  void initState() {
    super.initState();
    forpermission();
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController!.dispose();
    chewieController!.dispose();
  }

  VideoPlayerController? videoPlayerController;
  ChewieController? chewieController;

  @override
  Widget build(BuildContext context) {
    print("----------hh---------------${widget.selectedScreenIndex}");
    print("${filesList[1]}");

    return Scaffold(
      body: isLoading
          ? ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: filesList.length,
              itemBuilder: (context, index) {
                if (isImageOrVideoFile(filesList[index].path) != null) {
                  if (isImageOrVideoFile(filesList[index].path)!) {
                    return Visibility(
                      visible: widget.selectedScreenIndex == 0 ||
                          widget.selectedScreenIndex == 1,
                      child: Card(
                        elevation: 5,
                        margin: const EdgeInsets.all(10),
                        child: Container(
                          margin: const EdgeInsets.all(10) +
                              const EdgeInsets.symmetric(horizontal: 5),
                          height: 200,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 4,
                                child: SizedBox(
                                  child: Image.file(filesList[index]),
                                ),
                              ),
                              const SizedBox(width: 10),
                              options()
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Visibility(
                      visible: widget.selectedScreenIndex == 0 ||
                          widget.selectedScreenIndex == 2,
                      child: Card(
                        elevation: 5,
                        child: Container(
                          margin: const EdgeInsets.all(10) +
                              const EdgeInsets.symmetric(horizontal: 5),
                          height: 200,
                          child: Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  height: 200,
                                  child: Chewie(
                                    controller: ChewieController(
                                      videoPlayerController:
                                          VideoPlayerController.file(
                                        filesList[index],
                                      ),
                                      autoPlay: false,
                                      autoInitialize: true,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              options()
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                } else {
                  return const SizedBox.shrink();
                }
              },
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Future<void> forpermission() async {
    final statuses = await [
      Permission.manageExternalStorage,
      Permission.storage,
    ].request();

    if (statuses[Permission.storage] == PermissionStatus.granted &&
        statuses[Permission.manageExternalStorage] ==
            PermissionStatus.granted) {
      getStatus1();
    }
  }

  void getStatus1() {
    final directory = Directory(
      "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses",
    );

    if (directory.existsSync()) {
      final item = directory.listSync();

      filesList = item.map((e) => File.fromUri(e.uri)).toList();

      setState(() {
        isLoading = true;
      });
    } else {
      print("no whatsapp");
    }

    // for (var i = 0; i < filesList.length; i++) {
    //
    //   if (isImageOrVideoFile(filesList[i].path) == true) {
    //     statusjpg.add("${filesList[i]}");
    //   }
    //   if (isImageOrVideoFile(filesList[i].path) == false) {
    //     statusmp4.add("${filesList[i]}");
    //   }
    // }
  }

  bool? isImageOrVideoFile(String fileName) {
    // Convert the file name to lowercase to make the comparison case-insensitive
    final lowerCaseFileName = fileName.toLowerCase();

    // List of supported image extensions
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

    // List of supported video extensions
    final videoExtensions = ['.mp4', '.avi', '.mov', '.mkv', '.wmv', '.flv'];

    // Get the file extension from the file name
    final fileExtension = path.extension(lowerCaseFileName);

    // Check if the file extension matches any image or video extensions
    if (imageExtensions.contains(fileExtension)) {
      return true; // It's an image file
    } else if (videoExtensions.contains(fileExtension)) {
      return false; // It's a video file
    } else {
      return null; // It's neither an image nor a video file
    }
  }

  Widget options() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        CircleAvatar(
          maxRadius: 30,
          child: IconButton(
            onPressed: () async {},
            icon: const Icon(
              Icons.download,
              size: 30,
            ),
          ),
        ),
        CircleAvatar(
          maxRadius: 30,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              size: 30,
            ),
          ),
        ),
        CircleAvatar(
          maxRadius: 30,
          child: IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

//
//
// import 'dart:io';
//
// import 'package:chewie/chewie.dart';
// import 'package:flutter/material.dart';
// import 'package:path/path.dart' as path;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:video_player/video_player.dart';
//
// class MainHomePage extends StatefulWidget {
//   const MainHomePage({required this.selectedScreenIndex, super.key});
//
//   final int selectedScreenIndex;
//
//   @override
//   State<MainHomePage> createState() => _MainHomePageState();
// }
//
// class _MainHomePageState extends State<MainHomePage> {
//   bool isLoading = false;
//   List Allstatus = [];
//   List<File> filesList = [];
//   List statusmp4 = [];
//   List statusjpg = [];
//
//   @override
//   void initState() {
//     super.initState();
//     forpermission();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     videoPlayerController!.dispose();
//     chewieController!.dispose();
//   }
//
//   VideoPlayerController? videoPlayerController;
//   ChewieController? chewieController;
//
//   @override
//   Widget build(BuildContext context) {
//     print("----------hh---------------${widget.selectedScreenIndex}");
//
//     return Scaffold(
//       body: isLoading
//           ? ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: filesList.length,
//         // itemCount: widget.selectedScreenIndex == 0
//         //     ? filesList.length.toInt()
//         //     : widget.selectedScreenIndex == 1
//         //         ? statusjpg.length.toInt()
//         //         : statusmp4.length.toInt(),
//
//         itemBuilder: (context, index) {
//           if (isImageOrVideoFile(filesList[index].path) == null) {
//             return const SizedBox.shrink();
//           }
//           // print("----------hh---------------${widget.selectedScreenIndex}");
//
//           return Card(
//             elevation: 5,
//             margin: const EdgeInsets.all(10),
//             child: Container(
//               margin: const EdgeInsets.all(10) +
//                   const EdgeInsets.symmetric(horizontal: 5),
//               height: 200,
//               child: Row(
//                 children: [
//                   Expanded(
//                     flex: 4,
//                     child: widget.selectedScreenIndex == 1
//                         ? isImageOrVideoFile(filesList[index].path)!
//                         ? SizedBox(
//                       child: Image.file(filesList[index]),
//                     )
//
//                     // :const SizedBox.shrink( )
//                         : const Visibility(
//                       visible: false,
//                       child: SizedBox(
//                         child:
//                         Center(child: Text("this iis video")),
//                       ),
//                     )
//                         : widget.selectedScreenIndex == 2
//                         ? isImageOrVideoFile(filesList[index].path) ==
//                         false
//                         ? Chewie(
//                       controller: ChewieController(
//                         videoPlayerController:
//                         VideoPlayerController.file(
//                           filesList[index],
//                         ),
//                         autoPlay: true,
//                         autoInitialize: true,
//                       ),
//                     )
//
//                         : const SizedBox(
//                       child: Center(
//                         child: Text("this iis photo"),),
//                     )
//                         : isImageOrVideoFile(filesList[index].path) ==
//                         true
//                         ? SizedBox(
//                       child: Image.file(filesList[index]),
//                     )
//                         : isImageOrVideoFile(
//                       filesList[index].path,) ==
//                         false
//                         ? Chewie(
//                       controller: ChewieController(
//                         videoPlayerController:
//                         VideoPlayerController.file(
//                           filesList[index],
//                         ),
//                         autoPlay: true,
//                         autoInitialize: true,
//                       ),
//                     )
//                         : const SizedBox.shrink(),
//                   ),
//                   const SizedBox(width: 10),
//
//
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       CircleAvatar(
//                         maxRadius: 30,
//                         child: IconButton(
//                           onPressed: () {
//                             print(
//                               "total status ${filesList.length}  total video ${statusmp4.length} total photo ${statusjpg.length}",);
//                           },
//                           icon: const Icon(
//                             Icons.download,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                       CircleAvatar(
//                         maxRadius: 30,
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.favorite,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                       CircleAvatar(
//                         maxRadius: 30,
//                         child: IconButton(
//                           onPressed: () {},
//                           icon: const Icon(
//                             Icons.share,
//                             size: 30,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       )
//           : const Center(child: CircularProgressIndicator()),
//     );
//   }
//
//   Future<void> forpermission() async {
//     final statuses = await [
//       Permission.manageExternalStorage,
//       Permission.storage,
//     ].request();
//
//     if (statuses[Permission.storage] == PermissionStatus.granted &&
//         statuses[Permission.manageExternalStorage] ==
//             PermissionStatus.granted) {
//       getStatus1();
//     }
//   }
//
//   void getStatus1() {
//     final directory = Directory(
//       "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses",
//     );
//
//     if (directory.existsSync()) {
//       final item = directory.listSync();
//
//       filesList = item.map((e) => File.fromUri(e.uri)).toList();
//       // print("${filesList}");
//       setState(() {
//         isLoading = true;
//       });
//     } else {
//       print("no whatsapp");
//     }
//
//     for (var i = 0; i < filesList.length; i++) {
//       //   if (filesList[i].toString().contains(".mp4")  {
//       //     statusmp4.add(filesList[i]);
//       //   } else if (filesList[i].toString().contains(".jpg")) {
//       //     statusjpg.add(filesList[i]);
//       //   } else {
//       //     filesList.removeAt(i);
//       //   }
//       // }
//       // print(" Total number of status == > ${filesList.length}");
//       if (isImageOrVideoFile(filesList[i].path) == true) {
//         statusjpg.add("${filesList[i]}");
//       }
//       if (isImageOrVideoFile(filesList[i].path) == false) {
//         statusmp4.add("${filesList[i]}");
//       }
//     }
//   }
//
//   bool? isImageOrVideoFile(String fileName) {
//     // Convert the file name to lowercase to make the comparison case-insensitive
//     final lowerCaseFileName = fileName.toLowerCase();
//
//     // List of supported image extensions
//     final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];
//
//     // List of supported video extensions
//     final videoExtensions = ['.mp4', '.avi', '.mov', '.mkv', '.wmv', '.flv'];
//
//     // Get the file extension from the file name
//     final fileExtension = path.extension(lowerCaseFileName);
//
//     // Check if the file extension matches any image or video extensions
//     if (imageExtensions.contains(fileExtension)) {
//       return true; // It's an image file
//     } else if (videoExtensions.contains(fileExtension)) {
//       return false; // It's a video file
//     } else {
//       return null; // It's neither an image nor a video file
//     }
//   }
// }
