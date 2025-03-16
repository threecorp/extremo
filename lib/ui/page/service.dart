// import 'package:extremo/domain/model/extremo.dart';
// import 'package:extremo/domain/usecase/artifact.dart';
// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/service.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/misc/logger.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/layout/error_view.dart';
import 'package:extremo/ui/layout/paging_controller.dart';
import 'package:extremo/ui/layout/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class ServicePage extends HookConsumerWidget {
  const ServicePage({
    super.key,
    this.onTapAction,
    this.isModal = false,
  });

  final void Function(ServiceModel)? onTapAction;
  final bool isModal;
  static const _pageSize = 25;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final serviceUseCase = ref.watch(serviceUseCaseProvider);

    final pagingController = useState(
      PagingController<int, ServiceModel>(firstPageKey: 1),
    );

    useEffect(
      () {
        pagingController.value.addPageRequestListener((pageKey) async {
          try {
            final services = await serviceUseCase.fetchServicePage(
              pageKey: pageKey,
              pageSize: _pageSize,
            );

            final isLastPage = services.length < _pageSize;
            if (isLastPage) {
              pagingController.value.appendLastPage(services);
            } else {
              final nextPageKey = pageKey + 1;
              pagingController.value.appendPage(services, nextPageKey);
            }
          } on Object catch (error, st) {
            logger.e('Failed to load page: $error st $st');
            // call newPageErrorIndicatorBuilder when error occurred
            pagingController.value.error = error;
          }
        });

        // discard the controller when the widget is disposed
        return () {
          pagingController.value.dispose();
        };
      },
      [pagingController.value],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Page'),
      ),
      body: PagedListView<int, ServiceModel>(
        pagingController: pagingController.value,
        builderDelegate: PagedChildBuilderDelegate<ServiceModel>(
          // リストの各Itemを描画
          itemBuilder: (context, service, index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://placehold.co/300x200/png'),
              ),
              title: Text('${service.pk}: ${service.name}'),
              subtitle: const Text('status'),
              onTap: () {
                final action = onTapAction;
                if (action != null) {
                  action(service);
                  return;
                }
                final pk = service.pk;
                if (pk != null) {
                  // TODO(unimpl): ServiceDetailRoute(id: pk).go(context);
                  return;
                }

                const sb = SnackBar(content: Text('Service ID is null'));
                ScaffoldMessenger.of(context).showSnackBar(sb);
              },
            );
          },
          // the first page loading indicator
          firstPageProgressIndicatorBuilder: (context) {
            return const Center(child: CircularProgressIndicator());
          },
          // the second page loading indicator
          newPageProgressIndicatorBuilder: (context) {
            return const Center(child: CircularProgressIndicator());
          },
          // when error occurred on the first page
          firstPageErrorIndicatorBuilder: (context) {
            return const Center(child: Text('Error loading data.'));
          },
          // when error occurred on the second page
          newPageErrorIndicatorBuilder: (context) {
            return const Center(child: Text('Error loading more data.'));
          },
          // when no items found
          noItemsFoundIndicatorBuilder: (context) {
            return const Center(child: Text('No services found.'));
          },
        ),
      ),
    );
  }
}
