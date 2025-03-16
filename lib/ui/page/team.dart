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
import 'package:extremo/domain/usecase/team.dart';
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

class TeamPage extends HookConsumerWidget {
  const TeamPage({
    super.key,
    this.onTapAction,
    this.isModal = false,
  });

  final void Function(TeamModel)? onTapAction;
  final bool isModal;
  static const _pageSize = 25;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final teamUseCase = ref.watch(teamUseCaseProvider);

    final pagingController = useState(
      PagingController<int, TeamModel>(firstPageKey: 1),
    );

    useEffect(
      () {
        pagingController.value.addPageRequestListener((pageKey) async {
          try {
            final teams = await teamUseCase.fetchTeamPage(
              pageKey: pageKey,
              pageSize: _pageSize,
            );

            final isLastPage = teams.length < _pageSize;
            if (isLastPage) {
              pagingController.value.appendLastPage(teams);
            } else {
              final nextPageKey = pageKey + 1;
              pagingController.value.appendPage(teams, nextPageKey);
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
        title: const Text('Team Page'),
      ),
      body: PagedListView<int, TeamModel>(
        pagingController: pagingController.value,
        builderDelegate: PagedChildBuilderDelegate<TeamModel>(
          // リストの各Itemを描画
          itemBuilder: (context, team, index) {
            return ListTile(
              leading: const CircleAvatar(
                backgroundImage: NetworkImage('https://placehold.co/300x200/png'),
              ),
              title: Text('${team.pk}: ${team.name}'),
              subtitle: const Text('status'),
              onTap: () {
                final action = onTapAction;
                if (action != null) {
                  action(team);
                  return;
                }
                final pk = team.pk;
                if (pk != null) {
                  // TODO(unimpl): TeamDetailRoute(id: pk).go(context);
                  return;
                }

                const sb = SnackBar(content: Text('Team ID is null'));
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
            return const Center(child: Text('No teams found.'));
          },
        ),
      ),
    );
  }
}
