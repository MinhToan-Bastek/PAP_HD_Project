import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pap_hd/model/img_provider.dart';
import 'package:provider/provider.dart';


class AttachmentSection extends StatefulWidget {

  AttachmentSection({super.key, });
  @override
  _AttachmentSectionState createState() => _AttachmentSectionState();
}

class _AttachmentSectionState extends State<AttachmentSection> {
  
  List<String> documentImages = [];
    // 'assets/patient_registration/doc3.png',
    // 'assets/patient_registration/doc2.png',
    // 'assets/patient_registration/doc1.png',
    // 'assets/patient_registration/doc1.png',
    // 'assets/patient_registration/doc1.png',
    // Thêm đường dẫn các hình ảnh khác tương ứng
  
   void addImage(String imagePath) {
    setState(() {
      documentImages.add(imagePath);
    });
  }

  // void sendImagesToServer() async {
  // var imageProvider = Provider.of<ImageProviderModel>(context, listen: false);
  // List<String> base64Images = [];

  // for (String imagePath in imageProvider.images) {
  //   File imageFile = File(imagePath);
  //   List<int> imageBytes = await imageFile.readAsBytes();
  //   String base64Image = base64Encode(imageBytes);
  //   base64Images.add(base64Image);
  // }

  // // Gửi danh sách các ảnh dạng base64 đến server
  // // Ví dụ: ApiService().sendImages(base64Images);
  // }

    // Map để theo dõi hình ảnh nào đang được chọn
  Map<int, bool> selectedImages = {};


  
  @override
  Widget build(BuildContext context) {
     var imageProvider = Provider.of<ImageProviderModel>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
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
          margin: EdgeInsets.symmetric(vertical: 10.0),
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Color(0xFFE0F2EF), // Màu nền phù hợp với màn hình của bạn
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 2),
              ),
            ],
          ),
        //   child: SizedBox(
        //   height: 110,
        //   width: 360,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: imageProvider.images.length,
        //     itemBuilder: (BuildContext context, int index) {
        //       // Cập nhật để hiển thị hình ảnh từ Provider
        //       return Image.file(File(imageProvider.images[index]), width: 100, height: 120);
        //     },
        //   ),
        // ),

        
        //    child: SizedBox(
        //   height: 110,
        //   width: 360,
        //   child: ListView.builder(
        //     scrollDirection: Axis.horizontal,
        //     itemCount: imageProvider.images.length, // Lấy số lượng ảnh từ Provider
        //     itemBuilder: (BuildContext context, int index) {
        //       return Stack(
        //         alignment: Alignment.topRight,
        //         children: [
        //           Image.file(File(imageProvider.images[index]), width: 100, height: 120,),
        //           Positioned(
        //             right: 10,
        //             top: 5,
        //             child: GestureDetector(
        //               onTap: () {
        //                 // Gọi phương thức removeImageAt từ Provider khi người dùng nhấn "X"
        //                 imageProvider.removeImageAt(index);
        //               },
        //               child: Container(
        //                 padding: EdgeInsets.all(2),
        //                 decoration: BoxDecoration(
        //                   color: Colors.black54,
        //                   borderRadius: BorderRadius.circular(12),
        //                 ),
        //                 child: Icon(Icons.close, size: 16, color: Colors.white,),
        //               ),
        //             ),
        //           ),
        //         ],
        //       );
        //     },
        //   ),
        // ),
          child: SizedBox(
            height: 110,
            width: 360, // Chiều cao container chứa hình ảnh
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: imageProvider.images.length,
              itemBuilder: (BuildContext context, int index) {
                bool isSelected = selectedImages[index] ?? false;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImages[index] = !isSelected;
                    });
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                     Image.file(File(imageProvider.images[index]), width: 100, height: 120,), // ví dụ chiều rộng là 150
                      //  Image.file(
                      //   File(documentImages[index]), // Sử dụng Image.file với đường dẫn tệp
                      //   width: 100,
                      //   height: 120,
                      // ),
                  if (isSelected)
                    Positioned(
                      right: 6, // Giảm giá trị này nếu muốn "X" sát hơn với tờ giấy
                      // Giảm giá trị này nếu muốn "X" sát hơn với tờ giấy
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                           imageProvider.removeImageAt(index);
                            selectedImages.remove(index);
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(2), // Điều chỉnh padding cho "X" nếu cần
                          decoration: BoxDecoration(
                            color: Colors.black54, // Màu nền cho "X"
                            borderRadius: BorderRadius.circular(12), // Điều chỉnh bo viền nếu cần
                          ),
                          child: Icon(Icons.close, size: 16, color: Colors.white,), // Kích thước của "X"
                        ),
                      ),
                    ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
 

}




