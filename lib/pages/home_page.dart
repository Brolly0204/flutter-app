import 'package:flutter/material.dart';
import '../dao/login_dao.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  get _logoutBtn => TextButton(
      onPressed: () {
        LoginDao.logout();
      },
      child: const Text(
        '登出',
        style: TextStyle(color: Colors.white),
      ));

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Colors.blue,
        title: const Text(
          '首页',
          style: TextStyle(color: Colors.white),
        ),
        actions: [_logoutBtn],
      ),
      body: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            onPressed: () {},
            child: const Text('Button'),
          ),
          const Center(
            child: TextField(
              decoration: InputDecoration(
                labelText: "用户名",
                hintText: "用户名或邮箱",
              ),
            ),
          )
        ],
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
