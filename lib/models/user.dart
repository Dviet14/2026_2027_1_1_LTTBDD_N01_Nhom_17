import 'dart:convert';
import 'dart:typed_data';

class User {
  final String id;
  final String fullName;
  final String email;
  final String password;

  // initial, male, female
  final String avatarStyle;
  final Uint8List? avatarBytes;

  const User({
    required this.id,
    required this.fullName,
    required this.email,
    required this.password,
    this.avatarStyle = 'initial',
    this.avatarBytes,
  });

  String get initial {
    final String name = fullName.trim();
    if (name.isEmpty) return '?';
    return String.fromCharCode(name.runes.first).toUpperCase();
  }

  User copyWith({
    String? fullName,
    String? password,
    String? avatarStyle,
    Uint8List? avatarBytes,
    bool clearAvatarBytes = false,
  }) {
    return User(
      id: id,
      fullName: fullName ?? this.fullName,
      email: email,
      password: password ?? this.password,
      avatarStyle: avatarStyle ?? this.avatarStyle,
      avatarBytes: clearAvatarBytes ? null : avatarBytes ?? this.avatarBytes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
      'avatarStyle': avatarStyle,
      'avatarBytes': avatarBytes == null ? null : base64Encode(avatarBytes!),
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    final String? encodedAvatar = json['avatarBytes'] as String?;

    return User(
      id: json['id'] as String,
      fullName: json['fullName'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      avatarStyle: json['avatarStyle'] as String? ?? 'initial',
      avatarBytes: encodedAvatar == null ? null : base64Decode(encodedAvatar),
    );
  }
}
