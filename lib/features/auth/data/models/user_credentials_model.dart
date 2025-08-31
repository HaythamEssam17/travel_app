import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_credentials_model.g.dart';

@JsonSerializable()
class UserCredentialsModel extends Equatable {
  final String type;
  final String username;
  @JsonKey(name: 'application_name')
  final String applicationName;
  @JsonKey(name: 'client_id')
  final String clientId;
  @JsonKey(name: 'token_type')
  final String tokenType;
  @JsonKey(name: 'access_token')
  final String accessToken;
  @JsonKey(name: 'expires_in')
  final int expiresIn;
  final String state;
  final String scope;

  const UserCredentialsModel({
    required this.type,
    required this.username,
    required this.applicationName,
    required this.clientId,
    required this.tokenType,
    required this.accessToken,
    required this.expiresIn,
    required this.state,
    required this.scope,
  });

  /// fromJson
  factory UserCredentialsModel.fromJson(Map<String, dynamic> json) =>
      _$UserCredentialsModelFromJson(json);

  /// toJson
  Map<String, dynamic> toJson() => _$UserCredentialsModelToJson(this);

  @override
  List<Object?> get props => [
    type,
    username,
    applicationName,
    clientId,
    tokenType,
    accessToken,
    expiresIn,
    state,
    scope,
  ];
}
