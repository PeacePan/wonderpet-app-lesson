// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Authentication _$AuthenticationFromJson(Map<String, dynamic> json) =>
    Authentication(
      authenticate: json['authenticate'] == null
          ? null
          : AuthenticationUser.fromJson(
              json['authenticate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationToJson(Authentication instance) =>
    <String, dynamic>{
      'authenticate': instance.authenticate,
    };

AuthenticationUser _$AuthenticationUserFromJson(Map<String, dynamic> json) =>
    AuthenticationUser(
      user: json['user'] == null
          ? null
          : UserBody.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthenticationUserToJson(AuthenticationUser instance) =>
    <String, dynamic>{
      'user': instance.user,
    };

UserBody _$UserBodyFromJson(Map<String, dynamic> json) => UserBody(
      name: json['name'] as String? ?? '',
      displayName: json['displayName'] as String? ?? '',
      disabled: json['disabled'] as bool? ?? false,
    );

Map<String, dynamic> _$UserBodyToJson(UserBody instance) => <String, dynamic>{
      'name': instance.name,
      'displayName': instance.displayName,
      'disabled': instance.disabled,
    };
