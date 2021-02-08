import 'dart:io';
import 'package:dio/dio.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:gallery_saver/gallery_saver.dart';

class ImgPicker extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => ImgPicker());
  }

  @override
  _ImgPickerState createState() => _ImgPickerState();
}

class _ImgPickerState extends State<ImgPicker> {
  File _image;
  String imagePath;
  String firstButtonText = 'Take photo';
  String secondButtonText = 'Record video';
  double textSize = 20;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });

    // try {
    //   String filename = _image.path.split('/').last;
    //   FormData formData = FormData();
    //   formData.files.addAll([
    //     MapEntry(
    //       'files',
    //       await MultipartFile.fromFile(
    //         _image.path,
    //         filename: filename,
    //       ),
    //     ),
    //   ]);
    //   Dio dio = Dio();
    //   var response =
    //       await dio.post('https://api-mavca.azurewebsites.net/v1/images/upload',
    //           data: formData,
    //           options: Options(headers: {
    //             // "accept": '*/*',
    //             "Authorization":
    //                 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InFjIiwicm9sZUlkIjoiMiIsInJvbGVOYW1lIjoiUUMgTWFuYWdlciIsImp0aSI6IjBiYWEzM2JkLWVjMGQtNGExMS1iNTBjLWE4OGEyMGYzNDRmZiIsIm5iZiI6MTYxMjYwNDU3MywiZXhwIjoxNjEyNjA0ODczLCJpYXQiOjE2MTI2MDQ1NzMsImF1ZCI6Ik1hdmNhIn0.bWlVmNtpvKZ1Twt7RTEfsT406OLflpoPCM2ogkMByOQ',
    //             // "Content-Type": 'multipart/form-data',
    //           }));
    //   dio.interceptors.add(LogInterceptor(responseBody: true));

    //   print('here');
    //   print(response);
    // } catch (e) {
    //   print(e);
    // }
  }

  void _takePhoto() async {
    picker
        .getImage(source: ImageSource.camera)
        .then((PickedFile recordedImage) {
      if (recordedImage != null && recordedImage.path != null) {
        GallerySaver.saveImage(recordedImage.path).then((isSaved) {
          setState(() {
            firstButtonText = 'image saved!';
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                child: SizedBox.expand(
                  child: RaisedButton(
                    color: Colors.blue,
                    onPressed: _takePhoto,
                    child: Text(firstButtonText,
                        style:
                            TextStyle(fontSize: textSize, color: Colors.white)),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Container(
                  child: SizedBox.expand(
                child: RaisedButton(
                  color: Colors.white,
                  onPressed: () {},
                  child: Text(secondButtonText,
                      style: TextStyle(
                          fontSize: textSize, color: Colors.blueGrey)),
                ),
              )),
              flex: 1,
            )
          ],
        ),
      ),
    ));
  }

  Widget _previewImage() {
    return Semantics(
        child: Image.file(File(_image.path)),
        label: 'image_picker_example_picked_image');
  }
}

class ImagePickerButton extends StatefulWidget {
  @override
  _ImagePickerButtonState createState() => _ImagePickerButtonState();
}

class _ImagePickerButtonState extends State<ImagePickerButton> {
  File _image;
  String imagePath;

  final picker = ImagePicker();

  Future<void> getImage() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera).then((pickedFile) {
      if (pickedFile != null && pickedFile.path != null) {
        GallerySaver.saveImage(pickedFile.path).then((isSaved) {
          setState(() {
            if (pickedFile != null) {
              _image = File(pickedFile.path);
            } else {
              print('No image selected.');
            }
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      child: Center(
          child: IconButton(
        icon: Icon(Icons.camera_alt_outlined),
        color: Colors.white,
        onPressed: () {
          getImage();
        },
      )),
      height: 50,
      width: 75,
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              topLeft: Radius.circular(10.0)),
          color: theme.accentColor),
    );
  }
}
