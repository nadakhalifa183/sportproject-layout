import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sports_project/component/default_button.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:sports_project/component/conest.dart';

class AddPostScreen extends StatefulWidget {
  static String id = 'AddPostScreen';

  @override
  _AddPostScreenState createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  File? _image;
  File? _video;
  final picker = ImagePicker();
  VideoPlayerController? _videoController;

  Future getImage() async {
    final pickedFile =
    await picker.getImage(source: ImageSource.gallery, imageQuality: 80);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  Future getVideo() async {
    final pickedFile =
    await picker.getVideo(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _video = File(pickedFile.path);
        _videoController = VideoPlayerController.file(_video!)
          ..initialize().then((_) {
            setState(() {
              _videoController!.play();
            });
          });
      }
    });
  }

  @override
  void dispose() {
    _videoController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios_new),
          ),
          title: Text('Create Post'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Write something...',
                    border: OutlineInputBorder(),
                  ),
                  minLines: 3,
                  maxLines: 5,
                ),
                SizedBox(height: 40
                  ,),
                DefaultButton(
                  label: "Add Picture",
                  onTap: () {

                  },
                  buttonColor: kPrimaryColor,
                ),

                SizedBox(height: 20
                    , ),
                DefaultButton(
                  label: "Add Video",
                  onTap: () {

                  },
                  buttonColor: kPrimaryColor,
                ),

                SizedBox(
                  height: 200,
                ),
                FractionallySizedBox(
                  widthFactor: 0.5, // Assign the desired width factor (0.5 means half of the available width)
                  child: DefaultButton(
                    label: "post",
                    onTap: () {
                      
                    },
                    buttonColor: kPrimaryColor,
                  ),
                ),
                SizedBox(height: 15),
                if (_image != null) Image.file(_image!),
                if (_videoController != null)
                  AspectRatio(
                    aspectRatio: _videoController!.value.aspectRatio,
                    child: VideoPlayer(_videoController!),
                  ),
              ],
            ),
          ),

        )


    );
  }
  void _submitPost() {
    // Handle post submission
    // Access entered text: textEditingController.text
    // Access selected image: _image
    // Access selected video: _video
  }
}