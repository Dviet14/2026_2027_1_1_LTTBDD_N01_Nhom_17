import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';

import '../models/user.dart';
import 'local_storage_service.dart';

class AuthException implements Exception {
  final String messageKey;

  const AuthException(this.messageKey);
}

class AuthService {
  static const String _storageKey = 'vocabmaster_users_v1';

  static final Map<String, User> _users = {};

  static final ValueNotifier<User?> currentUser = ValueNotifier<User?>(null);

  static int _nextUserId = 1;

  static Future<void> initialize() async {
    final String? raw = LocalStorageService.getString(_storageKey);

    if (raw == null || raw.isEmpty) return;

    try {
      final Map<String, dynamic> data = jsonDecode(raw) as Map<String, dynamic>;

      final List<dynamic> users = data['users'] as List<dynamic>? ?? [];

      _users.clear();

      for (final dynamic item in users) {
        final User user = User.fromJson(Map<String, dynamic>.from(item as Map));

        _users[user.email] = user;
      }

      _nextUserId = data['nextUserId'] as int? ?? (_users.length + 1);
    } catch (error, stackTrace) {
      debugPrint('Could not restore local accounts: $error');
      debugPrint('$stackTrace');

      _users.clear();
      _nextUserId = 1;
    }
  }

  static void _saveUsers() {
    final String raw = jsonEncode({
      'nextUserId': _nextUserId,
      'users': _users.values.map((user) => user.toJson()).toList(),
    });

    unawaited(
      LocalStorageService.setString(_storageKey, raw).catchError((error) {
        debugPrint('Could not save local accounts: $error');
      }),
    );
  }

  // Dang ky tai khoan
  static void register(
    String fullName,
    String email,
    String password,
    String confirmPassword,
  ) {
    final String name = fullName.trim();
    final String mail = email.trim().toLowerCase();

    if (name.isEmpty ||
        mail.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty) {
      throw const AuthException('errEmpty');
    }

    if (name.length < 2) {
      throw const AuthException('errNameShort');
    }

    final RegExp emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

    if (!emailPattern.hasMatch(mail)) {
      throw const AuthException('errEmailInvalid');
    }

    if (_users.containsKey(mail)) {
      throw const AuthException('errEmailExists');
    }

    if (password.length < 6) {
      throw const AuthException('errPasswordShort');
    }

    if (password != confirmPassword) {
      throw const AuthException('errPasswordMismatch');
    }

    final User user = User(
      id: 'user_${_nextUserId++}',
      fullName: name,
      email: mail,
      password: password,
    );

    _users[mail] = user;
    _saveUsers();
    currentUser.value = user;
  }

  // Dang nhap
  static void login(String email, String password) {
    final String mail = email.trim().toLowerCase();

    if (mail.isEmpty || password.isEmpty) {
      throw const AuthException('errEmpty');
    }

    final User? user = _users[mail];

    if (user == null || user.password != password) {
      throw const AuthException('errWrongCredentials');
    }

    currentUser.value = user;
  }

  // Cap nhat thong tin tai khoan
  static void updateAccount({
    required String fullName,
    required String currentPassword,
    String newPassword = '',
    String confirmNewPassword = '',
  }) {
    final User? user = currentUser.value;

    if (user == null) {
      throw const AuthException('errNotLoggedIn');
    }

    final String name = fullName.trim();

    if (name.length < 2) {
      throw const AuthException('errNameShort');
    }

    String password = user.password;

    final bool changingPassword =
        newPassword.isNotEmpty || confirmNewPassword.isNotEmpty;

    if (changingPassword) {
      if (currentPassword.isEmpty) {
        throw const AuthException('errCurrentPasswordRequired');
      }

      if (currentPassword != user.password) {
        throw const AuthException('errWrongCurrentPassword');
      }

      if (newPassword.length < 6) {
        throw const AuthException('errPasswordShort');
      }

      if (newPassword != confirmNewPassword) {
        throw const AuthException('errPasswordMismatch');
      }

      password = newPassword;
    }

    final User updated = user.copyWith(fullName: name, password: password);

    _users[user.email] = updated;
    currentUser.value = updated;

    _saveUsers();
  }

  // Thay avatar bang nhan vat mac dinh
  static void setAvatarStyle(String style) {
    final User? user = currentUser.value;

    if (user == null) {
      throw const AuthException('errNotLoggedIn');
    }

    if (!['initial', 'male', 'female'].contains(style)) {
      throw ArgumentError('Invalid avatar style: $style');
    }

    final User updated = user.copyWith(
      avatarStyle: style,
      clearAvatarBytes: true,
    );

    _users[user.email] = updated;
    currentUser.value = updated;

    _saveUsers();
  }

  // Luu avatar tu thiet bi
  static void setAvatarBytes(Uint8List bytes) {
    final User? user = currentUser.value;

    if (user == null) {
      throw const AuthException('errNotLoggedIn');
    }

    if (bytes.isEmpty) {
      throw const AuthException('errInvalidImage');
    }

    if (bytes.length > 5 * 1024 * 1024) {
      throw const AuthException('errAvatarTooLarge');
    }

    final User updated = user.copyWith(
      avatarBytes: bytes,
      avatarStyle: 'initial',
    );

    _users[user.email] = updated;
    currentUser.value = updated;

    _saveUsers();
  }

  // Dang xuat
  static void logout() {
    currentUser.value = null;
  }
}
