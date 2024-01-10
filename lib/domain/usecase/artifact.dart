import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// import './util.dart';

part 'artifact.g.dart';

// TODO: Transform to Class base

// int pageSize = 25;
// final artifactsSizeProvider = StateProvider((_) => limit);
// final isArtifactsLastProvider = StateProvider.autoDispose<bool>((_) => false);

// @riverpod
// Function loadListNextPage(LoadListNextPageRef ref) => () =>
//     ref.read(artifactsSizeProvider.notifier).update((state) => state + limit);

@riverpod
Future<List<ArtifactModel>> listArtifacts(
  ListArtifactsRef ref, {
  int page = 1,
  int pageSize = 25,
}) async {
  final pager = await ref.read(
    dbListPagerExtremoArtifactsProvider(page, pageSize).future,
  );

  final models = pager.elements.map(
    (entity) => ArtifactModel.fromEntity(entity: entity),
  );

  // final artifactsSize = ref.watch(artifactsSizeProvider);
  // final artifactMap = await ref.watch(
  //   artifactMapProvider(page, pageSize).future,
  // );

  // final rr = [/*...cache, */ ...artifactMap.values]
  //     .sorted((lhs, rhs) => lhs.id.compareTo(rhs.id));
  // ref
  //     .read(isArtifactsLastProvider.notifier)
  //     .update((state) => rr.length < artifactsSize);
  return models.toList();
}

// @riverpod
// Future<ArtifactModel> getArtifact(GetArtifactRef ref, int id) async {
//   final artifactMap = await ref.watch(artifactMapProvider([id]).future);
//   return artifactMap.values.first;
// }

@riverpod
Future<Map<int, ArtifactModel>> artifactMap(
  ArtifactMapRef ref,
  int page,
  int pageSize,
) async {
  final pager = await ref.read(
    dbListPagerExtremoArtifactsProvider(page, pageSize).future,
  );
  // final favoriteMap =
  // await ref.watch(dbStreamFavoriteArtifactProvider.future);

  final artifactMap = Map.fromEntries(
    pager.elements.map((entity) {
      final artifact = ArtifactModel.fromEntity(
        entity: entity,
        // isFavorite: favoriteMap[entity.id] ?? false,
      );
      return MapEntry(artifact.id, artifact);
    }),
  );

  // ref.read(_pokedexCacheProvider.notifier).update((state)
  //    => {...state, ...artifactMap});
  return artifactMap;
}
