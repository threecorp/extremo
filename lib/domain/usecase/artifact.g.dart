// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'artifact.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$listArtifactsHash() => r'689fb35b4d40f86faaa2f7be24d308f35231dbb2';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [listArtifacts].
@ProviderFor(listArtifacts)
const listArtifactsProvider = ListArtifactsFamily();

/// See also [listArtifacts].
class ListArtifactsFamily extends Family<AsyncValue<List<ArtifactModel>>> {
  /// See also [listArtifacts].
  const ListArtifactsFamily();

  /// See also [listArtifacts].
  ListArtifactsProvider call({
    int page = 1,
    int pageSize = 25,
  }) {
    return ListArtifactsProvider(
      page: page,
      pageSize: pageSize,
    );
  }

  @override
  ListArtifactsProvider getProviderOverride(
    covariant ListArtifactsProvider provider,
  ) {
    return call(
      page: provider.page,
      pageSize: provider.pageSize,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'listArtifactsProvider';
}

/// See also [listArtifacts].
class ListArtifactsProvider
    extends AutoDisposeFutureProvider<List<ArtifactModel>> {
  /// See also [listArtifacts].
  ListArtifactsProvider({
    int page = 1,
    int pageSize = 25,
  }) : this._internal(
          (ref) => listArtifacts(
            ref as ListArtifactsRef,
            page: page,
            pageSize: pageSize,
          ),
          from: listArtifactsProvider,
          name: r'listArtifactsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$listArtifactsHash,
          dependencies: ListArtifactsFamily._dependencies,
          allTransitiveDependencies:
              ListArtifactsFamily._allTransitiveDependencies,
          page: page,
          pageSize: pageSize,
        );

  ListArtifactsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.pageSize,
  }) : super.internal();

  final int page;
  final int pageSize;

  @override
  Override overrideWith(
    FutureOr<List<ArtifactModel>> Function(ListArtifactsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ListArtifactsProvider._internal(
        (ref) => create(ref as ListArtifactsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        pageSize: pageSize,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ArtifactModel>> createElement() {
    return _ListArtifactsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ListArtifactsProvider &&
        other.page == page &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ListArtifactsRef on AutoDisposeFutureProviderRef<List<ArtifactModel>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `pageSize` of this provider.
  int get pageSize;
}

class _ListArtifactsProviderElement
    extends AutoDisposeFutureProviderElement<List<ArtifactModel>>
    with ListArtifactsRef {
  _ListArtifactsProviderElement(super.provider);

  @override
  int get page => (origin as ListArtifactsProvider).page;
  @override
  int get pageSize => (origin as ListArtifactsProvider).pageSize;
}

String _$artifactMapHash() => r'f87fe3d3a35dbed99a602d734280e49e3b3dae6d';

/// See also [artifactMap].
@ProviderFor(artifactMap)
const artifactMapProvider = ArtifactMapFamily();

/// See also [artifactMap].
class ArtifactMapFamily extends Family<AsyncValue<Map<int, ArtifactModel>>> {
  /// See also [artifactMap].
  const ArtifactMapFamily();

  /// See also [artifactMap].
  ArtifactMapProvider call(
    int page,
    int pageSize,
  ) {
    return ArtifactMapProvider(
      page,
      pageSize,
    );
  }

  @override
  ArtifactMapProvider getProviderOverride(
    covariant ArtifactMapProvider provider,
  ) {
    return call(
      provider.page,
      provider.pageSize,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'artifactMapProvider';
}

/// See also [artifactMap].
class ArtifactMapProvider
    extends AutoDisposeFutureProvider<Map<int, ArtifactModel>> {
  /// See also [artifactMap].
  ArtifactMapProvider(
    int page,
    int pageSize,
  ) : this._internal(
          (ref) => artifactMap(
            ref as ArtifactMapRef,
            page,
            pageSize,
          ),
          from: artifactMapProvider,
          name: r'artifactMapProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$artifactMapHash,
          dependencies: ArtifactMapFamily._dependencies,
          allTransitiveDependencies:
              ArtifactMapFamily._allTransitiveDependencies,
          page: page,
          pageSize: pageSize,
        );

  ArtifactMapProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.pageSize,
  }) : super.internal();

  final int page;
  final int pageSize;

  @override
  Override overrideWith(
    FutureOr<Map<int, ArtifactModel>> Function(ArtifactMapRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ArtifactMapProvider._internal(
        (ref) => create(ref as ArtifactMapRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        pageSize: pageSize,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<int, ArtifactModel>> createElement() {
    return _ArtifactMapProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArtifactMapProvider &&
        other.page == page &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ArtifactMapRef on AutoDisposeFutureProviderRef<Map<int, ArtifactModel>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `pageSize` of this provider.
  int get pageSize;
}

class _ArtifactMapProviderElement
    extends AutoDisposeFutureProviderElement<Map<int, ArtifactModel>>
    with ArtifactMapRef {
  _ArtifactMapProviderElement(super.provider);

  @override
  int get page => (origin as ArtifactMapProvider).page;
  @override
  int get pageSize => (origin as ArtifactMapProvider).pageSize;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
