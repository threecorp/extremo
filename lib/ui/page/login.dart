import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:collection/collection.dart';
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

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(accountProvider.notifier);
    final isSmallScreen = MediaQuery.of(context).size.width < 600;

    /// Submit the login form
    Future<void> submit(LoginRequest model) async {
      // TODO(Refactoring): Use to ref.watch.
      // XXX: https://github.com/rrousselGit/riverpod/discussions/1724#discussioncomment-3796657
      final loggedAccount = await ref.read(
        loginTokenCaseProvider(model).future,
      );

      loggedAccount.onSuccess<AccountToken>((token) {
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
                  const Logo(),
                  FormContent(onSubmitted: submit),
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
                        child: FormContent(onSubmitted: submit),
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
            t.login,
            textAlign: TextAlign.center,
            style: isSmallScreen ? Theme.of(context).textTheme.headlineSmall : Theme.of(context).textTheme.headlineMedium?.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class FormContent extends HookConsumerWidget {
  const FormContent({
    super.key,
    required this.onSubmitted,
  });

  final void Function(LoginRequest model) onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    // Use hooks to manage mutable state
    final isPasswordVisible = useState<bool>(false);
    // final rememberMe = useState<bool>(false);

    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: FormBuilder(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FormBuilderTextField(
              name: 'email',
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email_outlined),
                // border: OutlineInputBorder(),
              ),
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.required(),
                FormBuilderValidators.email(),
                FormBuilderValidators.maxWordsCount(255),
              ]),
            ),
            const Gap(12),
            FormBuilderTextField(
              name: 'password',
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                // border: const OutlineInputBorder(),
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
            // CheckboxListTile(
            //   value: rememberMe.value,
            //   onChanged: (value) {
            //     if (value == null) {
            //       return;
            //     }
            //
            //     rememberMe.value = value;
            //   },
            //   title: const Text('Remember me'),
            //   controlAffinity: ListTileControlAffinity.leading,
            //   dense: true,
            //   contentPadding: EdgeInsets.zero,
            // ),
            const Gap(12),
            // signin button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                onPressed: () {
                  // Validate and save the form values
                  if (!(formKey.currentState?.saveAndValidate() ?? false)) {
                    return;
                  }
                  final value = formKey.currentState?.value;
                  if (value == null) {
                    return;
                  }

                  // TODO(Refactoring): Marshal,Unmarshal Library(serializable)
                  onSubmitted(
                    LoginRequest(
                      email: (value['email'] ?? '') as String,
                      password: (value['password'] ?? '') as String,
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Sign in',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            // signup
            const Gap(12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () async {
                  await RegisterRoute().push<void>(context);
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
