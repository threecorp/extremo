import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/message.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/misc/logger.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/layout/error_view.dart';
import 'package:extremo/ui/layout/paging_controller.dart';
import 'package:extremo/ui/layout/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class MessagePage extends HookConsumerWidget {
  const MessagePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userProvider = ref.watch(listPagerMessageUsersCaseProvider);
    final userNotifier = ref.watch(listPagerMessageUsersCaseProvider.notifier);
    // final accountNotifier = ref.watch(accountProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(t.appName)),
      body: MessageView(
        list: userProvider.valueOrNull,
        isLast: userNotifier.isLast,
        error: userProvider.error,
        loadMore: () {
          WidgetsBinding.instance.addPostFrameCallback(
            (callback) => userNotifier.loadListNextPage(),
          );
        },
        onTapListItem: (item) {
          final id = item.id;
          if (id == null) {
            const s = 'ID is not found';
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(s)),
            );
            return;
          }
          MessageDetailRoute(id: id).go(context);
        },
        refresh: () => ref.refresh(listPagerMessagesCaseProvider),
        emptyErrorMessage: t.emptyError,
      ),
    );
  }
}

class MessageView extends HookConsumerWidget {
  const MessageView({
    required this.list,
    required this.isLast,
    required this.error,
    required this.loadMore,
    required this.onTapListItem,
    required this.refresh,
    required this.emptyErrorMessage,
    this.enableRetryButton = true,
    super.key,
  });

  final List<UserModel>? list;
  final bool? isLast;
  final dynamic error;
  final void Function() loadMore;
  final void Function(UserModel item) onTapListItem;
  final void Function() refresh;
  final String emptyErrorMessage;
  final bool enableRetryButton;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pagingController = useStateLessPagingController(
      itemList: list,
      isLast: isLast,
      loadMore: loadMore,
      error: error,
    );

    return RefreshIndicator(
      onRefresh: () async {
        refresh();
      },
      child: PagedListView.separated(
        pagingController: pagingController,
        separatorBuilder: (context, index) => const Divider(),
        builderDelegate: PagedChildBuilderDelegate<UserModel>(
          itemBuilder: (context, item, index) => MessageItemView(
            data: item,
            onTapListItem: onTapListItem,
          ),
          firstPageErrorIndicatorBuilder: (context) => ErrorView(
            text: t.networkError,
            retry: refresh,
            error: error,
          ),
          newPageProgressIndicatorBuilder: (context) => const ProgressView(),
          noItemsFoundIndicatorBuilder: (context) => ErrorView(
            text: emptyErrorMessage,
            retry: refresh,
            enableRetryButton: enableRetryButton,
          ),
        ),
      ),
    );
  }
}

class MessageItemView extends StatelessWidget {
  const MessageItemView({
    required this.data,
    required this.onTapListItem,
    super.key,
  });

  final UserModel data;
  final void Function(UserModel item) onTapListItem;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        onTapListItem(data);
      },
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          child: IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  // flex: 1,
                  child: _MessageItemInfo(data: data),
                ),
                const Gap(4),
                CachedNetworkImage(
                  imageUrl: 'https://placehold.co/300x200/png', // data.imageUrl,
                  width: 128,
                  height: 128,
                  fit: BoxFit.fitHeight,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Colors.red,
                    ),
                  ),
                ),
                const Gap(4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MessageItemInfo extends StatelessWidget {
  const _MessageItemInfo({required this.data});

  final UserModel data;

  @override
  Widget build(BuildContext context) {
    // logger.d('MessageItemInfo: $data');

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.profile?.name ?? '',
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // MessageTypeChips(types: data.types),
      ],
    );
  }
}
