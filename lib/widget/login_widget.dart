import 'package:flutter/material.dart';

class LoginWidget extends StatelessWidget {
  final bool enabled;
  final String title;
  final VoidCallback? onPressed;
  const LoginWidget(this.title,
      {super.key, required this.enabled, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        height: 45,
        disabledColor: Colors.white60,
        color: Colors.orange,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        onPressed: enabled ? onPressed : null,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ));
  }
}
