import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';

import '../../../data/models/session_request.dart';
import '../../../data/repository/session_repository.dart';

class SessionController extends GetxController {

  final _repository = SessionRepository();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  Rx<TextEditingController> txtEmail = TextEditingController().obs;
  Rx<TextEditingController> txtPassword = TextEditingController().obs;
  Rx<bool> isLoading = false.obs;
  Rx<bool> showPassword = false.obs;
  Rx<bool> hasPwdError = false.obs;


  tooglePassword(){
    showPassword.value = !showPassword.value;
  }

    String? validateEmail(String? value){
    if((value ?? '').trim().isEmpty){
      return "Por favor, informe o e-mail.";
    }
    return null;
  }

     String? validatePwd(String? value) {
      if((value ?? '').trim().isEmpty){
        hasPwdError.value = true;
         return "Por favor, informe a senha.";
      } 
      hasPwdError.value = false;
      return null;
    
  }

  Future<void> onSession({VoidCallback? onSuccess}) async {
    isLoading.value = true;
    if(!formKey.currentState!.validate()){
       isLoading.value = false;
       return;
       }

    SessionRequest request = SessionRequest(
      email: txtEmail.value.text,
      password: txtPassword.value.text,
    );

    final result = await _repository.session(request: request);

    result.fold((l) {
     isLoading.value = false;
      return Get.showSnackbar(
       GetSnackBar(
         icon: const Icon(PhosphorIcons.circle_wavy_warning, color: Colors.white,),
         message: l.error.toString(),
         backgroundColor: Colors.amber,
         duration: const Duration(seconds: 3),
         snackPosition: SnackPosition.BOTTOM,
       )
     ); 
    } , (r) {
      log(r.toString());
      isLoading.value = false;
      if(onSuccess != null) onSuccess();
    });
  }

}
