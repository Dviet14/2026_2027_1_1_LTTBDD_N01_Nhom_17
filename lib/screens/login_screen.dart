import 'package:flutter/material.dart';

import '../l10n/language_controller.dart';
import '../l10n/localized_builder.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import '../l10n/app_strings.dart';
import '../widgets/center_notification.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  String? _errorKey;
  bool _showPassword = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    try {
      AuthService.login(_emailController.text, _passwordController.text);

      setState(() => _errorKey = null);
    } on AuthException catch (e) {
      setState(() => _errorKey = e.messageKey);
    }
  }

  Future<void> _openRegister(BuildContext context, AppStrings strings) async {
    final bool? registered = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );

    if (!context.mounted) return;

    if (registered == true) {
      CenterNotification.show(context, strings.get('registerSuccess'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        return Scaffold(
          appBar: AppBar(
            title: Text(strings.get('appTitle')),
            actions: [
              IconButton(
                tooltip: strings.get('language'),
                icon: const Icon(Icons.translate),
                onPressed: () {
                  LanguageController.change(
                    strings.languageCode == 'vi' ? 'en' : 'vi',
                  );
                },
              ),
            ],
          ),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: ListView(
                padding: const EdgeInsets.all(24),
                shrinkWrap: true,
                children: [
                  Icon(
                    Icons.menu_book_rounded,
                    size: 72,
                    color: Theme.of(context).colorScheme.primary,
                  ),

                  const SizedBox(height: 24),

                  TextField(
                    controller: _emailController,
                    focusNode: _emailFocus,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      _passwordFocus.requestFocus();
                    },
                    decoration: InputDecoration(
                      labelText: strings.get('email'),
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextField(
                    controller: _passwordController,
                    focusNode: _passwordFocus,
                    obscureText: !_showPassword,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                      labelText: strings.get('password'),
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        tooltip: _showPassword
                            ? strings.get('hidePassword')
                            : strings.get('showPassword'),
                        icon: Icon(
                          _showPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _showPassword = !_showPassword;
                          });
                        },
                      ),
                      border: const OutlineInputBorder(),
                    ),
                  ),

                  if (_errorKey != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      strings.get(_errorKey!),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ],

                  const SizedBox(height: 24),

                  FilledButton(
                    onPressed: _submit,
                    child: Text(strings.get('login')),
                  ),

                  TextButton(
                    onPressed: () {
                      _openRegister(context, strings);
                    },
                    child: Text(strings.get('noAccount')),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    strings.get('simulatedNote'),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
