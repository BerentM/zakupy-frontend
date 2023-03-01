// To parse this JSON data, do
//
//     final jwtLogin = jwtLoginFromJson(jsonString);

import 'dart:convert';

JwtLogin jwtLoginFromJson(String str) => JwtLogin.fromJson(json.decode(str));

String jwtLoginToJson(JwtLogin data) => json.encode(data.toJson());

class JwtLogin {
  JwtLogin({
    required this.accessToken,
    required this.tokenType,
  });

  String accessToken;
  String tokenType;

  factory JwtLogin.fromJson(Map<String, dynamic> json) => JwtLogin(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
      };
}
