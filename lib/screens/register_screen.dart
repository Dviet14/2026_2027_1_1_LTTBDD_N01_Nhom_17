import 'package:flutter/material.dart';

import '../l10n/localized_builder.dart';
import '../services/auth_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _confirmController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _confirmFocus = FocusNode();

  String? _errorKey;

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();

    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();

    super.dispose();
  }

  void _submit() {
    FocusScope.of(context).unfocus();

    try {
      AuthService.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
        _confirmController.text,
      );

      Navigator.pop(context, true);
    } on AuthException catch (e) {
      setState(() {
        _errorKey = e.messageKey;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return LocalizedBuilder(
      builder: (context, strings) {
        return Scaffold(
          appBar: AppBar(title: Text(strings.get('register'))),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 440),
              child: ListView(
                padding: const EdgeInsets.all(24),
                shrinkWrap: true,
                children: [
                  TextField(
                    controller: _nameController,
                    textCapitalization: TextCapitalization.words,
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      _emailFocus.requestFocus();
                    },
                    decoration: InputDecoration(
                      labelText: strings.get('fullName'),
                      prefixIcon: const Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                  ),

                  const SizedBox(height: 16),

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
                    textInputAction: TextInputAction.next,
                    onSubmitted: (_) {
                      _confirmFocus.requestFocus();
                    },
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

                  const SizedBox(height: 16),

                  TextField(
                    controller: _confirmController,
                    focusNode: _confirmFocus,
                    obscureText: !_showConfirmPassword,
                    textInputAction: TextInputAction.done,
                    onSubmitted: (_) => _submit(),
                    decoration: InputDecoration(
                      labelText: strings.get('confirmPassword'),
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        tooltip: _showConfirmPassword
                            ? strings.get('hidePassword')
                            : strings.get('showPassword'),
                        icon: Icon(
                          _showConfirmPassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: () {
                          setState(() {
                            _showConfirmPassword = !_showConfirmPassword;
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
                    child: Text(strings.get('register')),
                  ),

                  const SizedBox(height: 16),

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
