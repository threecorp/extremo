// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:dio/dio.dart';
import 'package:extremo/domain/usecase/artifact.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/misc/result.dart';
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

class ArtifactPage extends HookConsumerWidget {
  const ArtifactPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final artifacts = ref.watch(listPagerArtifactsProvider);
    final notifier = ref.watch(listPagerArtifactsProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text(t.appName)),
      body: ArtifactView(
        list: artifacts.valueOrNull,
        isLast: notifier.isLast(),
        error: artifacts.error,
        loadMore: () {
          WidgetsBinding.instance.addPostFrameCallback(
            (callback) => notifier.loadListNextPage(),
          );
        },
        onTapListItem: (item) =>
            null, // ArtifactDetailRoute(id: item.id).go(context),
        onPressedFavorite: (item) =>
            null, // ref.read(toggleFavoriteArtifactByIdProvider(item.id)),
        refresh: () => ref.refresh(listPagerArtifactsProvider),
        emptyErrorMessage: t.emptyError,
      ),
      floatingActionButton: SpeedDial(
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: const IconThemeData(size: 22),
        curve: Curves.bounceIn,
        children: [
          // SpeedDialChild(
          //   child: const Icon(Icons.create),
          //   backgroundColor: Colors.blue,
          //   label: 'add something',
          //   onTap: () {
          //     PostRoute().go(context);
          //   },
          //   labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          // ),
          SpeedDialChild(
            child: const Icon(Icons.person_add),
            backgroundColor: Colors.lightBlueAccent,
            label: t.newPost,
            onTap: () => showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              builder: (context) => PostWindow(
                onSubmitted: (ArtifactModel model) async {
                  try {
                    // TODO(Refactoring): Unuse to ref.watch.
                    // XXX: https://github.com/rrousselGit/riverpod/discussions/1724#discussioncomment-3796657
                    final newModel = await ref.read(
                      createArtifactProvider(model).future,
                    );

                    debugPrint('model: $newModel');
                  } on DioException catch (error) {
                    debugPrint('error: ${error.message}');
                    return;
                  }

                  Navigator.of(context).pop();
                },
              ),
            ),
            labelStyle: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// TODO(Refactoring): Unuse to Scaffold to change another widget for AppBar.
class PostWindow extends HookConsumerWidget {
  const PostWindow({
    super.key,
    required this.onSubmitted,
  });

  final void Function(ArtifactModel model) onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: PostForm(onSubmitted: onSubmitted),
    );
  }
}

// TODO(Refactoring): An onPressed will be able to be set from outside.
class PostForm extends HookConsumerWidget {
  const PostForm({
    super.key,
    required this.onSubmitted,
  });

  final void Function(ArtifactModel model) onSubmitted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormBuilderState>.new);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: FormBuilder(
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
                FormBuilderValidators.maxWordsCount(2048),
              ]),
            ),
            FormBuilderTextField(
              name: 'content',
              decoration: InputDecoration(labelText: t.content),
              minLines: 3,
              maxLines: 10,
              validator: FormBuilderValidators.compose([
                FormBuilderValidators.maxWordsCount(2048 * 100),
              ]),
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
                  if (!(formKey.currentState?.saveAndValidate() ?? false)) {
                    return;
                  }
                  final value = formKey.currentState?.value;
                  debugPrint(value?.toString());
                  if (value == null) {
                    return;
                  }

                  // TODO(Refactoring): Marshal,Unmarshal Library(serializable)
                  onSubmitted(
                    ArtifactModel(
                      userFk: 1,
                      title: value['title'] as String,
                      summary: value['summary'] as String,
                      content: value['content'] as String,
                      status: 'DRAFT',
                      // status: value['status'],
                      // types: value['types'],
                      // imageUrl: value['imageUrl'],
                      // isFavorite: false,
                    ),
                  );
                },
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
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
