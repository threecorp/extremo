import 'package:collection/collection.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/io/repo/extremo/mypage.dart';
import 'package:extremo/misc/result.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod/riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

// import './util.dart';

part 'artifact.g.dart';

// TODO(ClassBase): Transform to Class base

@riverpod
class ListPagerArtifacts extends _$ListPagerArtifacts {
  int _page = 1; // TODO(Refactoring): Remove build by using state
  int _pageSize = 25;
  bool _isLast = false;

  void loadListNextPage() {
    _page++; // TODO(Refactoring): Remove build by using state
    build();
  }

  // ignore: use_setters_to_change_properties
  void setPageSize(int pageSize) {
    _pageSize = pageSize; // TODO(Refactoring): Remove build by using state
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

    // TODO(Unuse): pager.totalSize
    _isLast = pager.elements.length < _pageSize;

    final rr = models.toList();
    state = AsyncValue.data([...state.value ?? [], ...rr]);
    return rr;
  }
}

@riverpod
Future<Result<ArtifactModel>> getArtifact(GetArtifactRef ref, int id) async {
  final result = await ref.read(dbGetArtifactProvider(id).future);
  return result.map(
    success: (e) => Success(ArtifactModel.fromEntity(entity: e.value)),
    failure: (e) => Failure(e.error, e.stackTrace),
  );
}

@riverpod
Future<Result<ArtifactModel>> createArtifact(
  CreateArtifactRef ref,
  ArtifactModel model,
) async {
  final result = await ref.read(
    dbCreateArtifactProvider(model.toEntity()).future,
  );

  return result.map(
    success: (e) => Success(ArtifactModel.fromEntity(entity: e.value)),
    failure: (e) => Failure(e.error, e.stackTrace),
  );
}
//
//
//
