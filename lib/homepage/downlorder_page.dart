import 'dart:io';

import 'package:chewie/chewie.dart';
import 'package:downlorder/config/file_type.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path/path.dart' as path;
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';

// ignore: must_be_immutable
class DownloaderPage extends StatefulWidget {
  const DownloaderPage(this.file, {required this.isPreview, super.key});

  final File file;
  final bool isPreview;

  @override
  State<DownloaderPage> createState() => _DownloaderPageState();
}

class _DownloaderPageState extends State<DownloaderPage> {
  late FileType fileType = isImageOrVideoFile(widget.file.path);

  String firstButtonText = 'Take photo';
  String secondButtonText = 'Record video';

  late VideoPlayerController videoPlayerController;
  ChewieController? chewieController;

  Future<void> initializePlayer() async {
    videoPlayerController = VideoPlayerController.file(widget.file);

    await Future.wait([
      videoPlayerController.initialize(),
    ]);
    createChewieController();
    setState(() {});
  }

  int? bufferDelay;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();

    chewieController?.dispose();

    super.dispose();
  }

  void createChewieController() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: !widget.isPreview,
      looping: true,
      autoInitialize: true,
      showControls: !widget.isPreview,
      progressIndicatorDelay:
          bufferDelay != null ? Duration(milliseconds: bufferDelay!) : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return widget.isPreview
        ? AbsorbPointer(
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.aspectRatio,
              child: chewieController != null &&
                      chewieController!
                          .videoPlayerController.value.isInitialized
                  ? Chewie(
                      controller: chewieController!,
                    )
                  : const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
            ),
          )
        : SafeArea(
            child: Scaffold(
              backgroundColor: Colors.black,
              appBar: AppBar(
                  title: const Text("Image"), backgroundColor: Colors.black,),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (fileType == FileType.image)
                    Container(
                      margin: const EdgeInsets.all(10) +
                          const EdgeInsets.symmetric(horizontal: 5),
                      height: screenHeight * .7,
                      width: screenWidth,
                      child: SizedBox(
                        child: Image.file(widget.file),
                      ),
                    ),
                  if (fileType == FileType.video)
                    SizedBox(
                      height: screenHeight * .7,
                      width: screenWidth,
                      child: Card(
                        elevation: 5,
                        child: AspectRatio(
                          aspectRatio: videoPlayerController.value.aspectRatio,
                          child: chewieController != null &&
                                  chewieController!
                                      .videoPlayerController.value.isInitialized
                              ? Chewie(
                                  controller: chewieController!,
                                )
                              : const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(),
                                    SizedBox(height: 20),
                                    Text('Loading'),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  if (fileType == FileType.other)
                    const Text("Unable to view this type"),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: 100,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: Color(0xffFFB73A),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: ShareImageVideo,
                          icon: const Icon(
                            Icons.share,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        height: 100,
                        width: 70,
                        decoration: const BoxDecoration(
                          color: Color(0xff2C9BFE),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          onPressed: ImageVideoDownlord,
                          icon: const Icon(
                            Icons.download,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  FileType isImageOrVideoFile(String fileName) {
    final lowerCaseFileName = fileName.toLowerCase();

    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp'];

    final videoExtensions = ['.mp4', '.avi', '.mov', '.mkv', '.wmv', '.flv'];

    final fileExtension = path.extension(lowerCaseFileName);

    if (imageExtensions.contains(fileExtension)) {
      return FileType.image;
    } else if (videoExtensions.contains(fileExtension)) {
      return FileType.video;
    } else {
      return FileType.other;
    }
  }

  void ImageVideoDownlord() {
    if (fileType == FileType.image) {
      setState(() {
        secondButtonText = 'saving in progress...';
      });
      GallerySaver.saveImage(widget.file.path).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Photo successfully download")),
        );
        secondButtonText = 'photo saved!';
      });
    } else if (fileType == FileType.video) {
      setState(() {
        secondButtonText = 'saving in progress...';
      });
      GallerySaver.saveVideo(widget.file.path).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Video successfully download")),
        );
        secondButtonText = 'video saved!';
      });
    }
  }

  void ShareImageVideo() {
    final imagePath = widget.file.path;
    Share.shareFiles([imagePath]);
  }
}
