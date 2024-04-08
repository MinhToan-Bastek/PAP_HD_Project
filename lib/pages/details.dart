import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pap_hd/components/bottomNavBar/bottomNavBar.dart';
import 'package:pap_hd/components/detailScreen/medicine_detail.dart';
import 'package:pap_hd/components/detailScreen/options_detail.dart';
import 'package:pap_hd/components/header_all.dart';
import 'package:pap_hd/services/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String pid;
  final String username;
  final String name;
  final String tenChuongTrinh;
  const DetailScreen(
      {super.key,
      required this.pid,
      required this.username,
      required this.name,
      required this.tenChuongTrinh});
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Map<String, dynamic>> projectDetails;

  @override
  void initState() {
    super.initState();
    projectDetails = ApiService().fetchProjectDetails(widget.pid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/homeScreen/home_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Column(
              children: [
                HeaderAll(
                  username: widget.username,
                  name: widget.name,
                  tenChuongTrinh: widget.tenChuongTrinh,
                ),
                //SizedBox(height: 8.0), // Khoảng cách giữa HeaderAll và văn bản
                FutureBuilder<Map<String, dynamic>>(
                  future: projectDetails,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.hasError) {
                        return Center(child: Text('Lỗi khi tải dữ liệu'));
                      } else if (snapshot.hasData) {
                        // Tạo một instance của MedicineDetails từ dữ liệu
                        final details =
                            MedicineDetails.fromJson(snapshot.data!);
                        // Truyền instance này vào MedicineInfo để hiển thị
                        return Column(
                          children: [
                            Text(
                              snapshot.data!['TenChuongTrinh'] ?? 'Unknown',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            SizedBox(height: 16),
                            MedicineInfo(details: details),
                            SizedBox(height: 30),
                            OptionsGrid(
                              maChuongTrinh:
                                  snapshot.data!['MaChuongTrinh'] ?? 'Unknown',
                              username: widget.username,
                              pid: widget.pid,
                              name: widget.name,
                              tenChuongTrinh:  snapshot.data!['TenChuongTrinh'] ?? 'Unknown',
                            ),
                          ],
                        );
                      }
                    }
                    // Hiển thị loading spinner khi dữ liệu đang được tải
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: CustomBottomNavBar(
              username: widget.username,
              pid: widget.pid,
              name: widget.name,
              tenChuongTrinh: widget.tenChuongTrinh,
            ),
          ),
        ],
      ),
    );
  }
}
