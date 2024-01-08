// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extremo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExtremoGetResponseImpl<T> _$$ExtremoGetResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      r'_$ExtremoGetResponseImpl',
      json,
      ($checkedConvert) {
        final val = _$ExtremoGetResponseImpl<T>(
          element: $checkedConvert('element', (v) => fromJsonT(v)),
        );
        return val;
      },
    );

const _$$ExtremoGetResponseImplFieldMap = <String, String>{
  'element': 'element',
};

// ignore: unused_element
abstract class _$$ExtremoGetResponseImplPerFieldToJson {
  // ignore: unused_element
  static Object? element<T>(
    T instance,
    Object? Function(T value) toJsonT,
  ) =>
      toJsonT(instance);
}

Map<String, dynamic> _$$ExtremoGetResponseImplToJson<T>(
  _$ExtremoGetResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'element': toJsonT(instance.element),
    };

_$ExtremoListResponseImpl<T> _$$ExtremoListResponseImplFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    $checkedCreate(
      r'_$ExtremoListResponseImpl',
      json,
      ($checkedConvert) {
        final val = _$ExtremoListResponseImpl<T>(
          totalSize: $checkedConvert('total_size', (v) => v as int),
          elements: $checkedConvert(
              'elements', (v) => (v as List<dynamic>).map(fromJsonT).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'totalSize': 'total_size'},
    );

const _$$ExtremoListResponseImplFieldMap = <String, String>{
  'totalSize': 'total_size',
  'elements': 'elements',
};

// ignore: unused_element
abstract class _$$ExtremoListResponseImplPerFieldToJson {
  // ignore: unused_element
  static Object? totalSize<T>(
    int instance,
    Object? Function(T value) toJsonT,
  ) =>
      instance;
  // ignore: unused_element
  static Object? elements<T>(
    List<T> instance,
    Object? Function(T value) toJsonT,
  ) =>
      instance.map(toJsonT).toList();
}

Map<String, dynamic> _$$ExtremoListResponseImplToJson<T>(
  _$ExtremoListResponseImpl<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'total_size': instance.totalSize,
      'elements': instance.elements.map(toJsonT).toList(),
    };

_$ExtremoArtifactImpl _$$ExtremoArtifactImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ExtremoArtifactImpl',
      json,
      ($checkedConvert) {
        final val = _$ExtremoArtifactImpl(
          pk: $checkedConvert('pk', (v) => v as int),
          userFk: $checkedConvert('user_fk', (v) => v as int),
          user: $checkedConvert(
              'user', (v) => ExtremoUser.fromJson(v as Map<String, dynamic>)),
          title: $checkedConvert('title', (v) => v as String),
          content: $checkedConvert('content', (v) => v as String),
          summary: $checkedConvert('summary', (v) => v as String),
          status: $checkedConvert('status', (v) => v as String),
          publishFrom: $checkedConvert(
              'publish_from',
              (v) => _$JsonConverterFromJson<String, DateTime>(
                  v, const DateTimeConverter().fromJson)),
          publishUntil: $checkedConvert(
              'publish_until',
              (v) => _$JsonConverterFromJson<String, DateTime>(
                  v, const DateTimeConverter().fromJson)),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeConverter().fromJson(v as String)),
          updatedAt: $checkedConvert('updated_at',
              (v) => const DateTimeConverter().fromJson(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'userFk': 'user_fk',
        'publishFrom': 'publish_from',
        'publishUntil': 'publish_until',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );

const _$$ExtremoArtifactImplFieldMap = <String, String>{
  'pk': 'pk',
  'userFk': 'user_fk',
  'user': 'user',
  'title': 'title',
  'content': 'content',
  'summary': 'summary',
  'status': 'status',
  'publishFrom': 'publish_from',
  'publishUntil': 'publish_until',
  'createdAt': 'created_at',
  'updatedAt': 'updated_at',
};

// ignore: unused_element
abstract class _$$ExtremoArtifactImplPerFieldToJson {
  // ignore: unused_element
  static Object? pk(int instance) => instance;
  // ignore: unused_element
  static Object? userFk(int instance) => instance;
  // ignore: unused_element
  static Object? user(ExtremoUser instance) => instance.toJson();
  // ignore: unused_element
  static Object? title(String instance) => instance;
  // ignore: unused_element
  static Object? content(String instance) => instance;
  // ignore: unused_element
  static Object? summary(String instance) => instance;
  // ignore: unused_element
  static Object? status(String instance) => instance;
  // ignore: unused_element
  static Object? publishFrom(DateTime? instance) =>
      _$JsonConverterToJson<String, DateTime>(
          instance, const DateTimeConverter().toJson);
  // ignore: unused_element
  static Object? publishUntil(DateTime? instance) =>
      _$JsonConverterToJson<String, DateTime>(
          instance, const DateTimeConverter().toJson);
  // ignore: unused_element
  static Object? createdAt(DateTime instance) =>
      const DateTimeConverter().toJson(instance);
  // ignore: unused_element
  static Object? updatedAt(DateTime instance) =>
      const DateTimeConverter().toJson(instance);
}

Map<String, dynamic> _$$ExtremoArtifactImplToJson(
        _$ExtremoArtifactImpl instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'user_fk': instance.userFk,
      'user': instance.user.toJson(),
      'title': instance.title,
      'content': instance.content,
      'summary': instance.summary,
      'status': instance.status,
      'publish_from': _$JsonConverterToJson<String, DateTime>(
          instance.publishFrom, const DateTimeConverter().toJson),
      'publish_until': _$JsonConverterToJson<String, DateTime>(
          instance.publishUntil, const DateTimeConverter().toJson),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'updated_at': const DateTimeConverter().toJson(instance.updatedAt),
    };

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);

Json? _$JsonConverterToJson<Json, Value>(
  Value? value,
  Json? Function(Value value) toJson,
) =>
    value == null ? null : toJson(value);

_$ExtremoUserImpl _$$ExtremoUserImplFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ExtremoUserImpl',
      json,
      ($checkedConvert) {
        final val = _$ExtremoUserImpl(
          pk: $checkedConvert('pk', (v) => v as int),
          email: $checkedConvert('email', (v) => v as String?),
          password: $checkedConvert('password', (v) => v as String?),
          isDeleted: $checkedConvert('is_deleted', (v) => v as bool),
          deletedAt: $checkedConvert(
              'deleted_at',
              (v) => _$JsonConverterFromJson<String, DateTime>(
                  v, const DateTimeConverter().fromJson)),
          dateJoined: $checkedConvert(
              'date_joined',
              (v) => _$JsonConverterFromJson<String, DateTime>(
                  v, const DateTimeConverter().fromJson)),
          createdAt: $checkedConvert('created_at',
              (v) => const DateTimeConverter().fromJson(v as String)),
          updatedAt: $checkedConvert('updated_at',
              (v) => const DateTimeConverter().fromJson(v as String)),
        );
        return val;
      },
      fieldKeyMap: const {
        'isDeleted': 'is_deleted',
        'deletedAt': 'deleted_at',
        'dateJoined': 'date_joined',
        'createdAt': 'created_at',
        'updatedAt': 'updated_at'
      },
    );

const _$$ExtremoUserImplFieldMap = <String, String>{
  'pk': 'pk',
  'email': 'email',
  'password': 'password',
  'isDeleted': 'is_deleted',
  'deletedAt': 'deleted_at',
  'dateJoined': 'date_joined',
  'createdAt': 'created_at',
  'updatedAt': 'updated_at',
};

// ignore: unused_element
abstract class _$$ExtremoUserImplPerFieldToJson {
  // ignore: unused_element
  static Object? pk(int instance) => instance;
  // ignore: unused_element
  static Object? email(String? instance) => instance;
  // ignore: unused_element
  static Object? password(String? instance) => instance;
  // ignore: unused_element
  static Object? isDeleted(bool instance) => instance;
  // ignore: unused_element
  static Object? deletedAt(DateTime? instance) =>
      _$JsonConverterToJson<String, DateTime>(
          instance, const DateTimeConverter().toJson);
  // ignore: unused_element
  static Object? dateJoined(DateTime? instance) =>
      _$JsonConverterToJson<String, DateTime>(
          instance, const DateTimeConverter().toJson);
  // ignore: unused_element
  static Object? createdAt(DateTime instance) =>
      const DateTimeConverter().toJson(instance);
  // ignore: unused_element
  static Object? updatedAt(DateTime instance) =>
      const DateTimeConverter().toJson(instance);
}

Map<String, dynamic> _$$ExtremoUserImplToJson(_$ExtremoUserImpl instance) =>
    <String, dynamic>{
      'pk': instance.pk,
      'email': instance.email,
      'password': instance.password,
      'is_deleted': instance.isDeleted,
      'deleted_at': _$JsonConverterToJson<String, DateTime>(
          instance.deletedAt, const DateTimeConverter().toJson),
      'date_joined': _$JsonConverterToJson<String, DateTime>(
          instance.dateJoined, const DateTimeConverter().toJson),
      'created_at': const DateTimeConverter().toJson(instance.createdAt),
      'updated_at': const DateTimeConverter().toJson(instance.updatedAt),
    };
