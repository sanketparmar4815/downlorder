import 'dart:io';

import 'package:flutter/material.dart';

class Status_downlorder extends StatefulWidget {
  File filesList;

  Status_downlorder(this.filesList);

  @override
  State<Status_downlorder> createState() => _Status_downlorderState();
}

class _Status_downlorderState extends State<Status_downlorder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("${widget.filesList}")),
    );
  }
}
