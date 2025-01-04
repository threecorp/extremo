import 'package:extremo/io/entity/extremo/extremo.dart';

import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'box.g.dart';

@riverpod
Future<Box<ArtifactEntity>> artifactBox(
  ArtifactBoxRef ref,
) async =>
    Hive.openBox<ArtifactEntity>('extremoArtifactBox:1');

@riverpod
Future<Box<TenantEntity>> tenantBox(
  TenantBoxRef ref,
) async =>
    Hive.openBox<TenantEntity>('extremoTenantBox:1');

@riverpod
Future<Box<TenantProfileEntity>> tenantProfileBox(
  TenantProfileBoxRef ref,
) async =>
    Hive.openBox<TenantProfileEntity>('extremoTenantProfileBox:1');

@riverpod
Future<Box<UserEntity>> userBox(
  UserBoxRef ref,
) async =>
    Hive.openBox<UserEntity>('extremoUserBox:1');

@riverpod
Future<Box<UserProfileEntity>> userProfileBox(
  UserProfileBoxRef ref,
) async =>
    Hive.openBox<UserProfileEntity>('extremoUserProfileBox:1');

@riverpod
Future<Box<ChatEntity>> chatBox(
  ChatBoxRef ref,
) async =>
    Hive.openBox<ChatEntity>('extremoChatBox:1');

@riverpod
Future<Box<ChatMessageEntity>> chatMessageBox(
  ChatMessageBoxRef ref,
) async =>
    Hive.openBox<ChatMessageEntity>('extremoChatMessageBox:1');

@riverpod
Future<Box<UserEntity>> chatMessageUserBox(
  ChatMessageUserBoxRef ref,
) async =>
    Hive.openBox<UserEntity>('extremoChatMessageUserBox:1');

@riverpod
Future<Box<ServiceEntity>> serviceBox(
  ServiceBoxRef ref,
) async =>
    Hive.openBox<ServiceEntity>('extremoServiceBox:1');
