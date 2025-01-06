import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/account.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/layout/error_view.dart';
import 'package:extremo/ui/layout/paging_controller.dart';
import 'package:extremo/ui/layout/progress_view.dart';
import 'package:extremodart/extremo/api/auth/accounts/v1/account_service.pb.dart';
import 'package:extremodart/extremo/msg/api/v1/api.pb.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class RegisterPage extends HookConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(accountProvider.notifier);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    /// Submit the registration form
    Future<void> submit(RegisterRequest model) async {
      // TODO(Refactoring): Use to ref.watch.
      // XXX: https://github.com/rrousselGit/riverpod/discussions/1724#discussioncomment-3796657
      final registerAccount = await ref.read(
        registerAccountCaseProvider(model).future,
      );

      registerAccount.onSuccess<AccountToken>((token) {
        notifier.login(token); // TODO(Refactoring): Use await
        ReserveRoute().go(context); // TODO(Refactoring): Use await
      }).onFailure<Exception>((error) {
        final sb = SnackBar(content: Text(error.toString()));
        ScaffoldMessenger.of(context).showSnackBar(sb);
      });
    }

    return Scaffold(
      body: Center(
        child: isSmallScreen
            ? Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Logo(), // ログイン画面と同じロゴを使いまわし
                  _RegisterFormContent(onSubmitted: submit),
                ],
              )
            : Container(
                padding: const EdgeInsets.all(32),
                constraints: const BoxConstraints(maxWidth: 800),
                child: Row(
                  children: [
                    const Expanded(child: Logo()),
                    Expanded(
                      child: Center(
                        child: _RegisterFormContent(onSubmitted: submit),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FlutterLogo(size: isSmallScreen ? 100 : 200),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            t.register,
            textAlign: TextAlign.center,
            style: isSmallScreen ? Theme.of(context).textTheme.headlineSmall : Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

/// Form for registration
class _RegisterFormContent extends HookConsumerWidget {
  const _RegisterFormContent({
    super.key,
    required this.onSubmitted,
  });

  final void Function(RegisterRequest model) onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    // Switch on/off for password visibility
    final isPasswordVisible = useState<bool>(false);

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// Email Address
            FormBuilderTextField(
              name: 'email',
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
                FormBuilderValidators.maxWordsCount(255),
              ]),
            ),
            const Gap(12),

            /// Password
            FormBuilderTextField(
              name: 'password',
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.minLength(8),
                FormBuilderValidators.maxLength(128),
              ]),
              obscureText: !isPasswordVisible.value,
            ),
            const Gap(12),

            /// Confirm Password
            FormBuilderTextField(
              name: 'confirmPassword',
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                hintText: 'Re-enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordVisible.value ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    isPasswordVisible.value = !isPasswordVisible.value;
                  },
                ),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                (value) {
                  if (formKey.currentState?.fields['password']?.value != value) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ]),
              obscureText: !isPasswordVisible.value,
            ),
            const Gap(12),

            /// Sign up button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  if (!(formKey.currentState?.saveAndValidate() ?? false)) {
                    return;
                  }
                  final value = formKey.currentState?.value;
                  if (value == null) {
                    return;
                  }

                  final request = RegisterRequest(
                    email: (value['email'] ?? '') as String,
                    rawPassword: (value['password'] ?? '') as String,
                    confirmPassword: (value['confirmPassword'] ?? '') as String,
                  );

                  onSubmitted(request);
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Sign up',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            const Gap(12),

            /// Go back to the login page if you already have an account
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Already have an account? Sign in',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
