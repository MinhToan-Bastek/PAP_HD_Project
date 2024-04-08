import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pap_hd/components/login/forgotpass_button.dart';
import 'package:pap_hd/components/login/input.dart';
import 'package:pap_hd/components/login/login_button.dart';
import 'package:pap_hd/components/login/remember_checkbox.dart';
import 'package:pap_hd/components/login/sign_up_button.dart';
import 'package:pap_hd/pages/home.dart';
import 'package:pap_hd/services/api_service.dart';
import 'package:pap_hd/widgets/logo_widgets.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
 

 
  void _login() async {
    var username = _usernameController.text;
    var password = _passwordController.text;
    try {
      var responseData = await ApiService().login(username, password);
      var accessToken = responseData['access_token'];
      var name = responseData['name'];
      var message = responseData['message'];
      if (message == 'success') {
        // Kiểm tra token_access
        // Đăng nhập thành công, chuyển hướng đến HomeScreen
        print('Đăng nhập thành công với username: $username');
        print('Access_Token: $accessToken');
        await ApiService().fetchAndSendToken(username, accessToken);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen(username: username, name: name,tenChuongTrinh: "",)),
        );
      } else {
        // Đăng nhập thất bại, hiển thị thông báo lỗi
        print('Login failed: $message');
        _showLoginFailedMessage(message);
      }
    } catch (e) {
      // Có lỗi xảy ra trong quá trình đăng nhập, hiển thị thông báo lỗi
      print('Login failed: ${e.toString()}');
      _showLoginFailedMessage(e.toString());
    }
  }

  void _showLoginFailedMessage([String errorMessage = '']) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Login failed: $errorMessage")),
    );
  }

  @override
  Widget build(BuildContext context) {
    double logoSize = 40.0;
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/login_background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    LogoWidget(),
                    SvgPicture.asset(
                      'assets/icon_noti.svg',
                      width: logoSize,
                      height: logoSize,
                      color: Colors.black, // Màu của icon
                    ),
                  ],
                ),
                const Spacer(),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                CustomInputField(
                  label: 'Email',
                  icon: Icons.email,
                  isPassword: false,
                  controller: _usernameController,
                ),
                const SizedBox(height: 20),
                CustomInputField(
                  label: 'Password',
                  icon: Icons.lock,
                  isPassword: true,
                  controller: _passwordController,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RememberCheckBox(
                     
                    ),
                    ForgotPasswordButton(
                      onPressed: () {
                        // Hành động khi nút "Login" được nhấn
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                LoginButton(
                  onPressed: _login,
                ),
                SignUpButton(
                  onPressed: () {
                    // Hành động khi nút "Login" được nhấn
                  },
                ),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
