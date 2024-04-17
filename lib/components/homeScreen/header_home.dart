import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/pages/login.dart';

class Header extends StatelessWidget {
  final String name;
  final GlobalKey avatarKey = GlobalKey();
  Header({super.key, required this.name});

  void showCustomMenu(BuildContext context, GlobalKey avatarKey) {
    final RenderBox avatarBox =
        avatarKey.currentContext!.findRenderObject() as RenderBox;
    final Offset avatarPosition =
        avatarBox.localToGlobal(Offset.zero); // top left of the avatar
    final double avatarHeight = avatarBox.size.height;

    // Determine how much you want to shift the menu to the left
    final double shiftLeftBy = 125.0;
     final double shiftDownBy = 10.0;
    showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        avatarPosition.dx -
            shiftLeftBy, // Shift to the left by subtracting from dx
        avatarPosition.dy + avatarHeight + shiftDownBy,
        avatarPosition.dx,
        avatarPosition.dy,
      ),
      items: <PopupMenuEntry<String>>[
        PopupMenuItem<String>(
          value: 'profile',
          child: Row(
            children: [
              Icon(Icons.person),
              SizedBox(width: 8.0),
              Text('Hồ sơ cá nhân'),
            ],
          ),
        ),
        PopupMenuItem<String>(
          value: 'logout',
          child: Row(
            children: [
              Icon(Icons.exit_to_app),
              SizedBox(width: 8.0),
              Text('Đăng xuất'),
            ],
          ),
        ),
        // ... Add more items if needed
      ],
      color: Color(0xFFE0F2EF), // Use a transparent color for the menu itself
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ).then((value) {
      // Handle your menu item selection here
      if (value == 'logout') {
        // Navigate to login screen
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => LoginScreen()),
          ModalRoute.withName('/'), // Assumed LoginScreen route name is '/'
        );
      } else if (value == 'profile') {
        // Navigate to profile page or perform any action for profile
        // Navigator.of(context).push(...);
      }
    });
  }

 
  Widget buildIconMenu(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print("Icon Menu Pressed");
        // Navigator.pushReplacement(
        //   context,
        //   MaterialPageRoute(builder: (context) => LoginScreen()),
        // );
        // Xử lý khi icon menu được nhấn
        // Đặt hành động bạn muốn thực hiện ở đây
      },
      child: Transform.translate(
        offset: Offset(-6.0, 0.0),
        child: IntrinsicWidth(
          child: SvgPicture.asset(
            'assets/homeScreen/icon_menu.svg',
            height: 40.0,
          ),
        ),
      ),
    );
  }

  // Widget buildAvatar(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       print("Avatar Pressed");
  //       // Xử lý khi avatar được nhấn
  //       // Đặt hành động bạn muốn thực hiện ở đây
  //     },
  //     child: IntrinsicWidth(
  //       child: Transform.translate(
  //         offset: Offset(0.0, 4.0),
  //         child: CircleAvatar(
  //           backgroundImage: AssetImage('assets/homeScreen/header_avt.png'),
  //           radius: 20.0,
  //         ),
  //       ),
  //     ),
  //   );
  // }
   // Replace buildAvatar method
  Widget buildAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showCustomMenu(context, avatarKey);
      },
      child: Container(
        key: avatarKey,
        child: CircleAvatar(
          backgroundImage: AssetImage('assets/homeScreen/header_avt.png'),
          radius: 20.0,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              buildIconMenu(context),
              GestureDetector(
                onTap: () => showCustomMenu(context, avatarKey),
                child: CircleAvatar(
                  key: avatarKey,
                  backgroundImage:
                      AssetImage('assets/homeScreen/header_avt.png'),
                  radius: 20.0,
                ),
              ),
            ],
          ),
          SizedBox(height: 10.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hello $name !',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Welcome to Hoang Duc PAP',
                style: TextStyle(fontSize: 16.0, color: Colors.black),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// class TrianglePainter extends CustomPainter {
//   final Color color;
//   final PaintingStyle paintingStyle;

//   TrianglePainter({this.color = Colors.white, this.paintingStyle = PaintingStyle.fill});

//   @override
//   void paint(Canvas canvas, Size size) {
//     Paint paint = Paint()
//       ..color = color
//       ..style = paintingStyle;

//     Path path = Path();
//     path.lineTo(size.width / 2, 0);
//     path.lineTo(size.width, size.height);
//     path.lineTo(0, size.height);
//     path.close();

//     canvas.drawPath(path, paint);
//   }

//   @override
//   bool shouldRepaint(TrianglePainter oldDelegate) {
//     return oldDelegate.color != color || oldDelegate.paintingStyle != paintingStyle;
//   }
// }
