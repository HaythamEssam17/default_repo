import 'package:flutter/material.dart';
import 'package:pharmacy/core/theme/app_spacing.dart';
import 'package:pharmacy/core/widgets/app_scaffold.dart';
import 'package:pharmacy/core/widgets/common_button.dart';

class LoginHomePage extends StatefulWidget {
  const LoginHomePage({super.key});

  @override
  State<LoginHomePage> createState() => _LoginHomePageState();
}

class _LoginHomePageState extends State<LoginHomePage> {
  bool _isEnabled = true;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Global Button Demo',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: AppSpacing.xl),
              CommonButton(
                text: 'Login / Submit',
                isEnabled: _isEnabled,
                isLoading: _isLoading,
                // width: 300,
                icon: const Icon(Icons.login, color: Colors.white, size: 20),
                onPressed: () async {
                  setState(() {
                    _isLoading = true;
                    _isEnabled = false;
                  });
                  await Future.delayed(const Duration(seconds: 2));
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Action completed successfully!'),
                      ),
                    );
                  }
                  setState(() {
                    _isLoading = false;
                    _isEnabled = true;
                  });
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Enable Button: '),
                  Switch(
                    value: _isEnabled,
                    onChanged: (value) {
                      setState(() {
                        _isEnabled = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
