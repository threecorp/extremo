import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// import './util.dart';

part 'artifact.g.dart';

// TODO(ClassBase): Transform to Class base

// @riverpod
// Future<ArtifactModel> getArtifact(GetArtifactRef ref, int id) async {
//   final artifactMap = await ref.watch(dbGetArtifact(id).future);
//   return artifactMap.values.first;
// }

@riverpod
class ListPagerArtifacts extends _$ListPagerArtifacts {
  int _page = 1;
  int _pageSize = 25;
  bool _isLast = false;

  void loadListNextPage() {
    _page++;
    build();
  }

  // ignore: use_setters_to_change_properties
  void setPageSize(int pageSize) {
    _pageSize = pageSize;
  }

  bool isLast() {
    return _isLast;
  }

  @override
  Future<List<ArtifactModel>> build() async {
    final pager = await ref.read(
      dbListPagerArtifactsProvider(_page, _pageSize).future,
    );

    final models = pager.elements.map(
      (entity) => ArtifactModel.fromEntity(entity: entity),
    );

    // TODO: pager.totalSize
    _isLast = pager.elements.length < _pageSize;
    return models.toList();
  }
}
