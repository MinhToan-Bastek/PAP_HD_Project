// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/material.dart';

// class Project {
//   final String name;
//   final String dateRange;
//   final String patientCount;

//   Project({required this.name, required this.dateRange, required this.patientCount});

//   factory Project.fromJson(Map<String, dynamic> json) {
//     return Project(
//       name: json['name'],
//       dateRange: '${json['startDate']} ~ ${json['endDate']}',
//       patientCount: '${json['patientCount']} patients',
//     );
//   }
// }

// // Lấy dữ liệu từ API
// Future<List<Project>> fetchProjects() async {
//   final response = await http.get(Uri.parse('https://api.yourdomain.com/projects'));

//   if (response.statusCode == 200) {
//     List<dynamic> projectsJson = json.decode(response.body);
//     return projectsJson.map((json) => Project.fromJson(json)).toList();
//   } else {
//     throw Exception('Failed to load projects');
//   }
// }

// // ProjectsScreen uses a FutureBuilder to wait for the data
// class BodyScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Projects'),
//       ),
//       body: FutureBuilder<List<Project>>(
//         future: fetchProjects(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           } else if (snapshot.hasData) {
//             return ProjectsGrid(projects: snapshot.data!);
//           } else {
//             return Center(child: Text('No projects found.'));
//           }
//         },
//       ),
//     );
//   }
// }

// // ProjectsGrid builds a grid of ProjectCard widgets
// class ProjectsGrid extends StatelessWidget {
//   final List<Project> projects;

//   ProjectsGrid({Key? key, required this.projects}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       padding: const EdgeInsets.all(16.0),
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.0,
//         mainAxisSpacing: 16.0,
//       ),
//       itemCount: projects.length,
//       itemBuilder: (context, index) {
//         return ProjectCard(project: projects[index]);
//       },
//     );
//   }
// }

// // ProjectCard is a reusable widget for displaying project information
// class ProjectCard extends StatelessWidget {
//   final Project project;

//   const ProjectCard({Key? key, required this.project}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.tealAccent[400],
//         borderRadius: BorderRadius.circular(24.0),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(12.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             Text(
//               project.name,
//               style: TextStyle(
//                 fontWeight: FontWeight.bold,
//                 fontSize: 20.0,
//                 color: Colors.white,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               project.dateRange,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.white70,
//               ),
//             ),
//             SizedBox(height: 8.0),
//             Text(
//               project.patientCount,
//               style: TextStyle(
//                 fontSize: 16.0,
//                 color: Colors.white,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//Dữ liệu tĩnh
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pap_hd/pages/details.dart';
import 'package:pap_hd/services/api_service.dart';


class Project {
  final String pid;
  final String name;
  final DateTime? dateStart;
  final DateTime? dateFinish;
  final String patientCount;

  Project({
     required this.pid,
    required this.name,
    this.dateStart,
    this.dateFinish,
    required this.patientCount,
  });

  static DateTime? tryParseDate(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return null;
    }

    try {
      // Thử định dạng phổ biến trước
      final DateFormat formatter = DateFormat("M/d/yyyy hh:mm:ss a");
      return formatter.parseLoose(dateString);
    } catch (e) {
      print("Ngày không hợp lệ: $dateString - Lỗi: $e");
      return null;
    }
  }

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      pid: json['Pid'],
      name: json['TenThuoc'],
      dateStart: tryParseDate(json['NgayBatDau']),
      dateFinish: tryParseDate(json['NgayKetThuc']),
      patientCount: json['SoLuongBenhNhan'],
    );
  }
}




class ProjectCard extends StatelessWidget {
  final Project project;
   final String username;
  //final VoidCallback? onPressed;
  const ProjectCard({Key? key, required this.project,required this.username //this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     final String formattedStartDate = project.dateStart != null
        ? DateFormat('dd/MM/yyyy').format(project.dateStart!)
        : 'Unknown';

    final String formattedEndDate = project.dateFinish != null
        ? DateFormat('dd/MM/yyyy').format(project.dateFinish!)
        : 'Unknown';

    final String dateRange = '$formattedStartDate -> $formattedEndDate';

    return GestureDetector(
     onTap: () {
      print('Pid Details: ${project.pid}');
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DetailScreen(pid: project.pid!, username: username),
          ));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(0xFFE9F9F7),
          borderRadius: BorderRadius.circular(24.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: Image.asset(
                  'assets/homeScreen/Grid1.png',
                  width: 60.0,
                  height: 60.0, 
                  fit: BoxFit.cover,
                  //height: 80.0,
                ),
              ),
              SizedBox(height: 8.0),
              Text(
                project.name,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8.0),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      dateRange,
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.black,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow
                          .ellipsis, // Đảm bảo nội dung không xuống dòng
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.0),
              Text(
                 '${project.patientCount} patients',
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProjectsGrid extends StatefulWidget {
  final bool seeAll;
  final String username;
  ProjectsGrid({Key? key, required this.seeAll, required this.username}) : super(key: key);

  @override
  _ProjectsGridState createState() => _ProjectsGridState();
}

class _ProjectsGridState extends State<ProjectsGrid> {
  late Future<List<Project>> futureProjects;

  @override
  void initState() {
    super.initState();
      ApiService apiService = ApiService();
    futureProjects = apiService.fetchProjects(widget.username); 
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Project>>(
      future: futureProjects,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return _buildGridView(snapshot.data!);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buildGridView(List<Project> projects) {
    // var screenSize = MediaQuery.of(context).size;
    // double cellWidth = screenSize.width / 2;
    // double cellHeight = cellWidth + 40;

    // return GridView.builder(
    //   itemCount: widget.seeAll ? projects.length : math.min(projects.length, 4),
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: cellWidth / cellHeight,
    //   ),
    //   itemBuilder: (context, index) {
    //     return ProjectCard(project: projects[index]);
    //   },
    // );
     var screenSize = MediaQuery.of(context).size;
    final int itemCount = widget.seeAll ? projects.length : 3;
    // Giả sử bạn muốn mỗi ô grid có chiều rộng bằng một nửa chiều rộng màn hình trừ đi padding và spacing
    double desiredCellWidth =
        (screenSize.width / 2) - 32; // 16 padding on each side
    double cellHeight = 170; // Giả định chiều cao mong muốn của mỗi ô grid
    double childAspectRatio = desiredCellWidth / cellHeight;
     return GridView.builder(
      shrinkWrap: true,
      physics: BouncingScrollPhysics(),
      //physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        // Đây là giả định chiều cao và tỉ lệ, cần chỉnh sửa cho phù hợp với thiết kế của bạn
        childAspectRatio: 1,
      ),
      itemCount: itemCount,
      itemBuilder: (context, index) {
        return ProjectCard(project: projects[index], username: widget.username,);
      },
    );
  }
}


// class ProjectsGrid extends StatefulWidget {
//   final bool seeAll;
//   ProjectsGrid({Key? key, required this.seeAll}) : super(key: key);

//   @override
//   State<ProjectsGrid> createState() => _ProjectsGridState();
// }

// class _ProjectsGridState extends State<ProjectsGrid> {
//   late Future<List<Project>> futureProjects;

//   @override
//   void initState() {
//     super.initState();
//     futureProjects = ApiService().fetchProjects();
//   }
//   final List<Project> projects = [
//     Project(
//         name: 'Jakavi',
//         dateRange: '01/02/2024 -> 31/12/2024',
//         patientCount: '116 patients',
//         imagePath: 'assets/homeScreen/Grid1.png'),
//     Project(
//         name: 'Tagrisso',
//         dateRange: '01/02/2024 -> 31/12/2024',
//         patientCount: '320 patients',
//         imagePath: 'assets/homeScreen/Grid2.png'),
//     Project(
//         name: 'Lynparza',
//         dateRange: '01/03/2024 -> 31/06/2024',
//         patientCount: '167 patients',
//         imagePath: 'assets/homeScreen/Grid3.png'),
//     Project(
//         name: 'Imfinzi',
//         dateRange: '01/06/2024 -> 31/06/2025',
//         patientCount: '1020 patients',
//         imagePath: 'assets/homeScreen/Grid4.png'),
//     Project(
//         name: 'Imfinzi',
//         dateRange: '01/06/2024 -> 31/06/2025',
//         patientCount: '1020 patients',
//         imagePath: 'assets/homeScreen/Grid4.png'),
//     Project(
//         name: 'Imfinzi',
//         dateRange: '01/06/2024 -> 31/06/2025',
//         patientCount: '1020 patients',
//         imagePath: 'assets/homeScreen/Grid4.png'),
//     // Add more projects as needed
//   ];

//   @override
//   Widget build(BuildContext context) {
//     var screenSize = MediaQuery.of(context).size;
//     final int itemCount = widget.seeAll ? projects.length : 4;
//     // Giả sử bạn muốn mỗi ô grid có chiều rộng bằng một nửa chiều rộng màn hình trừ đi padding và spacing
//     double desiredCellWidth =
//         (screenSize.width / 2) - 32; // 16 padding on each side
//     double cellHeight = 170; // Giả định chiều cao mong muốn của mỗi ô grid
//     double childAspectRatio = desiredCellWidth / cellHeight;
//      return GridView.builder(
//       shrinkWrap: true,
//       physics: BouncingScrollPhysics(),
//       //physics: const NeverScrollableScrollPhysics(),
//       padding: const EdgeInsets.all(16.0),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 16.0,
//         mainAxisSpacing: 16.0,
//         // Đây là giả định chiều cao và tỉ lệ, cần chỉnh sửa cho phù hợp với thiết kế của bạn
//         childAspectRatio: 1,
//       ),
//       itemCount: itemCount,
//       itemBuilder: (context, index) {
//         return ProjectCard(project: projects[index]);
//       },
//     );
//   }
// }
