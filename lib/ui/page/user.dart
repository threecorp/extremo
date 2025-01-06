// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
import 'package:extremo/misc/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/user.dart';
import 'package:collection/collection.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
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
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UserPage extends HookConsumerWidget {
  const UserPage({
    super.key,
    this.onTapAction,
  });

  final void Function(UserModel)? onTapAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Monitor current “asynchronous status of paged user list
    final pagerStateAsync = ref.watch(listPagerUsersCaseProvider);

    // Controller for infinite_scroll_pagination
    final pagingController = useState(
      PagingController<int, UserModel>(firstPageKey: 1),
    );

    // [Point] Because updating the provider during build will cause an error,
    // call refreshFirstPage “after the first frame is drawn” with addPostFrameCallback.
    useEffect(
      () {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          // Initial refresh if data not already available.
          final data = ref.read(listPagerUsersCaseProvider).asData?.value;
          if (data == null || data.items.isEmpty) {
            ref.read(listPagerUsersCaseProvider.notifier).refreshFirstPage();
          }
        });
        return null;
      },
      [],
    );

    // Processing when PagingController requests “load next page
    useEffect(
      () {
        pagingController.value.addPageRequestListener((pageKey) async {
          try {
            if (pageKey > 1) {
              await ref.read(listPagerUsersCaseProvider.notifier).loadNextPage();
            }

            final state = ref.read(listPagerUsersCaseProvider).asData?.value;
            if (state == null) {
              logger.d('effect: No data loaded yet');
              return;
            }

            // Extract only the part corresponding to pageKey
            final startIdx = (pageKey - 1) * state.pageSize;
            final endIdx = startIdx + state.pageSize;
            final newItems = state.items.sublist(startIdx, endIdx.clamp(0, state.items.length));

            if (state.isLast && pageKey >= state.page) {
              pagingController.value.appendLastPage(newItems);
            } else {
              pagingController.value.appendPage(newItems, pageKey + 1);
            }
          } catch (error, st) {
            pagingController.value.error = error;
          }
        });

        return pagingController.value.dispose;
      },
      [pagingController.value],
    );

    // PagingController can be updated as needed when the state of Riverpod changes, etc.
    // * For example, refreshing the PagingController when a user logs in again, etc.

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: pagerStateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (state) {
          // If items is empty, noItemsFoundIndicator is issued, etc.
          return PagedListView<int, UserModel>(
            pagingController: pagingController.value,
            builderDelegate: PagedChildBuilderDelegate<UserModel>(
              itemBuilder: (context, user, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://placehold.co/300x200/png'),
                  ),
                  title: Text('${user.pk}: ${user.profile?.name ?? ''}'),
                  subtitle: const Text('status'),
                  onTap: () {
                    if (onTapAction != null) {
                      onTapAction!(user);
                    } else {
                      // Sample: jump to detail page, etc.
                      const UserDetailRoute(id: 1).go(context);
                    }
                  },
                );
              },
              firstPageErrorIndicatorBuilder: (context) => const Center(child: Text('Error loading data.')),
              newPageErrorIndicatorBuilder: (context) => const Center(child: Text('Error loading more data.')),
              noItemsFoundIndicatorBuilder: (context) => const Center(child: Text('No users found.')),
            ),
          );
        },
      ),
    );
  }
}
