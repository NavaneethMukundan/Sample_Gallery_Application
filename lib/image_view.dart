import 'dart:io';

import 'package:flutter/material.dart';

class ViewImageScreen extends StatefulWidget {
  ViewImageScreen({Key? key, required this.imageList}) : super(key: key);

  String imageList;

  @override
  State<ViewImageScreen> createState() => _ViewImageScreenState();
}

class _ViewImageScreenState extends State<ViewImageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title:const Text(
            'Image',
            style: TextStyle(color: Colors.teal),
          ),
          backgroundColor: Colors.white,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon:const Icon(
                  Icons.arrow_forward_rounded,
                  size: 30,
                  color: Colors.teal,
                ))
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white,
                Colors.teal,
                Color.fromARGB(255, 225, 245, 243)
              ],
            ),
          ),
          child: Center(
            child: Image.file(
              File(widget.imageList),
            ),
          ),
        ));
  }
}
