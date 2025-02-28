import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:desafio_mobile/utilities/prefs.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../../utilities/constant_string.dart';
import '../../../utilities/error_response.dart';
import '../models/session_request.dart';
import '../models/user_model.dart';

class SessionRepository{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String firebaseUserUid;
  final FirebaseCrashlytics crashlytics = FirebaseCrashlytics.instance;
  final FirebaseAnalytics analytics = FirebaseAnalytics.instance;

  Future<Either<ErrorResponse, bool>> session({required SessionRequest request}) async {
    try{
      // Login no Firebase
      UserCredential result = await _auth.signInWithEmailAndPassword(
            email: request.email.toString(), 
            password: request.password.toString(),
      ).whenComplete(() => analytics.logEvent(
        name: 'sign_up',
        parameters: {
          "email": request.email,
          "password": request.password
        }
      ))
          .catchError((error){
        crashlytics.setCustomKey(ConstantString.appName, error);
        crashlytics.recordError(error, null);
      });

      final User fUser = result.user!;
      // Cria um usuario do app
      final user = UserModel(
        uId : fUser.uid,
        nome: fUser.displayName ?? '',
        login: fUser.email ?? '',
        email: fUser.email ?? '',
        urlFoto: fUser.photoURL ?? '',
        token: fUser.refreshToken ?? '',
      );
      user.save();

      // Salva no Firestore
      saveUser(fUser);

      return right(true);
    }catch(e){
      return left(ErrorResponse(error: e.toString()));
    }
  }

    // salva o usuario na collection de usuarios logados
  void saveUser(User fUser) async {
    firebaseUserUid = fUser.uid;
    CollectionReference cUser = FirebaseFirestore.instance.collection(ConstantString.userEndpoint);

    String? token; 
   await fUser.getIdToken().then((value) => token = value);

   QuerySnapshot? user;
    await FirebaseFirestore.instance
        .collection(ConstantString.userEndpoint)
        .where("uId", isEqualTo: firebaseUserUid)
        .get().then((value) => user = value);

        if(user != null && user!.docs.isEmpty){
           cUser.doc(firebaseUserUid)
            .set({
              'uId' : firebaseUserUid,
              'token': token ?? fUser.refreshToken,
              'nome': fUser.displayName ?? '',
              'email': fUser.email ?? '',
              'login': fUser.email ?? '',
              'urlFoto': fUser.photoURL ?? '',
              'rule': ''
            }).then((value) => log("User Added : ${user?.docs.first.data()}"))
               .whenComplete(() => analytics.logEvent(
               name: 'session',
               parameters: {
                 'uId' : firebaseUserUid,
                 'token': token ?? fUser.refreshToken,
                 'nome': fUser.displayName ?? '',
                 'email': fUser.email ?? '',
                 'login': fUser.email ?? '',
                 'urlFoto': fUser.photoURL ?? '',
                 'rule': ''
               }
           ))
                .catchError((error) {
             crashlytics.setCustomKey("${ConstantString.appName}/$firebaseUserUid", "Failed to add user: $error");
             crashlytics.recordError(error, null);
                  log("Failed to add user: $error");
                });
        }else{
          cUser.doc(firebaseUserUid)
            .update( {
          'uId' : user?.docs.first.get('uId'),
          'token': user?.docs.first.get('token') ?? '',
          'nome': user?.docs.first.get('nome') ?? '',
          'email': user?.docs.first.get('email') ?? '',
          'login': user?.docs.first.get('email') ?? '',
          'urlFoto': user?.docs.first.get('urlFoto') ?? '',
          'rule': user?.docs.first.get('rule') ?? ''
        })
        .then((value) => log("User Updated : ${user?.docs.first.data()}"))
              .whenComplete(() => analytics.logEvent(
              name: 'session',
              parameters: {
                'uId' : user?.docs.first.get('uId'),
                'token': user?.docs.first.get('token') ?? '',
                'nome': user?.docs.first.get('nome') ?? '',
                'email': user?.docs.first.get('email') ?? '',
                'login': user?.docs.first.get('email') ?? '',
                'urlFoto': user?.docs.first.get('urlFoto') ?? '',
                'rule': user?.docs.first.get('rule') ?? ''
              }
          ))
        .catchError((error) {
            crashlytics.setCustomKey("${ConstantString.appName}/$firebaseUserUid", "Failed to update user: $error");
            crashlytics.recordError(error, null);
          log("Failed to update user: $error");
        });

        final userModel = UserModel(
          uId : user?.docs.first.get('uId'),
          token: user?.docs.first.get('token') ?? '',
          nome: user?.docs.first.get('nome') ?? '',
          email: user?.docs.first.get('email') ?? '',
          login: user?.docs.first.get('email') ?? '',
          urlFoto: user?.docs.first.get('urlFoto') ?? '',
          roles: user?.docs.first.get('rule') ?? ''
          );
      userModel.save();
        }
  } 

    Future<void> logout() async {
    await _auth.signOut()
    .whenComplete(() => analytics.logEvent(
        name: 'session',
        parameters: {
          'log_out' : true,
        }
    ));
    Prefs.setString(ConstantString.authPrefs,'');
  }
}