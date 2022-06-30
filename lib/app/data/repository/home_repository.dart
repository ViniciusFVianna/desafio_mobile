import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_mobile/app/data/models/user_model.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../utilities/constant_string.dart';

class HomeRepository{
  final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  final FirebaseFirestore store = FirebaseFirestore.instance;

  void updateUser(UserModel user) async {
    CollectionReference users = store.collection(ConstantString.userEndpoint);
    return users
        .doc(user.uId)
        .update( {
        'uId' : user.uId,
        'token': user.token ?? '',
        'nome': user.nome ?? '',
        'email': user.email ?? '',
        'login': user.email ?? '',
        'urlFoto': user.urlFoto ?? '',
        'rule': user.roles ?? '',
        'latutude': user.latitude ?? 0.0,
        'longetude': user.longetude ?? 0.0,
    })
        .then((value) => log("User Updated"))
        .catchError((error) {
      crashlytics.setCustomKey("${ConstantString.appName}/${user.uId}", error);
      crashlytics.recordError(error, null);
          log("Failed to update user: $error");
        });
  }
}