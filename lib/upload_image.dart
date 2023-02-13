import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class ImageUploadScreen extends StatefulWidget {
  const ImageUploadScreen({Key? key}) : super(key: key);

  @override
  State<ImageUploadScreen> createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  // func to pick image:
  Future getImage() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      setState(() {});
    } else {
      log('no image selected');
    }
  }

  // func to upload image:
  Future<void> uploadImage() async {
    setState(() {
      showSpinner = true;
    });
    var stream = http.ByteStream(image!.openRead());
    var length = await image!.length();
    var uri = Uri.parse('https://fakestoreapi.com/products');
    var request = http.MultipartRequest('POST', uri);
    request.fields['title'] = 'Static Title';
    var multipart = http.MultipartFile(
        'image', stream, length); // stream and length are created above
    var response = await request.send();

    log(response.stream.toString());

    if (response.statusCode == 200) {
      setState(() {
        showSpinner = false;
      });
      log('Image uploaded successfully');
    } else {
      setState(() {
        showSpinner = false;
      });
      log('Uploading failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      // to show progress spinner
      inAsyncCall: showSpinner,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Upload Image to App'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                getImage();
              },
              child: Center(
                child: Container(
                  height: 100,
                  width:
                      200, // avoid giving hardcoded dimensions though, need to work on responsiveness!!!
                  color: Colors.blue,
                  child: image == null
                      ? const Center(
                          child: Text('Pick Image'),
                        )
                      : Center(
                          child: Container(
                            // used tertiary operator
                            child: Center(
                              child: Image.file(
                                File(image!.path).absolute,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
            const SizedBox(height: 200),
            GestureDetector(
              onTap: () {
                uploadImage();
              },
              child: Center(
                child: Container(
                  height: 50,
                  width:
                      200, // avoid giving hardcoded dimensions though, need to work on responsiveness!!!
                  color: Colors.blue,
                  child: const Center(child: Text('Upload')),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
