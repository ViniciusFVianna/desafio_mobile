import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:desafio_mobile/app/data/models/user_model.dart';

import '../../../utilities/constant_string.dart';

class HomeRepository{

  Future<void> addUserInfo(userData) async {
    FirebaseFirestore.instance
        .collection(ConstantString.userEndpoint)
        .add(userData);
  }

  void updateUser(UserModel user) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
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
        .catchError((error) => log("Failed to update user: $error"));
  }

  Future<QuerySnapshot> getUserInfo(String uId) async {
    return await FirebaseFirestore.instance
        .collection(ConstantString.userEndpoint)
        .where("uId", isEqualTo: uId)
        .get();
  }

  Future<QuerySnapshot> searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection(ConstantString.userEndpoint)
        .where('nome', isEqualTo: searchField)
        .get();
  }

  Future<QuerySnapshot> getUsers() async{
    return await FirebaseFirestore.instance.collection(ConstantString.userEndpoint).get();
  }
}