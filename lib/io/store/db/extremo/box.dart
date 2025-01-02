import 'package:extremo/io/entity/extremo/extremo.dart';

import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'box.g.dart';

@riverpod
Future<Box<ArtifactEntity>> artifactBox(
  ArtifactBoxRef ref,
) async =>
    Hive.openBox<ArtifactEntity>('extremoArtifactBox');

@riverpod
Future<Box<UserEntity>> userBox(
  UserBoxRef ref,
) async =>
    Hive.openBox<UserEntity>('extremoUserBox');

@riverpod
Future<Box<ChatEntity>> ChatBox(
  ChatBoxRef ref,
) async =>
    Hive.openBox<ChatEntity>('extremoChatBox');

@riverpod
Future<Box<ChatMessageEntity>> chatMessageBox(
  ChatMessageBoxRef ref,
) async =>
    Hive.openBox<ChatMessageEntity>('extremoChatMessageBox');

@riverpod
Future<Box<UserEntity>> chatMessageUserBox(
  ChatMessageUserBoxRef ref,
) async =>
    Hive.openBox<UserEntity>('extremoChatMessageUserBox');
