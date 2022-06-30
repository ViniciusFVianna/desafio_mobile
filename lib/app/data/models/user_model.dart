import 'dart:convert' as convert;

import '../../../utilities/constant_string.dart';
import '../../../utilities/prefs.dart';

class UserModel {
  String? uId;
  String? login;
  String? nome;
  String? email;
  String? urlFoto;
  String? token;
  String? roles;
  double? latitude;
  double? longetude;

  UserModel({
    this.uId,
    this.login,
    this.nome,
    this.email,
    this.urlFoto,
    this.token,
    this.roles,
    this.latitude,
    this.longetude,
        });

  UserModel.fromJson(Map<String, dynamic> json) {
    uId = json['uId'] ?? '';
    login = json['login'] ?? '';
    nome = json['nome'] ?? '';
    email = json['email'] ?? '';
    urlFoto = json['urlFoto'] ?? '';
    token = json['token'] ?? '';
    roles = json['roles'] ?? '';
    latitude = json['latitude'] ?? 0.0;
    longetude = json['longetude'] ?? 0.0;
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
    data['latutude'] = latitude;
    data['longetude'] = longetude;
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
    return 'Usuario{uId: $uId, login: $login, nome: $nome, email: $email, urlFoto: $urlFoto, token: $token, roles: $roles, latitude: $latitude, longetude: $longetude}';
  }


}