import 'package:desafio_mobile/app/modules/session/views/session_form.dart';
import 'package:desafio_mobile/utilities/constant_string.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/session_controller.dart';

class SessionView extends GetView<SessionController> {
  const SessionView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
  height: double.infinity,
  width: double.infinity,
  color: Colors.teal,
  child: SafeArea(
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 40),
          child: const Text(ConstantString.appName,
          style: TextStyle(
            fontSize: 32,
            color: Colors.white,
            fontWeight: FontWeight.w700
          ),),
        ),
    
        const SizedBox(height: 36),
    
        Container(
          width: double.infinity,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: const Text('Login',
          style: TextStyle(
            fontSize: 19,
            color: Colors.white,
            fontWeight: FontWeight.w700
          ),),
        ),
        const SizedBox(height: 36),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SessionFrom(controller: controller))
    
      ],
      ),
    )),
  ),
    );
  }
}
