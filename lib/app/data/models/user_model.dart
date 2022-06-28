import 'dart:convert' as convert;

import 'package:desafio_mobile/utililities/prefs.dart';

import '../../../utililities/constant_string.dart';

class UserModel {
  String? uId;
  String? login;
  String? nome;
  String? email;
  String? urlFoto;
  String? token;
  String? roles;

  UserModel({
    this.uId,
    this.login,
    this.nome,
    this.email,
    this.urlFoto,
    this.token,
    this.roles
        });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    login = json['login'] ?? '';
    nome = json['nome'] ?? '';
    email = json['email'] ?? '';
    urlFoto = json['urlFoto'] ?? '';
    token = json['token'] ?? '';
    roles = json['roles'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uId'] = uId;
    data['login'] = login;
    data['nome'] = nome;
    data['email'] = email;
    data['urlFoto'] = urlFoto;
    data['token'] = token;
    data['roles'] = roles;
    return data;
  }

  static void clear() {
    Prefs.setString(ConstantString.authPrefs,'');
  }

  void save() {
    Map map = toJson();

    String json = convert.json.encode(map);

    Prefs.setString(ConstantString.authPrefs, json);
  }

  static Future<UserModel> get() async {
    String json = await Prefs.getString(ConstantString.authPrefs);
    if(json.isEmpty) {
      return UserModel();
    }
     Map<String, dynamic> map = convert.json.decode(json);
    UserModel user = UserModel.fromJson(map);
    return user;
  }

  @override
  String toString() {
    return 'Usuario{uId: $uId, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles}';
  }


}