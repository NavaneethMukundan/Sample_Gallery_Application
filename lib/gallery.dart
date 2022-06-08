import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_gallery_week_6/home.dart';
import 'package:sample_gallery_week_6/image_view.dart';

class GalleryScreen extends StatefulWidget {
  GalleryScreen({Key? key, required this.imageList}) : super(key: key);
  ValueNotifier<List<String>> imageList;

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  @override
  void initState() {
    createList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            title: const Text('Gallery',style: TextStyle(color: Colors.teal),),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (ctx) => const HomeScreen()),
                        (route) => false);
                  },
                  color: Colors.teal,
                  icon: const Icon(Icons.exit_to_app)),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.white,
                    Colors.white,
                    Colors.teal,
                  ],
                ),
              ),
              child: SafeArea(
                child: ValueListenableBuilder(
                  valueListenable: widget.imageList,
                  builder: (BuildContext context, List<String> value,
                      Widget? child) {
                    return GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 200,
                                childAspectRatio: 3 / 3,
                                crossAxisSpacing: 15,
                                mainAxisSpacing: 25),
                        itemCount: widget.imageList.value.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Colors.white,
                                  Colors.white,
                                ],
                              ),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                    color:
                                        const Color.fromARGB(255, 195, 194, 194)
                                            .withOpacity(0.5),
                                    offset: const Offset(0, 20),
                                    blurRadius: 3,
                                    spreadRadius: -10)
                              ],
                            ),
                            child: InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => ViewImageScreen(
                                            imageList: value[index],
                                          )));
                                },
                                child: Center(
                                    child: Image.file(
                                        File(widget.imageList.value[index])))),
                          );
                        });
                  },
                ),
              ),
            ),
          )),
    );
  }

  Future<void> createList() async {
    final directory = await getExternalStorageDirectory();
    if (directory != null) {
      var listDirectory = await directory.list().toList();

      for (var i = 0; i < listDirectory.length; i++) {
        if (listDirectory[i].path.endsWith('.jpg')) {
          widget.imageList.value.add(listDirectory[i].path);
        }
      }
    }
    widget.imageList.notifyListeners();
  }
}
