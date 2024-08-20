import 'package:json_annotation/json_annotation.dart';

part 'auth.g.dart';

@JsonSerializable()
class Authentication {
  AuthenticationUser? authenticate;

  Authentication({
    this.authenticate,
  });
  factory Authentication.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationToJson(this);
}

/// 萬達中台登入資訊
@JsonSerializable()
class AuthenticationUser {
  UserBody? user;

  AuthenticationUser({
    this.user,
  });
  factory AuthenticationUser.fromJson(Map<String, dynamic> json) =>
      _$AuthenticationUserFromJson(json);
  Map<String, dynamic> toJson() => _$AuthenticationUserToJson(this);
}

/// 表頭
@JsonSerializable()
class UserBody {
  String name;
  String displayName;
  bool disabled;

  UserBody({
    this.name = '',
    this.displayName = '',
    this.disabled = false,
  });
  factory UserBody.fromJson(Map<String, dynamic> json) =>
      _$UserBodyFromJson(json);
  Map<String, dynamic> toJson() => _$UserBodyToJson(this);
}
