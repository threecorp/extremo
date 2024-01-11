// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/artifact.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/ui/layout/error_view.dart';
import 'package:extremo/ui/layout/paging_controller.dart';
import 'package:extremo/ui/layout/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PostPage extends HookConsumerWidget {
  const PostPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text(t.post)),
      body: const MyCustomForm(),
    );
  }
}

class MyCustomForm extends HookConsumerWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    return FormBuilder(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilderTextField(
            name: 'title',
            decoration: InputDecoration(labelText: t.title),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.maxWordsCount(255),
            ]),
          ),
          FormBuilderTextField(
            name: 'summary',
            decoration: InputDecoration(labelText: t.summary),
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(),
              FormBuilderValidators.maxWordsCount(255),
            ]),
          ),
          FormBuilderTextField(
            name: 'content',
            decoration: InputDecoration(labelText: t.content),
            minLines: 3,
            maxLines: 10,
            // validator: FormBuilderValidators.compose([]),
          ),
          // FormBuilderTextField(
          //   name: 'status',
          //   decoration: InputDecoration(labelText: t.status),
          //   validator: FormBuilderValidators.compose([
          //     FormBuilderValidators.required(),
          //     FormBuilderValidators.maxWordsCount(255),
          //   ]),
          // ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                // Validate and save the form values
                if (formKey.currentState?.saveAndValidate() ?? false) {
                  debugPrint(formKey.currentState?.value.toString());
                }

                // On another side, can access all field values
                // without saving form with instantValues
                debugPrint(formKey.currentState?.instantValue.toString());
              },
              child: const Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
