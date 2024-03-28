// import 'package:flutter/material.dart';

// class TitleBody extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             'PAP Project',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 24.0,
//             ),
//           ),
//           SizedBox(width: 64.0),
//           TextButton(
//             onPressed: () {
//               // Xử lý sự kiện khi nhấn vào nút "See all"
//               print('See all pressed');
//             },
//             child: Text(
//               'See All',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 16.0,
//               ),
//             ),
//           ),
          
//         ],
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class TitleBody extends StatelessWidget {
  final VoidCallback seeAllPressed;
  final bool isSeeAll;

  const TitleBody({Key? key, required this.seeAllPressed, required this.isSeeAll}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'PAP Project',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24.0,
            ),
          ),
          TextButton(
            onPressed: seeAllPressed,
            child: Text(
              isSeeAll ? 'See Less' : 'See All',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}