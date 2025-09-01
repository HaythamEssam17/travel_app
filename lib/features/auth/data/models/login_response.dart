import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_response.g.dart';

@HiveType(typeId: 1, adapterName: 'LoginResponseAdapter')
@JsonSerializable()
class LoginResponse {
  @HiveField(0)
  final String? accessToken;
  @HiveField(1)
  final String? refreshToken;
  @HiveField(2)
  final User? user;

  LoginResponse({this.accessToken, this.refreshToken, this.user});

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@HiveType(typeId: 2, adapterName: 'UserAdapter')
@JsonSerializable()
class User {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String? email;
  @HiveField(2)
  final String? name;
  @HiveField(3)
  final String? role;

  User({this.id, this.name, this.email, this.role});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
