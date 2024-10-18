import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [..._Background()],
      ),
    );
  }

  _Background() {
    return [
      Positioned.fill(child: Image.asset('images/login-bg1.jpg', fit: BoxFit.cover)),
      Positioned.fill(child: Container(decoration: const BoxDecoration(color: Colors.black54),))
    ];
  }
}
