import 'dart:ui';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePic extends StatefulWidget {
  final Function(File pickedImage) imageFun;
  ProfilePic(this.imageFun);
  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  XFile? _pickedImage;
  @override
  Widget build(BuildContext context) {
    return Center(
      heightFactor: 1,
      child: GestureDetector(
        onTap: () async {
          final _image = await ImagePicker().pickImage(
            source: ImageSource.gallery,
            imageQuality: 100,
            maxWidth: 150,
          );
          setState(() {
            _pickedImage = _image;
          });
          widget.imageFun(File(_pickedImage!.path));
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(
            50,
          ),
          child: Container(
            width: 100,
            height: 100,
            child: Stack(
              children: [
                if (_pickedImage == null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/profile_pic.png'),
                  ),
                if (_pickedImage != null)
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: FileImage(File(_pickedImage!.path)),
                  ),
                Positioned(
                  bottom: 0,
                  child: ClipRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(),
                      child: Container(
                        color: Colors.black12,
                        width: 100,
                        height: 100 / (4),
                        child: Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
