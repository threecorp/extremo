// import 'package:extremo/domain/model/extremo.dart';
// import 'package:extremo/domain/usecase/artifact.dart';
// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/page/service.dart';
import 'package:extremo/ui/page/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:uuid/uuid.dart';

// slider provider
final sliderValueProvider = StateProvider<double>((ref) => 50.0);

// switch provider
final switchValueProvider = StateProvider<bool>((ref) => false);

// drop down provider
final dropdownValueProvider = StateProvider<String>((ref) => 'Option 1');

class TenantPage extends HookConsumerWidget {
  const TenantPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // watch to update UI when the value changes
    final sliderValue = ref.watch(sliderValueProvider);
    final switchValue = ref.watch(switchValueProvider);
    final dropdownValue = ref.watch(dropdownValueProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tenant setting'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            // slider
            ListTile(
              title: const Text('Adjust Value'),
              subtitle: Slider(
                value: sliderValue,
                // min: 0,
                max: 100,
                divisions: 20,
                label: sliderValue.round().toString(),
                onChanged: (value) => ref.read(sliderValueProvider.notifier).state = value,
              ),
            ),
            const SizedBox(height: 20),

            // switch
            SwitchListTile(
              title: const Text('Enable Feature'),
              value: switchValue,
              onChanged: (value) => ref.read(switchValueProvider.notifier).state = value,
            ),
            const SizedBox(height: 20),

            // drop down
            ListTile(
              title: const Text('Choose Option'),
              trailing: DropdownButton<String>(
                value: dropdownValue,
                items: const [
                  DropdownMenuItem(value: 'Option 1', child: Text('Option 1')),
                  DropdownMenuItem(value: 'Option 2', child: Text('Option 2')),
                  DropdownMenuItem(value: 'Option 3', child: Text('Option 3')),
                ],
                onChanged: (value) {
                  if (value != null) {
                    ref.read(dropdownValueProvider.notifier).state = value;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
