import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/session_controller.dart';

class SessionView extends GetView<SessionController> {
  const SessionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SessionView'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SessionView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
