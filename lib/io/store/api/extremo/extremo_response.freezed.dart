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

ExtremoGetResponse _$ExtremoGetResponseFromJson(Map<String, dynamic> json) {
  return _ExtremoGetResponse.fromJson(json);
}

/// @nodoc
mixin _$ExtremoGetResponse {
  ExtremoUser get user => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtremoGetResponseCopyWith<ExtremoGetResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtremoGetResponseCopyWith<$Res> {
  factory $ExtremoGetResponseCopyWith(
          ExtremoGetResponse value, $Res Function(ExtremoGetResponse) then) =
      _$ExtremoGetResponseCopyWithImpl<$Res, ExtremoGetResponse>;
  @useResult
  $Res call({ExtremoUser user});

  $ExtremoUserCopyWith<$Res> get user;
}

/// @nodoc
class _$ExtremoGetResponseCopyWithImpl<$Res, $Val extends ExtremoGetResponse>
    implements $ExtremoGetResponseCopyWith<$Res> {
  _$ExtremoGetResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_value.copyWith(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ExtremoUser,
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
abstract class _$$ExtremoGetResponseImplCopyWith<$Res>
    implements $ExtremoGetResponseCopyWith<$Res> {
  factory _$$ExtremoGetResponseImplCopyWith(_$ExtremoGetResponseImpl value,
          $Res Function(_$ExtremoGetResponseImpl) then) =
      __$$ExtremoGetResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ExtremoUser user});

  @override
  $ExtremoUserCopyWith<$Res> get user;
}

/// @nodoc
class __$$ExtremoGetResponseImplCopyWithImpl<$Res>
    extends _$ExtremoGetResponseCopyWithImpl<$Res, _$ExtremoGetResponseImpl>
    implements _$$ExtremoGetResponseImplCopyWith<$Res> {
  __$$ExtremoGetResponseImplCopyWithImpl(_$ExtremoGetResponseImpl _value,
      $Res Function(_$ExtremoGetResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user = null,
  }) {
    return _then(_$ExtremoGetResponseImpl(
      user: null == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as ExtremoUser,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtremoGetResponseImpl implements _ExtremoGetResponse {
  const _$ExtremoGetResponseImpl({required this.user});

  factory _$ExtremoGetResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtremoGetResponseImplFromJson(json);

  @override
  final ExtremoUser user;

  @override
  String toString() {
    return 'ExtremoGetResponse(user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtremoGetResponseImpl &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtremoGetResponseImplCopyWith<_$ExtremoGetResponseImpl> get copyWith =>
      __$$ExtremoGetResponseImplCopyWithImpl<_$ExtremoGetResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtremoGetResponseImplToJson(
      this,
    );
  }
}

abstract class _ExtremoGetResponse implements ExtremoGetResponse {
  const factory _ExtremoGetResponse({required final ExtremoUser user}) =
      _$ExtremoGetResponseImpl;

  factory _ExtremoGetResponse.fromJson(Map<String, dynamic> json) =
      _$ExtremoGetResponseImpl.fromJson;

  @override
  ExtremoUser get user;
  @override
  @JsonKey(ignore: true)
  _$$ExtremoGetResponseImplCopyWith<_$ExtremoGetResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ExtremoListResponse _$ExtremoListResponseFromJson(Map<String, dynamic> json) {
  return _ExtremoListResponse.fromJson(json);
}

/// @nodoc
mixin _$ExtremoListResponse {
  int get totalSize =>
      throw _privateConstructorUsedError; // TODO(next): String? next,
// TODO(previous): String? previous,
  List<ExtremoUser> get users => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ExtremoListResponseCopyWith<ExtremoListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ExtremoListResponseCopyWith<$Res> {
  factory $ExtremoListResponseCopyWith(
          ExtremoListResponse value, $Res Function(ExtremoListResponse) then) =
      _$ExtremoListResponseCopyWithImpl<$Res, ExtremoListResponse>;
  @useResult
  $Res call({int totalSize, List<ExtremoUser> users});
}

/// @nodoc
class _$ExtremoListResponseCopyWithImpl<$Res, $Val extends ExtremoListResponse>
    implements $ExtremoListResponseCopyWith<$Res> {
  _$ExtremoListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSize = null,
    Object? users = null,
  }) {
    return _then(_value.copyWith(
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as int,
      users: null == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as List<ExtremoUser>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ExtremoListResponseImplCopyWith<$Res>
    implements $ExtremoListResponseCopyWith<$Res> {
  factory _$$ExtremoListResponseImplCopyWith(_$ExtremoListResponseImpl value,
          $Res Function(_$ExtremoListResponseImpl) then) =
      __$$ExtremoListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int totalSize, List<ExtremoUser> users});
}

/// @nodoc
class __$$ExtremoListResponseImplCopyWithImpl<$Res>
    extends _$ExtremoListResponseCopyWithImpl<$Res, _$ExtremoListResponseImpl>
    implements _$$ExtremoListResponseImplCopyWith<$Res> {
  __$$ExtremoListResponseImplCopyWithImpl(_$ExtremoListResponseImpl _value,
      $Res Function(_$ExtremoListResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalSize = null,
    Object? users = null,
  }) {
    return _then(_$ExtremoListResponseImpl(
      totalSize: null == totalSize
          ? _value.totalSize
          : totalSize // ignore: cast_nullable_to_non_nullable
              as int,
      users: null == users
          ? _value._users
          : users // ignore: cast_nullable_to_non_nullable
              as List<ExtremoUser>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ExtremoListResponseImpl implements _ExtremoListResponse {
  const _$ExtremoListResponseImpl(
      {required this.totalSize, required final List<ExtremoUser> users})
      : _users = users;

  factory _$ExtremoListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$ExtremoListResponseImplFromJson(json);

  @override
  final int totalSize;
// TODO(next): String? next,
// TODO(previous): String? previous,
  final List<ExtremoUser> _users;
// TODO(next): String? next,
// TODO(previous): String? previous,
  @override
  List<ExtremoUser> get users {
    if (_users is EqualUnmodifiableListView) return _users;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_users);
  }

  @override
  String toString() {
    return 'ExtremoListResponse(totalSize: $totalSize, users: $users)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ExtremoListResponseImpl &&
            (identical(other.totalSize, totalSize) ||
                other.totalSize == totalSize) &&
            const DeepCollectionEquality().equals(other._users, _users));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, totalSize, const DeepCollectionEquality().hash(_users));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ExtremoListResponseImplCopyWith<_$ExtremoListResponseImpl> get copyWith =>
      __$$ExtremoListResponseImplCopyWithImpl<_$ExtremoListResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ExtremoListResponseImplToJson(
      this,
    );
  }
}

abstract class _ExtremoListResponse implements ExtremoListResponse {
  const factory _ExtremoListResponse(
      {required final int totalSize,
      required final List<ExtremoUser> users}) = _$ExtremoListResponseImpl;

  factory _ExtremoListResponse.fromJson(Map<String, dynamic> json) =
      _$ExtremoListResponseImpl.fromJson;

  @override
  int get totalSize;
  @override // TODO(next): String? next,
// TODO(previous): String? previous,
  List<ExtremoUser> get users;
  @override
  @JsonKey(ignore: true)
  _$$ExtremoListResponseImplCopyWith<_$ExtremoListResponseImpl> get copyWith =>
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
