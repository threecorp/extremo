// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'extremo_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ExtremoGetResponseImpl _$$ExtremoGetResponseImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ExtremoGetResponseImpl',
      json,
      ($checkedConvert) {
        final val = _$ExtremoGetResponseImpl(
          user: $checkedConvert(
              'user', (v) => ExtremoUser.fromJson(v as Map<String, dynamic>)),
        );
        return val;
      },
    );

const _$$ExtremoGetResponseImplFieldMap = <String, String>{
  'user': 'user',
};

// ignore: unused_element
abstract class _$$ExtremoGetResponseImplPerFieldToJson {
  // ignore: unused_element
  static Object? user(ExtremoUser instance) => instance.toJson();
}

Map<String, dynamic> _$$ExtremoGetResponseImplToJson(
        _$ExtremoGetResponseImpl instance) =>
    <String, dynamic>{
      'user': instance.user.toJson(),
    };

_$ExtremoListResponseImpl _$$ExtremoListResponseImplFromJson(
        Map<String, dynamic> json) =>
    $checkedCreate(
      r'_$ExtremoListResponseImpl',
      json,
      ($checkedConvert) {
        final val = _$ExtremoListResponseImpl(
          totalSize: $checkedConvert('total_size', (v) => v as int),
          users: $checkedConvert(
              'users',
              (v) => (v as List<dynamic>)
                  .map((e) => ExtremoUser.fromJson(e as Map<String, dynamic>))
                  .toList()),
        );
        return val;
      },
      fieldKeyMap: const {'totalSize': 'total_size'},
    );

const _$$ExtremoListResponseImplFieldMap = <String, String>{
  'totalSize': 'total_size',
  'users': 'users',
};

// ignore: unused_element
abstract class _$$ExtremoListResponseImplPerFieldToJson {
  // ignore: unused_element
  static Object? totalSize(int instance) => instance;
  // ignore: unused_element
  static Object? users(List<ExtremoUser> instance) =>
      instance.map((e) => e.toJson()).toList();
}

Map<String, dynamic> _$$ExtremoListResponseImplToJson(
        _$ExtremoListResponseImpl instance) =>
    <String, dynamic>{
      'total_size': instance.totalSize,
      'users': instance.users.map((e) => e.toJson()).toList(),
    };

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
