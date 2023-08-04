import 'dart:io';

import 'package:downlorder/homepage/downlorder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

import '../config/file_type.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({required this.selectedScreenIndex, super.key});

  final int selectedScreenIndex;

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with AutomaticKeepAliveClientMixin, WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      setState(() {});
    }
    if (state == AppLifecycleState.paused) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    askPermission();
    getDataFromDisk();

    fetchData(type: FType.all);
  }

  FType t = FType.all;

  @override
  bool get wantKeepAlive => true;

  bool isLoading = false;

  List<File> filesList = [];
  int imagecount = 0;
  int videocount = 0;
  List<File> filesList123 = [];
  List<String> filesList1 = ['.jpg', '.jpg', '.mp4'];
  List<dynamic> qwer = [
    // '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/6a7dfaadb002456b939ca6a8e266eac5.jpg',
    // '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/23233c918206455ea586e9f483a217d3.jpg',
    '/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses/0b577e765b7f42daafd11a3d2f88d3ea.mp4',
  ];

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  final imageExtensions1 = ['jpg', 'jpeg', 'png', 'gif', 'bmp', 'webp'];
  List<String> videoExtensions1 = ['mp4', 'avi', 'mov', 'mkv', 'wmv', 'flv'];
  String firstButtonText = 'Take photo';
  String secondButtonText = 'Record video';

  DateTime pre_backpress = DateTime.now();



  @override
  Widget build(BuildContext context) {

    super.build(context);
    switch (widget.selectedScreenIndex) {
      case 0:
        {
          fetchData(type: FType.all);
        }
      case 1:
        {
          fetchData(type: FType.image);
        }
      case 2:
        {
          fetchData(type: FType.video);
        }
    }
    // print("----------hh---------------${widget.selectedScreenIndex}");
    return RefreshIndicator(
      color: Colors.green,
      onRefresh: getDataFromDisk,
      child: WillPopScope(
        child: Scaffold(
          body: isLoading
              ? list.isNotEmpty
              ? Container(
              child: MasonryGridView.builder(
                addAutomaticKeepAlives: true,
                cacheExtent: 999999,
                gridDelegate:
                const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(),
                // itemCount: filesList.length,
                itemCount: list.length,
                itemBuilder: (context, index) {
                  if (t == FType.image) {
                    return InkWell(
                        onTap: () {
                          print("click on photo");
                          Navigator.push(
                            context,
                            MaterialPageRoute<void>(
                              builder: (context) {
                                return DownloaderPage(
                                  list[index],
                                  isPreview: false,
                                );
                              },
                            ),
                          );
                        },
                        child: Card(
                          elevation: 5,
                          child: Container(
                            margin: const EdgeInsets.all(10) +
                                const EdgeInsets.symmetric(horizontal: 5),
                            // height: 200,
                            child: SizedBox(
                              child: Image.file(list[index]),
                            ),
                          ),
                        ));
                  } else if (t == FType.video) {
                    return InkWell(
                        onTap: () =>
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) {
                                  return DownloaderPage(
                                    key: UniqueKey(),
                                    list[index],
                                    isPreview: false,
                                  );
                                },
                              ),
                            ),
                        child: Card(
                          elevation: 5,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              Card(
                                elevation: 5,
                                margin: const EdgeInsets.all(10),
                                child: DownloaderPage(
                                  list[index],
                                  isPreview: true,
                                ),
                              ),
                              const Icon(
                                Icons.play_circle,
                                color: Colors.white,
                                size: 40,
                              ),
                            ],
                          ),
                        ));
                  } else {
                    if (isImageOrVideoFile(list[index].path) == true) {
                      // photo
                      return InkWell(
                          onTap: () {
                            print("click on photo");
                            Navigator.push(
                              context,
                              MaterialPageRoute<void>(
                                builder: (context) {
                                  return DownloaderPage(
                                    list[index],
                                    isPreview: false,
                                  );
                                },
                              ),
                            );
                          },
                          child: Card(
                            elevation: 5,
                            child: Container(
                              margin: const EdgeInsets.all(10) +
                                  const EdgeInsets.symmetric(
                                      horizontal: 5),
                              // height: 200,
                              child: SizedBox(
                                child: Image.file(list[index]),
                              ),
                            ),
                          ));
                    } else {
                      return InkWell(
                          onTap: () =>
                              Navigator.push(
                                context,
                                MaterialPageRoute<void>(
                                  builder: (context) {
                                    return DownloaderPage(
                                      key: UniqueKey(),
                                      list[index],
                                      isPreview: false,
                                    );
                                  },
                                ),
                              ),
                          child: Card(
                            elevation: 5,
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Card(
                                  elevation: 5,
                                  margin: const EdgeInsets.all(10),
                                  child: DownloaderPage(
                                    list[index],
                                    isPreview: true,
                                  ),
                                ),
                                const Icon(
                                  Icons.play_circle,
                                  color: Colors.white,
                                  size: 40,
                                ),
                              ],
                            ),
                          ));
                    }
                  }
                },
                // itemBuilder: (context, index) {
                //   if (isImageOrVideoFile(filesList[index].path) !=
                //       null) {
                //     if (isImageOrVideoFile(filesList[index].path)!) {
                //       return Visibility(
                //         visible: widget.selectedScreenIndex == 0 ||
                //             widget.selectedScreenIndex == 1,
                //         child: InkWell(
                //           onTap: () {
                //             print("click on photo");
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute<void>(
                //                 builder: (context) {
                //                   return DownloaderPage(
                //                     filesList[index],
                //                     isPreview: false,
                //                   );
                //                 },
                //               ),
                //             );
                //           },
                //           child: Card(
                //             elevation: 5,
                //             child: Container(
                //               margin: const EdgeInsets.all(10) +
                //                   const EdgeInsets.symmetric(
                //                       horizontal: 5),
                //               // height: 200,
                //               child: SizedBox(
                //                 child: Image.file(filesList[index]),
                //               ),
                //             ),
                //           ),
                //         ),
                //       );
                //     } else {
                //       return Visibility(
                //         visible: widget.selectedScreenIndex == 0 ||
                //             widget.selectedScreenIndex == 2,
                //         child: InkWell(
                //           onTap: () => Navigator.push(
                //             context,
                //             MaterialPageRoute<void>(
                //               builder: (context) {
                //                 return DownloaderPage(
                //                   key: UniqueKey(),
                //                   filesList[index],
                //                   isPreview: false,
                //                 );
                //               },
                //             ),
                //           ),
                //           child: Card(
                //             elevation: 5,
                //             child: Stack(
                //               alignment: Alignment.center,
                //               children: [
                //                 Card(
                //                   elevation: 5,
                //                   margin: const EdgeInsets.all(10),
                //                   child: DownloaderPage(
                //                     filesList[index],
                //                     isPreview: true,
                //                   ),
                //                 ),
                //                 const Icon(
                //                   Icons.play_circle,
                //                   color: Colors.white,
                //                   size: 40,
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //       );
                //     }
                //   } else {
                //     return const SizedBox.shrink();
                //   }
                // },
              ))
              : (widget.selectedScreenIndex == 0)
              ? Center(
            child: Center(
              child: Container(
                child: const Text("There is no photo and video"),
              ),
            ),
          )
              : (widget.selectedScreenIndex == 1)
              ? const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.image,
                  color: Colors.grey,
                  size: 150,
                ),
                Text(
                  "No Image Available",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
              : const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.video_call,
                  color: Colors.grey,
                  size: 150,
                ),
                Text(
                  "No video Available",
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ),
          )
              : const Center(child: CircularProgressIndicator()),
        ),
        onWillPop: () async {
          final timegap = DateTime.now().difference(pre_backpress);
          final cantExit = timegap >= const Duration(seconds: 2);
          pre_backpress = DateTime.now();
          if (cantExit) {
            const snack = SnackBar(
              content: Text('Press Back button again to Exit'),
              duration: Duration(seconds: 1),
            );
            ScaffoldMessenger.of(context).showSnackBar(snack);
            return false;
          } else {
            return true;
          }
        },
      ),
    );
  }

  Future<void> askPermission() async {
    final statuses = await [
      Permission.manageExternalStorage,
      // Permission.storage,
    ].request();

    if (
    // statuses[Permission.storage] == PermissionStatus.granted &&
    statuses[Permission.manageExternalStorage] ==
        PermissionStatus.granted) {
      await getDataFromDisk();
    }
  }

  Future<void> getDataFromDisk() async {
    final directory = Directory(
      "/storage/emulated/0/Android/media/com.whatsapp/WhatsApp/Media/.Statuses",
    );

    if (directory.existsSync()) {
      final item = directory.listSync();

      setState(() {
        filesList = item.map((e) => File.fromUri(e.uri)).toList();
        isLoading = true;

        print(" total length ${filesList.length}");
      });
    } else {
      print("No whatsapp");
    }
  }

  // bool hasVideoExtension(List<dynamic> items, List<String> videoExtensions) {
  //   for (final item in items) {
  //     if (item is String) {
  //       var extension = getFileExtension(item);
  //
  //       if (videoExtensions.contains(extension)) {
  //         return true;
  //       }
  //     }
  //   }
  //   return false;
  // }
  //
  // String getFileExtension(String fileName) {
  //   var dotIndex = fileName.lastIndexOf('.');
  //   if (dotIndex >= 0 && dotIndex < fileName.length - 1) {
  //     return fileName.substring(dotIndex);
  //   }
  //   return '';
  // }

  // bool containsPhotoExtension(
  //   List<dynamic> items,
  //   List<String> photoExtensions,
  //   List<String> videoExtensions,
  // ) {
  //   print("***${widget.selectedScreenIndex == 1}== photo");
  //   print("---------------- ${widget.selectedScreenIndex == 2}== video");
  //
  //   var hasPhotoExtension = false;
  //   var hasVideoExtension = true;
  //
  //   for (final item in items) {
  //     if (item is String) {
  //       final extension = item.split('.').last.toLowerCase();
  //       print("---------------- $extension");
  //
  //       if (photoExtensions.contains(extension)) {
  //         hasPhotoExtension = true;
  //         print(
  //           " photo ---------------- ${photoExtensions.contains(extension)}",
  //         );
  //       } else if (videoExtensions.contains(extension)) {
  //         hasVideoExtension = false;
  //         print(
  //           " video ---------------- ${(videoExtensions.contains(extension))}",
  //         );
  //       } else if (hasPhotoExtension && hasVideoExtension) {
  //         return false;
  //       }
  //     }
  //   }
  //
  //   return false;
  // }

  bool? isImageOrVideoFile(String fileName) {
    final lowerCaseFileName = fileName.toLowerCase();

    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

    final videoExtensions = ['.mp4', '.avi', '.mov', '.mkv', '.wmv', '.flv'];

    final fileExtension = path.extension(lowerCaseFileName);

    if (imageExtensions.contains(fileExtension)) {
      return true;
    } else if (videoExtensions.contains(fileExtension)) {
      return false;
    } else {
      return null;
    }
  }

  List<File> list = [];

  void fetchData({required FType type}) {
    t = type;
    print('____> $type');
    list.clear();
    if (type == FType.all) {
      for (int i = 0; i < filesList.length; i++) {
        if (isImageOrVideoFile(filesList[i].path) != null) {
          list.add(filesList[i]);
        }
      }
    } else if (type == FType.image) {
      for (int i = 0; i < filesList.length; i++) {
        if (isImageOrVideoFile(filesList[i].path) == true) {
          list.add(filesList[i]);
        }
      }
    } else if (type == FType.video) {
      for (int i = 0; i < filesList.length; i++) {
        if (isImageOrVideoFile(filesList[i].path) == false) {
          list.add(filesList[i]);
        }
      }
    }
  }
//
// int countVideoExtensions(List<dynamic> items, List<String> videoExtensions) {
//   int count = 0;
//   for (var item in items) {
//     if (item is String) {
//       String extension = getFileExtension1(item);
//       if (videoExtensions.contains(extension)) {
//         count++;
//       }
//     }
//   }
//   return count;
// }
//
// String getFileExtension1(String fileName) {
//   int dotIndex = fileName.lastIndexOf('.');
//   if (dotIndex >= 0 && dotIndex < fileName.length - 1) {
//     return fileName.substring(dotIndex);
//   }
//   return '';
// }
}
