import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

enum AuthProvider { LOCAL, GOOGLE, FACEBOOK }

@JsonSerializable()
class UserDto {
  final int id;
  final String username;
  final String email;
  final String? phoneNumber;
  final bool emailVerified;
  final AuthProvider provider;
  final DateTime createdAt;
  final String? profilePictureUrl;

  UserDto({
    required this.id,
    required this.username,
    required this.email,
    this.phoneNumber,
    required this.emailVerified,
    required this.provider,
    required this.createdAt,
    this.profilePictureUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) =>
      _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);
}
