import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:extremo/domain/usecase/artifact.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
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
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class ArtifactDetailPage extends StatelessWidget {
  const ArtifactDetailPage({required this.id, super.key});

  final int id;

  @override
  Widget build(BuildContext context) => Scaffold(appBar: AppBar(), body: _ArtifactDetailView(id: id));
}

class _ArtifactDetailView extends HookConsumerWidget {
  const _ArtifactDetailView({required this.id});

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final detail = ref.watch(getArtifactCaseProvider(id));
    final value = detail.valueOrNull;

    if (detail.error != null) {
      return ErrorView(text: t.networkError);
    }
    if (value == null) {
      return const ProgressView();
    }
    final data = value.getOrNull();
    if (data == null) {
      return const ProgressView();
    }

    return Column(
      children: [
        const Gap(8),
        Center(
          child: Container(
            width: 256,
            height: 256,
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: CachedNetworkImage(
              imageUrl: 'https://placehold.co/300x200/png', // data.imageUrl,
              width: 240,
              height: 240,
              fit: BoxFit.fitHeight,
              placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) => const Center(
                child: Icon(Icons.error_outline, size: 64, color: Colors.red),
              ),
            ),
          ),
        ),
        const Gap(8),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                data.title,
                style: Theme.of(context).textTheme.displayMedium?.copyWith(color: Colors.black),
              ),
              // FavoriteButton(
              //   isFavorite: data.isFavorite,
              //   onPressedFavorite: () {
              //     ref.read(ToggleFavoriteArtifactByIdCaseProvider(id));
              //   },
              // )
            ],
          ),
        ),
        const Gap(8),
        const Gap(8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.height(height: 200 /*data.height*/),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            ),
            Text(
              t.weight(weight: 300 /*data.weight*/),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
            ),
          ],
        ),
        const Gap(8),
        Text(
          data.content,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
