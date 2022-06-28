import 'package:desafio_mobile/app/modules/session/controllers/session_controller.dart';
import 'package:desafio_mobile/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../values/app_borders.dart';


class SessionFrom extends StatelessWidget {
   const SessionFrom({
    Key? key,
    required this.controller,
   }) : super(key: key);

   final SessionController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(()=> Form(
      key: controller.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
           const Text('Email', style: TextStyle(
              fontSize: 14,
              color: Colors.white
            )),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.txtEmail.value,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Theme.of(Get.context!).primaryColorLight,
              validator: controller.validateEmail,
              decoration: InputDecoration(
                hintText: 'Informe seu email',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white54
                ),
                border: AppBorders.input.copyWithAll(color: Theme.of(Get.context!).primaryColorLight).borderOutline,
                errorBorder: AppBorders.input.copyWithAll(color: Colors.red[400]).borderOutline,
                focusedBorder: AppBorders.input.copyWithAll(color: Theme.of(Get.context!).primaryColorLight).borderOutline,
                disabledBorder: AppBorders.input.copyWithAll(color: Theme.of(Get.context!).primaryColorLight).borderOutline,
                enabledBorder: AppBorders.input.copyWithAll(color: Theme.of(Get.context!).primaryColorLight).borderOutline,
                errorStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.red[200]
                ),
              ),
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white
                ),
            )            
          ],),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text('Senha', style: TextStyle(
              fontSize: 14,
              color: Colors.white
            )),
            const SizedBox(height: 8),
            TextFormField(
              controller: controller.txtPassword.value,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !controller.showPassword.value,
              cursorColor: Theme.of(Get.context!).primaryColorLight,
              validator: controller.validatePwd,
              decoration: InputDecoration(
                hintText: '••••••••',
                hintStyle: const TextStyle(
                  fontSize: 14,
                  color: Colors.white54
                ),
                border: AppBorders.input.copyWithAll(color: Theme.of(Get.context!).primaryColorLight).borderOutline,
                errorBorder: AppBorders.input.copyWithAll(color: Colors.red[400]).borderOutline,
                focusedBorder: AppBorders.input.copyWithAll(color: Theme.of(Get.context!).primaryColorLight).borderOutline,
                disabledBorder: AppBorders.input.copyWithAll(color: Theme.of(Get.context!).primaryColorLight).borderOutline,
                enabledBorder: AppBorders.input.copyWithAll(color: Theme.of(Get.context!).primaryColorLight).borderOutline,
                errorStyle: TextStyle(
                  fontSize: 12,
                  color: Colors.red[200]
                ),
                suffixIcon: IconButton(
                  onPressed: ()=> controller.tooglePassword(), 
                  icon: Icon( controller.showPassword.value
                    ? PhosphorIcons.eye
                    : PhosphorIcons.eye_slash, 
                  color: controller.hasPwdError.value
                  ? Colors.red[400]
                  : Theme.of(Get.context!).primaryColorLight,
                  size: 24,
                  ),
                  ),
              ),
              style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white
                ),
            )            
          ],),

          const SizedBox(height: 36),

          SizedBox(
            height: 48,
            width: MediaQuery.of(context).size.width,
            child: controller.isLoading.value
            ? Shimmer.fromColors(
              baseColor: Theme.of(Get.context!).primaryColorDark,
               highlightColor: Theme.of(Get.context!).primaryColorLight,
              child: ElevatedButton(
             onPressed: null,
            style: ElevatedButton.styleFrom(
              primary: Theme.of(Get.context!).primaryColorDark,
              shadowColor: Colors.transparent,
              onPrimary: Theme.of(Get.context!).primaryColorDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Container(),
            ))
            : ElevatedButton(
              onPressed: controller.isLoading.value
            ? null
            : () async => await controller.onSession(onSuccess: ()=> Get.toNamed(Routes.home)),
             
            style: ElevatedButton.styleFrom(
              primary: Theme.of(Get.context!).primaryColorDark,
              shadowColor: Colors.transparent,
              onPrimary: Theme.of(Get.context!).primaryColorDark,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              'Entrar',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            ),
            )
          )
        ],
      ),
    ));
  }
}