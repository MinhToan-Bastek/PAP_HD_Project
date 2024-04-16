import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pap_hd/services/api_service.dart';

class AttachmentSectionReExamPen extends StatefulWidget {
   final int idPhieuTaiKham;
  final String username;


  const AttachmentSectionReExamPen({Key? key, required this.idPhieuTaiKham, required this.username, }) : super(key: key);

  @override
  _AttachmentSectionReExamPenState createState() => _AttachmentSectionReExamPenState();
}

class _AttachmentSectionReExamPenState extends State<AttachmentSectionReExamPen> {
  final List<String> titles = ["M7", "Toa thuốc hỗ trợ", "Hóa đơn mua ngoài", "ADR", "ContactLog"];
  List<Image?> documentImages = List.generate(5, (_) => null);

  @override
  void initState() {
    super.initState();
    loadImagesFromApi();
  }

   void loadImagesFromApi() async {
    try {
      var apiResponse = await ApiService().getInforExaminationById(widget.username, widget.idPhieuTaiKham);
      if (apiResponse != null && apiResponse['Files'] != null) {
        List<dynamic> files = apiResponse['Files'];
        for (final file in files) {
          String fileNameWithExtension = file['FileName'];
          String fileUrl = file['FileUrl'];
          String fileName = fileNameWithExtension.split('.').first;
          int index = titles.indexOf(fileName);
          if (index != -1 && fileUrl.isNotEmpty) {
            http.Response imgResponse = await http.get(Uri.parse(fileUrl));
            if (imgResponse.statusCode == 200) {
              Image image = Image.memory(imgResponse.bodyBytes, fit: BoxFit.cover);
              setState(() {
                documentImages[index] = image;
              });
            } else {
              print('Failed to load image: $fileUrl');
            }
          }
        }
      }
    } catch (e) {
      print('Error fetching files: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
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
              Image? image = documentImages[index];

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
                      child: image ?? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          //Icon(Icons.photo, color: Colors.teal),
                          Text(title, textAlign: TextAlign.center, style: TextStyle(color: Colors.teal)),
                        ],
                      ),
                    ),
                    // Display Image Name if image is not null
                    if (image != null)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 4),
                          color: Colors.black54,
                          child: Text(
                            title,
                            style: TextStyle(color: Colors.white),
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