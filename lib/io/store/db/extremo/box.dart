import 'package:extremo/io/entity/extremo/extremo.dart';

import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'box.g.dart';

const version = '2';

@riverpod
Future<Box<ArtifactEntity>> artifactBox(
  ArtifactBoxRef ref,
) async =>
    Hive.openBox<ArtifactEntity>('extremoArtifactBox:$version');

@riverpod
Future<Box<TenantEntity>> tenantBox(
  TenantBoxRef ref,
) async =>
    Hive.openBox<TenantEntity>('extremoTenantBox:$version');

@riverpod
Future<Box<TenantProfileEntity>> tenantProfileBox(
  TenantProfileBoxRef ref,
) async =>
    Hive.openBox<TenantProfileEntity>('extremoTenantProfileBox:$version');

@riverpod
Future<Box<UserEntity>> userBox(
  UserBoxRef ref,
) async =>
    Hive.openBox<UserEntity>('extremoUserBox:$version');

@riverpod
Future<Box<UserProfileEntity>> userProfileBox(
  UserProfileBoxRef ref,
) async =>
    Hive.openBox<UserProfileEntity>('extremoUserProfileBox:$version');

@riverpod
Future<Box<ChatEntity>> chatBox(
  ChatBoxRef ref,
) async =>
    Hive.openBox<ChatEntity>('extremoChatBox:$version');

@riverpod
Future<Box<ChatMessageEntity>> chatMessageBox(
  ChatMessageBoxRef ref,
) async =>
    Hive.openBox<ChatMessageEntity>('extremoChatMessageBox:$version');

@riverpod
Future<Box<UserEntity>> chatMessageUserBox(
  ChatMessageUserBoxRef ref,
) async =>
    Hive.openBox<UserEntity>('extremoChatMessageUserBox:$version');

@riverpod
Future<Box<ServiceEntity>> serviceBox(
  ServiceBoxRef ref,
) async =>
    Hive.openBox<ServiceEntity>('extremoServiceBox:$version');

@riverpod
Future<Box<BookEntity>> bookBox(
  BookBoxRef ref,
) async =>
    Hive.openBox<BookEntity>('extremoBookBox:$version');

@riverpod
Future<Box<TeamEntity>> teamBox(
  TeamBoxRef ref,
) async =>
    Hive.openBox<TeamEntity>('extremoTeamBox:$version');
