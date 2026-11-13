import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n/app_strings.dart';
import '../l10n/language_controller.dart';
import '../l10n/localized_builder.dart';
import '../models/user.dart';
import '../services/auth_service.dart';
import '../widgets/center_notification.dart';
import '../widgets/user_avatar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  // Chon avatar
  Future<void> _showAvatarOptions(
    BuildContext context,
    AppStrings strings,
  ) async {
    await showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) {
        return SafeArea(
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  strings.get('chooseAvatar'),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),

              // Tai anh tu thiet bi
              ListTile(
                leading: const Icon(Icons.upload_file),
                title: Text(strings.get('uploadAvatar')),
                onTap: () {
                  _pickAvatar(context, sheetContext, strings);
                },
              ),

              // Avatar chu cai dau tien
              ListTile(
                leading: const CircleAvatar(child: Text('A')),
                title: Text(strings.get('useInitialAvatar')),
                onTap: () {
                  AuthService.setAvatarStyle('initial');
                  Navigator.pop(sheetContext);

                  CenterNotification.show(
                    context,
                    strings.get('avatarUpdated'),
                  );
                },
              ),

              // Avatar nam
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text('👨🏻', style: TextStyle(fontSize: 24)),
                ),
                title: Text(strings.get('maleAvatar')),
                onTap: () {
                  AuthService.setAvatarStyle('male');
                  Navigator.pop(sheetContext);

                  CenterNotification.show(
                    context,
                    strings.get('avatarUpdated'),
                  );
                },
              ),

              // Avatar nu
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.pink,
                  child: Text('👩🏻', style: TextStyle(fontSize: 24)),
                ),
                title: Text(strings.get('femaleAvatar')),
                onTap: () {
                  AuthService.setAvatarStyle('female');
                  Navigator.pop(sheetContext);

                  CenterNotification.show(
                    context,
                    strings.get('avatarUpdated'),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Chon anh tu may tinh hoac dien thoai
  Future<void> _pickAvatar(
    BuildContext context,
    BuildContext sheetContext,
    AppStrings strings,
  ) async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image == null || !context.mounted) {
        return;
      }

      final Uint8List bytes = await image.readAsBytes();

      if (!context.mounted) {
        return;
      }

      if (bytes.isEmpty) {
        throw Exception('Empty image file');
      }

      AuthService.setAvatarBytes(bytes);

      if (sheetContext.mounted) {
        Navigator.pop(sheetContext);
      }

      CenterNotification.show(context, strings.get('avatarUpdated'));
    } on AuthException catch (e) {
      if (!context.mounted) return;

      CenterNotification.show(context, strings.get(e.messageKey));
    } catch (e) {
      debugPrint('Image error: $e');

      if (!context.mounted) return;

      CenterNotification.show(context, strings.get('errInvalidImage'));
    }
  }

  // Sua ten va mat khau
  Future<void> _editAccount(
    BuildContext context,
    AppStrings strings,
    User user,
  ) async {
    final nameController = TextEditingController(text: user.fullName);

    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    String? errorKey;

    bool showCurrentPassword = false;
    bool showNewPassword = false;
    bool showConfirmPassword = false;

    final bool? saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(strings.get('accountInfo')),
              content: SizedBox(
                width: 420,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Ho ten
                      TextField(
                        controller: nameController,
                        textCapitalization: TextCapitalization.words,
                        decoration: InputDecoration(
                          labelText: strings.get('fullName'),
                          prefixIcon: const Icon(Icons.person),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Email khong the sua
                      InputDecorator(
                        decoration: InputDecoration(
                          labelText: strings.get('email'),
                          prefixIcon: const Icon(Icons.email),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: SelectableText(user.email),
                        ),
                      ),

                      const SizedBox(height: 20),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          strings.get('passwordSettings'),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Mat khau hien tai
                      TextField(
                        controller: currentPasswordController,
                        obscureText: !showCurrentPassword,
                        decoration: InputDecoration(
                          labelText: strings.get('currentPassword'),
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showCurrentPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setDialogState(() {
                                showCurrentPassword = !showCurrentPassword;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Mat khau moi
                      TextField(
                        controller: newPasswordController,
                        obscureText: !showNewPassword,
                        decoration: InputDecoration(
                          labelText: strings.get('newPassword'),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showNewPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setDialogState(() {
                                showNewPassword = !showNewPassword;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Xac nhan mat khau moi
                      TextField(
                        controller: confirmPasswordController,
                        obscureText: !showConfirmPassword,
                        decoration: InputDecoration(
                          labelText: strings.get('confirmNewPassword'),
                          prefixIcon: const Icon(Icons.lock_reset),
                          suffixIcon: IconButton(
                            icon: Icon(
                              showConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setDialogState(() {
                                showConfirmPassword = !showConfirmPassword;
                              });
                            },
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          strings.get('passwordOptionalHint'),
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),

                      // Loi nhap lieu
                      if (errorKey != null) ...[
                        const SizedBox(height: 12),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            strings.get(errorKey!),
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(dialogContext, false);
                  },
                  child: Text(strings.get('cancel')),
                ),

                FilledButton(
                  onPressed: () {
                    try {
                      AuthService.updateAccount(
                        fullName: nameController.text,
                        currentPassword: currentPasswordController.text,
                        newPassword: newPasswordController.text,
                        confirmNewPassword: confirmPasswordController.text,
                      );

                      Navigator.pop(dialogContext, true);
                    } on AuthException catch (e) {
                      setDialogState(() {
                        errorKey = e.messageKey;
                      });
                    }
                  },
                  child: Text(strings.get('saveChanges')),
                ),
              ],
            );
          },
        );
      },
    );

    nameController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();

    if (saved == true && context.mounted) {
      CenterNotification.show(context, strings.get('accountUpdated'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        return Scaffold(
          appBar: AppBar(title: Text(strings.get('settings'))),

          body: ValueListenableBuilder<User?>(
            valueListenable: AuthService.currentUser,
            builder: (context, user, _) {
              if (user == null) {
                return const SizedBox.shrink();
              }

              return ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // Tai khoan
                  Text(
                    strings.get('accountSettings'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 12),

                  Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              UserAvatar(
                                user: user,
                                radius: 30,
                                onTap: () {
                                  _showAvatarOptions(context, strings);
                                },
                              ),

                              const SizedBox(width: 16),

                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user.fullName,
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),

                                    Text(
                                      user.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall,
                                    ),

                                    const SizedBox(height: 5),

                                    Text(
                                      strings.get('avatarHint'),
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        const Divider(height: 1),

                        // Thong tin tai khoan
                        ListTile(
                          leading: const Icon(Icons.manage_accounts),
                          title: Text(strings.get('accountInfo')),
                          subtitle: Text(strings.get('accountInfoDesc')),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () {
                            _editAccount(context, strings, user);
                          },
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // Ngon ngu
                  Text(
                    strings.get('language'),
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  const SizedBox(height: 12),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: SegmentedButton<String>(
                        segments: const [
                          ButtonSegment<String>(
                            value: 'vi',
                            label: Text('Tiếng Việt'),
                          ),
                          ButtonSegment<String>(
                            value: 'en',
                            label: Text('English'),
                          ),
                        ],
                        selected: {strings.languageCode},
                        onSelectionChanged: (selection) {
                          LanguageController.change(selection.first);
                        },
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }
}
