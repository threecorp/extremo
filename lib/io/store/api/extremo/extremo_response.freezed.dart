// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'extremo_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ExtremoGetResponse<T> _$ExtremoGetResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _ExtremoGetResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ExtremoGetResponse<T> {
  T get element => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtremoGetResponseCopyWith<T, ExtremoGetResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtremoGetResponseCopyWith<T, $Res> {
  factory $ExtremoGetResponseCopyWith(ExtremoGetResponse<T> value,
          $Res Function(ExtremoGetResponse<T>) then) =
      _$ExtremoGetResponseCopyWithImpl<T, $Res, ExtremoGetResponse<T>>;
  @useResult
  $Res call({T element});
}

/// @nodoc
class _$ExtremoGetResponseCopyWithImpl<T, $Res,
        $Val extends ExtremoGetResponse<T>>
    implements $ExtremoGetResponseCopyWith<T, $Res> {
  _$ExtremoGetResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? element = freezed,
  }) {
    return _then(_value.copyWith(
      element: freezed == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as T,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtremoGetResponseImplCopyWith<T, $Res>
    implements $ExtremoGetResponseCopyWith<T, $Res> {
  factory _$$ExtremoGetResponseImplCopyWith(_$ExtremoGetResponseImpl<T> value,
          $Res Function(_$ExtremoGetResponseImpl<T>) then) =
      __$$ExtremoGetResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({T element});
}

/// @nodoc
class __$$ExtremoGetResponseImplCopyWithImpl<T, $Res>
    extends _$ExtremoGetResponseCopyWithImpl<T, $Res,
        _$ExtremoGetResponseImpl<T>>
    implements _$$ExtremoGetResponseImplCopyWith<T, $Res> {
  __$$ExtremoGetResponseImplCopyWithImpl(_$ExtremoGetResponseImpl<T> _value,
      $Res Function(_$ExtremoGetResponseImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? element = freezed,
  }) {
    return _then(_$ExtremoGetResponseImpl<T>(
      element: freezed == element
          ? _value.element
          : element // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ExtremoGetResponseImpl<T> implements _ExtremoGetResponse<T> {
  const _$ExtremoGetResponseImpl({required this.element});

  factory _$ExtremoGetResponseImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ExtremoGetResponseImplFromJson(json, fromJsonT);

  @override
  final T element;

  @override
  String toString() {
    return 'ExtremoGetResponse<$T>(element: $element)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtremoGetResponseImpl<T> &&
            const DeepCollectionEquality().equals(other.element, element));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(element));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtremoGetResponseImplCopyWith<T, _$ExtremoGetResponseImpl<T>>
      get copyWith => __$$ExtremoGetResponseImplCopyWithImpl<T,
          _$ExtremoGetResponseImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ExtremoGetResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _ExtremoGetResponse<T> implements ExtremoGetResponse<T> {
  const factory _ExtremoGetResponse({required final T element}) =
      _$ExtremoGetResponseImpl<T>;

  factory _ExtremoGetResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ExtremoGetResponseImpl<T>.fromJson;

  @override
  T get element;
  @override
  @JsonKey(ignore: true)
  _$$ExtremoGetResponseImplCopyWith<T, _$ExtremoGetResponseImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

ExtremoListResponse<T> _$ExtremoListResponseFromJson<T>(
    Map<String, dynamic> json, T Function(Object?) fromJsonT) {
  return _ExtremoListResponse<T>.fromJson(json, fromJsonT);
}

/// @nodoc
mixin _$ExtremoListResponse<T> {
  int get totalSize =>
      throw _privateConstructorUsedError; // TODO(next): String? next,
// TODO(previous): String? previous,
  List<T> get elements => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson(Object? Function(T) toJsonT) =>
      throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtremoListResponseCopyWith<T, ExtremoListResponse<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtremoListResponseCopyWith<T, $Res> {
  factory $ExtremoListResponseCopyWith(ExtremoListResponse<T> value,
          $Res Function(ExtremoListResponse<T>) then) =
      _$ExtremoListResponseCopyWithImpl<T, $Res, ExtremoListResponse<T>>;
  @useResult
  $Res call({int totalSize, List<T> elements});
}

/// @nodoc
class _$ExtremoListResponseCopyWithImpl<T, $Res,
        $Val extends ExtremoListResponse<T>>
    implements $ExtremoListResponseCopyWith<T, $Res> {
  _$ExtremoListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSize = null,
    Object? elements = null,
  }) {
    return _then(_value.copyWith(
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as int,
      elements: null == elements
          ? _value.elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtremoListResponseImplCopyWith<T, $Res>
    implements $ExtremoListResponseCopyWith<T, $Res> {
  factory _$$ExtremoListResponseImplCopyWith(_$ExtremoListResponseImpl<T> value,
          $Res Function(_$ExtremoListResponseImpl<T>) then) =
      __$$ExtremoListResponseImplCopyWithImpl<T, $Res>;
  @override
  @useResult
  $Res call({int totalSize, List<T> elements});
}

/// @nodoc
class __$$ExtremoListResponseImplCopyWithImpl<T, $Res>
    extends _$ExtremoListResponseCopyWithImpl<T, $Res,
        _$ExtremoListResponseImpl<T>>
    implements _$$ExtremoListResponseImplCopyWith<T, $Res> {
  __$$ExtremoListResponseImplCopyWithImpl(_$ExtremoListResponseImpl<T> _value,
      $Res Function(_$ExtremoListResponseImpl<T>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSize = null,
    Object? elements = null,
  }) {
    return _then(_$ExtremoListResponseImpl<T>(
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as int,
      elements: null == elements
          ? _value._elements
          : elements // ignore: cast_nullable_to_non_nullable
              as List<T>,
    ));
  }
}

/// @nodoc
@JsonSerializable(genericArgumentFactories: true)
class _$ExtremoListResponseImpl<T> implements _ExtremoListResponse<T> {
  const _$ExtremoListResponseImpl(
      {required this.totalSize, required final List<T> elements})
      : _elements = elements;

  factory _$ExtremoListResponseImpl.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =>
      _$$ExtremoListResponseImplFromJson(json, fromJsonT);

  @override
  final int totalSize;
// TODO(next): String? next,
// TODO(previous): String? previous,
  final List<T> _elements;
// TODO(next): String? next,
// TODO(previous): String? previous,
  @override
  List<T> get elements {
    if (_elements is EqualUnmodifiableListView) return _elements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_elements);
  }

  @override
  String toString() {
    return 'ExtremoListResponse<$T>(totalSize: $totalSize, elements: $elements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtremoListResponseImpl<T> &&
            (identical(other.totalSize, totalSize) ||
                other.totalSize == totalSize) &&
            const DeepCollectionEquality().equals(other._elements, _elements));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalSize, const DeepCollectionEquality().hash(_elements));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtremoListResponseImplCopyWith<T, _$ExtremoListResponseImpl<T>>
      get copyWith => __$$ExtremoListResponseImplCopyWithImpl<T,
          _$ExtremoListResponseImpl<T>>(this, _$identity);

  @override
  Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
    return _$$ExtremoListResponseImplToJson<T>(this, toJsonT);
  }
}

abstract class _ExtremoListResponse<T> implements ExtremoListResponse<T> {
  const factory _ExtremoListResponse(
      {required final int totalSize,
      required final List<T> elements}) = _$ExtremoListResponseImpl<T>;

  factory _ExtremoListResponse.fromJson(
          Map<String, dynamic> json, T Function(Object?) fromJsonT) =
      _$ExtremoListResponseImpl<T>.fromJson;

  @override
  int get totalSize;
  @override // TODO(next): String? next,
// TODO(previous): String? previous,
  List<T> get elements;
  @override
  @JsonKey(ignore: true)
  _$$ExtremoListResponseImplCopyWith<T, _$ExtremoListResponseImpl<T>>
      get copyWith => throw _privateConstructorUsedError;
}

ExtremoArtifact _$ExtremoArtifactFromJson(Map<String, dynamic> json) {
  return _ExtremoArtifact.fromJson(json);
}

/// @nodoc
mixin _$ExtremoArtifact {
  int get pk => throw _privateConstructorUsedError;
  int get userFk => throw _privateConstructorUsedError;
  ExtremoUser get user => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get summary => throw _privateConstructorUsedError;
  String get status => throw _privateConstructorUsedError; // TODO: Enum Type
  @DateTimeConverter()
  DateTime? get publishFrom => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get publishUntil => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtremoArtifactCopyWith<ExtremoArtifact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtremoArtifactCopyWith<$Res> {
  factory $ExtremoArtifactCopyWith(
          ExtremoArtifact value, $Res Function(ExtremoArtifact) then) =
      _$ExtremoArtifactCopyWithImpl<$Res, ExtremoArtifact>;
  @useResult
  $Res call(
      {int pk,
      int userFk,
      ExtremoUser user,
      String title,
      String content,
      String summary,
      String status,
      @DateTimeConverter() DateTime? publishFrom,
      @DateTimeConverter() DateTime? publishUntil,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime updatedAt});

  $ExtremoUserCopyWith<$Res> get user;
}

/// @nodoc
class _$ExtremoArtifactCopyWithImpl<$Res, $Val extends ExtremoArtifact>
    implements $ExtremoArtifactCopyWith<$Res> {
  _$ExtremoArtifactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pk = null,
    Object? userFk = null,
    Object? user = null,
    Object? title = null,
    Object? content = null,
    Object? summary = null,
    Object? status = null,
    Object? publishFrom = freezed,
    Object? publishUntil = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      pk: null == pk
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int,
      userFk: null == userFk
          ? _value.userFk
          : userFk // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ExtremoUser,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      publishFrom: freezed == publishFrom
          ? _value.publishFrom
          : publishFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      publishUntil: freezed == publishUntil
          ? _value.publishUntil
          : publishUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ExtremoUserCopyWith<$Res> get user {
    return $ExtremoUserCopyWith<$Res>(_value.user, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ExtremoArtifactImplCopyWith<$Res>
    implements $ExtremoArtifactCopyWith<$Res> {
  factory _$$ExtremoArtifactImplCopyWith(_$ExtremoArtifactImpl value,
          $Res Function(_$ExtremoArtifactImpl) then) =
      __$$ExtremoArtifactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int pk,
      int userFk,
      ExtremoUser user,
      String title,
      String content,
      String summary,
      String status,
      @DateTimeConverter() DateTime? publishFrom,
      @DateTimeConverter() DateTime? publishUntil,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime updatedAt});

  @override
  $ExtremoUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$ExtremoArtifactImplCopyWithImpl<$Res>
    extends _$ExtremoArtifactCopyWithImpl<$Res, _$ExtremoArtifactImpl>
    implements _$$ExtremoArtifactImplCopyWith<$Res> {
  __$$ExtremoArtifactImplCopyWithImpl(
      _$ExtremoArtifactImpl _value, $Res Function(_$ExtremoArtifactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pk = null,
    Object? userFk = null,
    Object? user = null,
    Object? title = null,
    Object? content = null,
    Object? summary = null,
    Object? status = null,
    Object? publishFrom = freezed,
    Object? publishUntil = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ExtremoArtifactImpl(
      pk: null == pk
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int,
      userFk: null == userFk
          ? _value.userFk
          : userFk // ignore: cast_nullable_to_non_nullable
              as int,
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ExtremoUser,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      summary: null == summary
          ? _value.summary
          : summary // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String,
      publishFrom: freezed == publishFrom
          ? _value.publishFrom
          : publishFrom // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      publishUntil: freezed == publishUntil
          ? _value.publishUntil
          : publishUntil // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtremoArtifactImpl implements _ExtremoArtifact {
  const _$ExtremoArtifactImpl(
      {required this.pk,
      required this.userFk,
      required this.user,
      required this.title,
      required this.content,
      required this.summary,
      required this.status,
      @DateTimeConverter() this.publishFrom,
      @DateTimeConverter() this.publishUntil,
      @DateTimeConverter() required this.createdAt,
      @DateTimeConverter() required this.updatedAt});

  factory _$ExtremoArtifactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtremoArtifactImplFromJson(json);

  @override
  final int pk;
  @override
  final int userFk;
  @override
  final ExtremoUser user;
  @override
  final String title;
  @override
  final String content;
  @override
  final String summary;
  @override
  final String status;
// TODO: Enum Type
  @override
  @DateTimeConverter()
  final DateTime? publishFrom;
  @override
  @DateTimeConverter()
  final DateTime? publishUntil;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  @DateTimeConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ExtremoArtifact(pk: $pk, userFk: $userFk, user: $user, title: $title, content: $content, summary: $summary, status: $status, publishFrom: $publishFrom, publishUntil: $publishUntil, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtremoArtifactImpl &&
            (identical(other.pk, pk) || other.pk == pk) &&
            (identical(other.userFk, userFk) || other.userFk == userFk) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.summary, summary) || other.summary == summary) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.publishFrom, publishFrom) ||
                other.publishFrom == publishFrom) &&
            (identical(other.publishUntil, publishUntil) ||
                other.publishUntil == publishUntil) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pk, userFk, user, title, content,
      summary, status, publishFrom, publishUntil, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtremoArtifactImplCopyWith<_$ExtremoArtifactImpl> get copyWith =>
      __$$ExtremoArtifactImplCopyWithImpl<_$ExtremoArtifactImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtremoArtifactImplToJson(
      this,
    );
  }
}

abstract class _ExtremoArtifact implements ExtremoArtifact {
  const factory _ExtremoArtifact(
          {required final int pk,
          required final int userFk,
          required final ExtremoUser user,
          required final String title,
          required final String content,
          required final String summary,
          required final String status,
          @DateTimeConverter() final DateTime? publishFrom,
          @DateTimeConverter() final DateTime? publishUntil,
          @DateTimeConverter() required final DateTime createdAt,
          @DateTimeConverter() required final DateTime updatedAt}) =
      _$ExtremoArtifactImpl;

  factory _ExtremoArtifact.fromJson(Map<String, dynamic> json) =
      _$ExtremoArtifactImpl.fromJson;

  @override
  int get pk;
  @override
  int get userFk;
  @override
  ExtremoUser get user;
  @override
  String get title;
  @override
  String get content;
  @override
  String get summary;
  @override
  String get status;
  @override // TODO: Enum Type
  @DateTimeConverter()
  DateTime? get publishFrom;
  @override
  @DateTimeConverter()
  DateTime? get publishUntil;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @DateTimeConverter()
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ExtremoArtifactImplCopyWith<_$ExtremoArtifactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExtremoUser _$ExtremoUserFromJson(Map<String, dynamic> json) {
  return _ExtremoUser.fromJson(json);
}

/// @nodoc
mixin _$ExtremoUser {
  int get pk => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get password => throw _privateConstructorUsedError;
  bool get isDeleted => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get deletedAt => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime? get dateJoined => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;
  @DateTimeConverter()
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtremoUserCopyWith<ExtremoUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtremoUserCopyWith<$Res> {
  factory $ExtremoUserCopyWith(
          ExtremoUser value, $Res Function(ExtremoUser) then) =
      _$ExtremoUserCopyWithImpl<$Res, ExtremoUser>;
  @useResult
  $Res call(
      {int pk,
      String? email,
      String? password,
      bool isDeleted,
      @DateTimeConverter() DateTime? deletedAt,
      @DateTimeConverter() DateTime? dateJoined,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime updatedAt});
}

/// @nodoc
class _$ExtremoUserCopyWithImpl<$Res, $Val extends ExtremoUser>
    implements $ExtremoUserCopyWith<$Res> {
  _$ExtremoUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pk = null,
    Object? email = freezed,
    Object? password = freezed,
    Object? isDeleted = null,
    Object? deletedAt = freezed,
    Object? dateJoined = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      pk: null == pk
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateJoined: freezed == dateJoined
          ? _value.dateJoined
          : dateJoined // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtremoUserImplCopyWith<$Res>
    implements $ExtremoUserCopyWith<$Res> {
  factory _$$ExtremoUserImplCopyWith(
          _$ExtremoUserImpl value, $Res Function(_$ExtremoUserImpl) then) =
      __$$ExtremoUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int pk,
      String? email,
      String? password,
      bool isDeleted,
      @DateTimeConverter() DateTime? deletedAt,
      @DateTimeConverter() DateTime? dateJoined,
      @DateTimeConverter() DateTime createdAt,
      @DateTimeConverter() DateTime updatedAt});
}

/// @nodoc
class __$$ExtremoUserImplCopyWithImpl<$Res>
    extends _$ExtremoUserCopyWithImpl<$Res, _$ExtremoUserImpl>
    implements _$$ExtremoUserImplCopyWith<$Res> {
  __$$ExtremoUserImplCopyWithImpl(
      _$ExtremoUserImpl _value, $Res Function(_$ExtremoUserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? pk = null,
    Object? email = freezed,
    Object? password = freezed,
    Object? isDeleted = null,
    Object? deletedAt = freezed,
    Object? dateJoined = freezed,
    Object? createdAt = null,
    Object? updatedAt = null,
  }) {
    return _then(_$ExtremoUserImpl(
      pk: null == pk
          ? _value.pk
          : pk // ignore: cast_nullable_to_non_nullable
              as int,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      password: freezed == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String?,
      isDeleted: null == isDeleted
          ? _value.isDeleted
          : isDeleted // ignore: cast_nullable_to_non_nullable
              as bool,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      dateJoined: freezed == dateJoined
          ? _value.dateJoined
          : dateJoined // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtremoUserImpl implements _ExtremoUser {
  const _$ExtremoUserImpl(
      {required this.pk,
      this.email,
      this.password,
      required this.isDeleted,
      @DateTimeConverter() this.deletedAt,
      @DateTimeConverter() this.dateJoined,
      @DateTimeConverter() required this.createdAt,
      @DateTimeConverter() required this.updatedAt});

  factory _$ExtremoUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtremoUserImplFromJson(json);

  @override
  final int pk;
  @override
  final String? email;
  @override
  final String? password;
  @override
  final bool isDeleted;
  @override
  @DateTimeConverter()
  final DateTime? deletedAt;
  @override
  @DateTimeConverter()
  final DateTime? dateJoined;
  @override
  @DateTimeConverter()
  final DateTime createdAt;
  @override
  @DateTimeConverter()
  final DateTime updatedAt;

  @override
  String toString() {
    return 'ExtremoUser(pk: $pk, email: $email, password: $password, isDeleted: $isDeleted, deletedAt: $deletedAt, dateJoined: $dateJoined, createdAt: $createdAt, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtremoUserImpl &&
            (identical(other.pk, pk) || other.pk == pk) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password) &&
            (identical(other.isDeleted, isDeleted) ||
                other.isDeleted == isDeleted) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.dateJoined, dateJoined) ||
                other.dateJoined == dateJoined) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, pk, email, password, isDeleted,
      deletedAt, dateJoined, createdAt, updatedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtremoUserImplCopyWith<_$ExtremoUserImpl> get copyWith =>
      __$$ExtremoUserImplCopyWithImpl<_$ExtremoUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtremoUserImplToJson(
      this,
    );
  }
}

abstract class _ExtremoUser implements ExtremoUser {
  const factory _ExtremoUser(
          {required final int pk,
          final String? email,
          final String? password,
          required final bool isDeleted,
          @DateTimeConverter() final DateTime? deletedAt,
          @DateTimeConverter() final DateTime? dateJoined,
          @DateTimeConverter() required final DateTime createdAt,
          @DateTimeConverter() required final DateTime updatedAt}) =
      _$ExtremoUserImpl;

  factory _ExtremoUser.fromJson(Map<String, dynamic> json) =
      _$ExtremoUserImpl.fromJson;

  @override
  int get pk;
  @override
  String? get email;
  @override
  String? get password;
  @override
  bool get isDeleted;
  @override
  @DateTimeConverter()
  DateTime? get deletedAt;
  @override
  @DateTimeConverter()
  DateTime? get dateJoined;
  @override
  @DateTimeConverter()
  DateTime get createdAt;
  @override
  @DateTimeConverter()
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$ExtremoUserImplCopyWith<_$ExtremoUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
