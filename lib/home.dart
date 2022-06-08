import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sample_gallery_week_6/gallery.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ValueNotifier<List<String>> imageList = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.white, Colors.white, Colors.teal])),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Image.asset('Assets/images/Gallery Img.jpg'),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'Capture The Image',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const SizedBox(
                  height: 150,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton.icon(
                        onPressed: () {
                          pickImage();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal[300],
                        ),
                        icon: const Icon(Icons.camera),
                        label: const Text('Camera')),
                    const SizedBox(
                      width: 70,
                    ),
                    ElevatedButton.icon(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (ctx) =>  GalleryScreen(imageList: imageList)));
                        },
                        style: ElevatedButton.styleFrom(primary: Colors.black),
                        icon: const Icon(Icons.image),
                        label: const Text('Gallery'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> pickImage() async {
    XFile? imagepick =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (imagepick == null) {
      return;
    } else {
      var directory = await getExternalStorageDirectory();
      if (directory != null && !directory.existsSync()) {
        Directory(directory.path);
      }
      File image = File(imagepick.path);
      File newImage =
          await image.copy('${directory!.path}/${DateTime.now()}.jpg');
      imageList.value.add(newImage.path);
      imageList.notifyListeners();
    }
  }
}
