import 'dart:io';

import 'package:downlorder/homepage/downlorder_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({required this.selectedScreenIndex, super.key});

  final int selectedScreenIndex;

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage>
    with AutomaticKeepAliveClientMixin {
  bool isLoading = false;

  List<File> filesList = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    isLoading = true;
    askPermission();
  }

  String firstButtonText = 'Take photo';
  String secondButtonText = 'Record video';



  DateTime pre_backpress = DateTime.now();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    // print("----------hh---------------${widget.selectedScreenIndex}");
    return WillPopScope(child: Scaffold(
      body: isLoading
          ? Container(
        child: MasonryGridView.builder(
          addAutomaticKeepAlives: true,
          cacheExtent: 999999,
          gridDelegate:
          const SliverSimpleGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
          ),
          physics: const BouncingScrollPhysics(),
          itemCount: filesList.length,
          itemBuilder: (context, index) {
            if (isImageOrVideoFile(filesList[index].path) != null) {
              if (isImageOrVideoFile(filesList[index].path)!) {
                return Visibility(
                  visible: widget.selectedScreenIndex == 0 ||
                      widget.selectedScreenIndex == 1,
                  child: InkWell(
                    onTap: () {
                      print("click on photo");
                      Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (context) {
                            return DownloaderPage(
                              filesList[index],
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
                          child: Image.file(filesList[index]),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return Visibility(
                  visible: widget.selectedScreenIndex == 0 ||
                      widget.selectedScreenIndex == 2,
                  child: InkWell(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (context) {
                          return DownloaderPage(
                            key: UniqueKey(),
                            filesList[index],
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
                              filesList[index],
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
                    ),
                  ),
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      )
          : const Center(child: CircularProgressIndicator()),
    ),

      onWillPop: () async{
        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if(cantExit){

          const snack = SnackBar(content: Text('Press Back button again to Exit'),duration: Duration(seconds: 1),);
          ScaffoldMessenger.of(context).showSnackBar(snack);
          return false;
        }else{
          return true;
        }
      },


    );

  }

  Future<void> askPermission() async {
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

      isLoading = true;
      setState(() {});
    } else {
      print("No whatsapp");
    }
  }

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
}
