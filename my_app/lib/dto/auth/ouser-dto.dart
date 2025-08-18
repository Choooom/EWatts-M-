enum OAuthState {
  idle,
  loading,
  webviewOpen,
  exchangingTokens,
  success,
  error,
  cancelled,
}

// Helper extension for UserDto (assuming it exists in your models)
// You might need to adjust this based on your actual UserDto implementation
class OUserDto {
  final int id;
  final String username;
  final String email;
  final bool isEmailVerified;
  final String? profilePictureUrl;
  final String? provider;
  final DateTime createdAt;
  final DateTime updatedAt;

  OUserDto({
    required this.id,
    required this.username,
    required this.email,
    required this.isEmailVerified,
    this.profilePictureUrl,
    this.provider,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OUserDto.fromJson(Map<String, dynamic> json) {
    return OUserDto(
      id: json['id'] as int,
      username: json['username'] as String,
      email: json['email'] as String,
      isEmailVerified: json['isEmailVerified'] as bool? ?? false,
      profilePictureUrl: json['profilePictureUrl'] as String?,
      provider: json['provider'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'isEmailVerified': isEmailVerified,
      'profilePictureUrl': profilePictureUrl,
      'provider': provider,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
