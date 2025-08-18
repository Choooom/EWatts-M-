// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  email: json['email'] as String,
  phoneNumber: json['phoneNumber'] as String?,
  emailVerified: json['emailVerified'] as bool,
  provider: $enumDecode(_$AuthProviderEnumMap, json['provider']),
  createdAt: DateTime.parse(json['createdAt'] as String),
  profilePictureUrl: json['profilePictureUrl'] as String?,
);

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'phoneNumber': instance.phoneNumber,
  'emailVerified': instance.emailVerified,
  'provider': _$AuthProviderEnumMap[instance.provider]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'profilePictureUrl': instance.profilePictureUrl,
};

const _$AuthProviderEnumMap = {
  AuthProvider.LOCAL: 'LOCAL',
  AuthProvider.GOOGLE: 'GOOGLE',
  AuthProvider.FACEBOOK: 'FACEBOOK',
};
