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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class HomePage extends HookConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artifacts = ref.watch(listArtifactsProvider());
    // final isLast = ref.watch(isArtifactsLastProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.appName)),
      // body: const Placeholder(),
      body: ArtifactView(
        list: artifacts.valueOrNull,
        isLast: true, // isLast,
        error: artifacts.error,
        loadMore: () =>
            null, // WidgetsBinding.instance.addPostFrameCallback(((_) => ref.read(loadListNextPageProvider)())),
        onTapListItem: (item) =>
            null, // ArtifactDetailRoute(id: item.id).go(context),
        onPressedFavorite: (item) =>
            null, // ref.read(toggleFavoriteArtifactByIdProvider(item.id)),
        refresh: () => null, // ref.refresh(listArtifactsProvider),
        emptyErrorMessage: t.emptyError,
      ),
    );
  }
}

class ArtifactView extends HookConsumerWidget {
  const ArtifactView({
    required this.list,
    required this.isLast,
    required this.error,
    required this.loadMore,
    required this.onTapListItem,
    required this.onPressedFavorite,
    required this.refresh,
    required this.emptyErrorMessage,
    this.enableRetryButton = true,
    super.key,
  });

  final List<ArtifactModel>? list;
  final bool? isLast;
  final dynamic error;
  final void Function() loadMore;
  final void Function(ArtifactModel item) onTapListItem;
  final void Function(ArtifactModel item) onPressedFavorite;
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
        builderDelegate: PagedChildBuilderDelegate<ArtifactModel>(
          itemBuilder: (context, item, index) => ArtifactItemView(
            data: item,
            onTapListItem: onTapListItem,
            onPressedFavorite: onPressedFavorite,
          ),
          firstPageErrorIndicatorBuilder: (_) => ErrorView(
            text: t.networkError,
            retry: refresh,
          ),
          newPageProgressIndicatorBuilder: (_) => const ProgressView(),
          noItemsFoundIndicatorBuilder: (_) => ErrorView(
            text: emptyErrorMessage,
            retry: refresh,
            enableRetryButton: enableRetryButton,
          ),
        ),
      ),
    );
  }
}

class ArtifactItemView extends StatelessWidget {
  const ArtifactItemView({
    required this.data,
    required this.onTapListItem,
    required this.onPressedFavorite,
    super.key,
  });

  final ArtifactModel data;
  final void Function(ArtifactModel item) onTapListItem;
  final void Function(ArtifactModel item) onPressedFavorite;

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
                const Gap(4),
                CachedNetworkImage(
                  imageUrl:
                      'https://placehold.co/300x200/png', // data.imageUrl,
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
                Expanded(
                  // flex: 1,
                  child: _ArtifactItemInfo(data: data),
                ),
                // FavoriteButton(
                //   isFavorite: data.isFavorite,
                //   onPressedFavorite: () {
                //     onPressedFavorite(data);
                //   },
                // ),
                const Gap(4),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ArtifactItemInfo extends StatelessWidget {
  const _ArtifactItemInfo({required this.data});

  final ArtifactModel data;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data.title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        // ArtifactTypeChips(types: data.types),
      ],
    );
  }
}
