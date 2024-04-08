//Khóa tạm
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // Import ImagePicker
import 'package:pap_hd/model/documentImages_provider.dart';
import 'package:pap_hd/model/img_provider.dart';
import 'package:provider/provider.dart';

class AttachmentSectionUpdateInfo extends StatefulWidget {
  @override
  _AttachmentSectionUpdateInfoState createState() => _AttachmentSectionUpdateInfoState();
}

class _AttachmentSectionUpdateInfoState extends State<AttachmentSectionUpdateInfo> {
  final List<String> titles = [
    "M1",
    "M2",
    "CCCD",
    "Hồ sơ bệnh án",
    "ContactLog",
    "ADR"
  ];

  void _pickImage(int index) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await showModalBottomSheet<XFile?>(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Máy ảnh'),
            onTap: () async {
              final pickedImage =
                  await _picker.pickImage(source: ImageSource.camera);
              if (pickedImage != null) {
                final String imageName =
                    "${titles[index]}.${pickedImage.path.split('.').last}";
                Provider.of<DocumentImagesProvider>(context, listen: false)
                    .setImage(index, pickedImage, imageName);
                Navigator.of(context).pop();
              }
            },
          ),
          ListTile(
            leading: Icon(Icons.image),
            title: Text('Thư viện'),
            onTap: () async {
              final pickedImage =
                  await _picker.pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                final String imageName =
                    "${titles[index]}.${pickedImage.path.split('.').last}";
                Provider.of<DocumentImagesProvider>(context, listen: false)
                    .setImage(index, pickedImage, imageName);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<XFile?> documentImages =
        Provider.of<DocumentImagesProvider>(context).documentImages;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 18),
          child: Text(
            'Đính kèm tài liệu',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.teal,
              fontSize: 16,
            ),
          ),
        ),
        Container(
          height: 130,
          margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: titles.length,
            itemBuilder: (context, index) {
              String title = titles[index];
              XFile? image =
                  documentImages.length > index ? documentImages[index] : null;

              return Container(
                width: 100,
                height: 130,
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  border: Border.all(color: Colors.teal),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Stack(
                  children: [
                    // Image or Placeholder
                    Center(
                      child: image != null
                          ? Image.file(File(image.path), fit: BoxFit.cover)
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_photo_alternate,
                                    color: Colors.teal),
                                Text(
                                  title,
                                  style: TextStyle(color: Colors.teal),
                                ),
                              ],
                            ),
                    ),
                    // Delete Icon
                    if (image != null)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<DocumentImagesProvider>(context,
                                    listen: false)
                                .clearImage(index);
                            setState(() {}); // Refresh the UI
                          },
                          child: Container(
                            color: Colors.teal,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    // Display Image Name
                    // Display Image Name
                    if (image != null &&
                        Provider.of<DocumentImagesProvider>(context,
                                    listen: false)
                                .imageNames[index] !=
                            null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          color: Colors.black54,
                          child: Text(
                            Provider.of<DocumentImagesProvider>(context,
                                    listen: false)
                                .imageNames[index]!,
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                    // Pick Image if no image
                    if (image == null)
                      Positioned.fill(
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () => _pickImage(index),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

 
