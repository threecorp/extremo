// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extremo.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dbListExtremoUsersByIdsHash() =>
    r'd35dae25a1f4b614cce7267a3ffee818c3040f0b';

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

/// See also [dbListExtremoUsersByIds].
@ProviderFor(dbListExtremoUsersByIds)
const dbListExtremoUsersByIdsProvider = DbListExtremoUsersByIdsFamily();

/// See also [dbListExtremoUsersByIds].
class DbListExtremoUsersByIdsFamily
    extends Family<AsyncValue<List<ExtremoUserEntity>>> {
  /// See also [dbListExtremoUsersByIds].
  const DbListExtremoUsersByIdsFamily();

  /// See also [dbListExtremoUsersByIds].
  DbListExtremoUsersByIdsProvider call(
    List<int> ids,
  ) {
    return DbListExtremoUsersByIdsProvider(
      ids,
    );
  }

  @override
  DbListExtremoUsersByIdsProvider getProviderOverride(
    covariant DbListExtremoUsersByIdsProvider provider,
  ) {
    return call(
      provider.ids,
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
  String? get name => r'dbListExtremoUsersByIdsProvider';
}

/// See also [dbListExtremoUsersByIds].
class DbListExtremoUsersByIdsProvider
    extends AutoDisposeFutureProvider<List<ExtremoUserEntity>> {
  /// See also [dbListExtremoUsersByIds].
  DbListExtremoUsersByIdsProvider(
    List<int> ids,
  ) : this._internal(
          (ref) => dbListExtremoUsersByIds(
            ref as DbListExtremoUsersByIdsRef,
            ids,
          ),
          from: dbListExtremoUsersByIdsProvider,
          name: r'dbListExtremoUsersByIdsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dbListExtremoUsersByIdsHash,
          dependencies: DbListExtremoUsersByIdsFamily._dependencies,
          allTransitiveDependencies:
              DbListExtremoUsersByIdsFamily._allTransitiveDependencies,
          ids: ids,
        );

  DbListExtremoUsersByIdsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.ids,
  }) : super.internal();

  final List<int> ids;

  @override
  Override overrideWith(
    FutureOr<List<ExtremoUserEntity>> Function(
            DbListExtremoUsersByIdsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DbListExtremoUsersByIdsProvider._internal(
        (ref) => create(ref as DbListExtremoUsersByIdsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        ids: ids,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ExtremoUserEntity>> createElement() {
    return _DbListExtremoUsersByIdsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DbListExtremoUsersByIdsProvider && other.ids == ids;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, ids.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin DbListExtremoUsersByIdsRef
    on AutoDisposeFutureProviderRef<List<ExtremoUserEntity>> {
  /// The parameter `ids` of this provider.
  List<int> get ids;
}

class _DbListExtremoUsersByIdsProviderElement
    extends AutoDisposeFutureProviderElement<List<ExtremoUserEntity>>
    with DbListExtremoUsersByIdsRef {
  _DbListExtremoUsersByIdsProviderElement(super.provider);

  @override
  List<int> get ids => (origin as DbListExtremoUsersByIdsProvider).ids;
}

String _$dbListPagerExtremoArtifactsHash() =>
    r'1e1a7f3e27554b31285b05cb8b582e9275e81bae';

/// See also [dbListPagerExtremoArtifacts].
@ProviderFor(dbListPagerExtremoArtifacts)
const dbListPagerExtremoArtifactsProvider = DbListPagerExtremoArtifactsFamily();

/// See also [dbListPagerExtremoArtifacts].
class DbListPagerExtremoArtifactsFamily
    extends Family<AsyncValue<PagingEntity<ExtremoArtifactEntity>>> {
  /// See also [dbListPagerExtremoArtifacts].
  const DbListPagerExtremoArtifactsFamily();

  /// See also [dbListPagerExtremoArtifacts].
  DbListPagerExtremoArtifactsProvider call(
    int page,
    int pageSize,
  ) {
    return DbListPagerExtremoArtifactsProvider(
      page,
      pageSize,
    );
  }

  @override
  DbListPagerExtremoArtifactsProvider getProviderOverride(
    covariant DbListPagerExtremoArtifactsProvider provider,
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
  String? get name => r'dbListPagerExtremoArtifactsProvider';
}

/// See also [dbListPagerExtremoArtifacts].
class DbListPagerExtremoArtifactsProvider
    extends AutoDisposeFutureProvider<PagingEntity<ExtremoArtifactEntity>> {
  /// See also [dbListPagerExtremoArtifacts].
  DbListPagerExtremoArtifactsProvider(
    int page,
    int pageSize,
  ) : this._internal(
          (ref) => dbListPagerExtremoArtifacts(
            ref as DbListPagerExtremoArtifactsRef,
            page,
            pageSize,
          ),
          from: dbListPagerExtremoArtifactsProvider,
          name: r'dbListPagerExtremoArtifactsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dbListPagerExtremoArtifactsHash,
          dependencies: DbListPagerExtremoArtifactsFamily._dependencies,
          allTransitiveDependencies:
              DbListPagerExtremoArtifactsFamily._allTransitiveDependencies,
          page: page,
          pageSize: pageSize,
        );

  DbListPagerExtremoArtifactsProvider._internal(
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
    FutureOr<PagingEntity<ExtremoArtifactEntity>> Function(
            DbListPagerExtremoArtifactsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: DbListPagerExtremoArtifactsProvider._internal(
        (ref) => create(ref as DbListPagerExtremoArtifactsRef),
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
  AutoDisposeFutureProviderElement<PagingEntity<ExtremoArtifactEntity>>
      createElement() {
    return _DbListPagerExtremoArtifactsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DbListPagerExtremoArtifactsProvider &&
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

mixin DbListPagerExtremoArtifactsRef
    on AutoDisposeFutureProviderRef<PagingEntity<ExtremoArtifactEntity>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `pageSize` of this provider.
  int get pageSize;
}

class _DbListPagerExtremoArtifactsProviderElement
    extends AutoDisposeFutureProviderElement<
        PagingEntity<ExtremoArtifactEntity>>
    with DbListPagerExtremoArtifactsRef {
  _DbListPagerExtremoArtifactsProviderElement(super.provider);

  @override
  int get page => (origin as DbListPagerExtremoArtifactsProvider).page;
  @override
  int get pageSize => (origin as DbListPagerExtremoArtifactsProvider).pageSize;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
