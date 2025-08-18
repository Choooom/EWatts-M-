import 'package:json_annotation/json_annotation.dart';
import 'package:my_app/models/auth/user_dto.dart';

part 'jwt_response.g.dart';

@JsonSerializable()
class JwtResponse {
  final String accessToken;
  final String refreshToken;
  final String tokenType;
  final int expiresIn;
  final UserDto user;

  JwtResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.tokenType,
    required this.expiresIn,
    required this.user,
  });

  factory JwtResponse.fromJson(Map<String, dynamic> json) =>
      _$JwtResponseFromJson(json);
  Map<String, dynamic> toJson() => _$JwtResponseToJson(this);
}
