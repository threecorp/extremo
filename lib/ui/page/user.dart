// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
import 'package:extremo/misc/logger.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/domain/model/extremo.dart';
import 'package:extremo/domain/usecase/user.dart';
import 'package:extremo/io/auth/account.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:extremo/route/route.dart';
import 'package:extremo/ui/layout/error_view.dart';
import 'package:extremo/ui/layout/paging_controller.dart';
import 'package:extremo/ui/layout/progress_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class UserPage extends HookConsumerWidget {
  const UserPage({
    super.key,
    this.onTapAction,
  });

  final void Function(UserModel)? onTapAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在の「ページング付きユーザ一覧の非同期状態」を監視
    final pagerStateAsync = ref.watch(listPagerUsersCaseProvider);

    // infinite_scroll_pagination のコントローラ
    final pagingController = useState(
      PagingController<int, UserModel>(firstPageKey: 1),
    );

    // 初回マウント時に「1ページ目のリフレッシュ取得」を呼ぶ例
    useEffect(
      () {
        ref.read(listPagerUsersCaseProvider.notifier).refreshFirstPage();
        return null;
      },
      [],
    );

    // PagingController が「次ページを読み込んで」とリクエストしてきたときの処理
    useEffect(
      () {
        pagingController.value.addPageRequestListener((pageKey) async {
          try {
            // pageKey が 1より大きい場合のみ「次ページ」をロード
            if (pageKey > 1) {
              await ref.read(listPagerUsersCaseProvider.notifier).loadNextPage();
            }

            // 最新の state を取得
            final state = ref.read(listPagerUsersCaseProvider).asData?.value;
            if (state == null) {
              throw Exception('No data loaded yet');
            }

            // pageKey に相当する部分だけ抜き出す
            final startIdx = (pageKey - 1) * state.pageSize;
            final endIdx = startIdx + state.pageSize;
            final newItems = state.items.sublist(
              startIdx,
              endIdx.clamp(0, state.items.length),
            );

            // もし最後のページなら appendLastPage
            // そうでなければ appendPage
            if (state.isLast && pageKey >= state.page) {
              pagingController.value.appendLastPage(newItems);
            } else {
              pagingController.value.appendPage(newItems, pageKey + 1);
            }
          } catch (error, st) {
            pagingController.value.error = error;
          }
        });
        return pagingController.value.dispose;
      },
      [pagingController.value],
    );

    // Riverpod の state が変化したタイミングで、必要に応じて PagingController を更新する、などの連携も可能
    // ※ 例えばユーザが再ログインしたら、pagingControllerをリフレッシュする等

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: pagerStateAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (state) {
          return PagedListView<int, UserModel>(
            pagingController: pagingController.value,
            builderDelegate: PagedChildBuilderDelegate<UserModel>(
              itemBuilder: (context, user, index) {
                return ListTile(
                  leading: const CircleAvatar(
                    backgroundImage: NetworkImage('https://placehold.co/300x200/png'),
                  ),
                  title: Text('${user.id}: ${user.profile?.name ?? ''}'),
                  subtitle: const Text('status'),
                  onTap: () {
                    if (onTapAction != null) {
                      onTapAction!(user);
                    } else {
                      // サンプル: 詳細ページに飛ぶなど
                      const UserDetailRoute(id: 1).go(context);
                    }
                  },
                );
              },
              firstPageErrorIndicatorBuilder: (context) => const Center(child: Text('Error loading data.')),
              newPageErrorIndicatorBuilder: (context) => const Center(child: Text('Error loading more data.')),
              noItemsFoundIndicatorBuilder: (context) => const Center(child: Text('No users found.')),
            ),
          );
        },
      ),
    );
  }
}

// class UserPage extends HookConsumerWidget {
//   const UserPage({
//     super.key,
//     this.onTapAction,
//   });
//
//   final void Function(User)? onTapAction;
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final users = ref.watch(listPagerUsersCaseProvider);
//     // final notifier = ref.watch(listPagerUsersCaseProvider.notifier);
//
//     // dummy data
//     final users = [
//       User(
//         name: 'Alice',
//         status: 'Hello!',
//         avatarUrl: 'https://via.placeholder.com/150',
//         isOnline: true,
//         unreadMessages: 2,
//       ),
//       User(
//         name: 'Bob',
//         status: 'Busy now',
//         avatarUrl: 'https://via.placeholder.com/150',
//         isOnline: false,
//         unreadMessages: 0,
//       ),
//       User(
//         name: 'Charlie',
//         status: 'Available',
//         avatarUrl: 'https://via.placeholder.com/150',
//         isOnline: true,
//         unreadMessages: 5,
//       ),
//     ];
//
//     final searchQuery = useState('');
//
//     final filteredUsers = useMemoized(
//       () {
//         return users
//             .where(
//               (user) => user.name.toLowerCase().contains(searchQuery.value.toLowerCase()),
//             )
//             .toList();
//       },
//       [searchQuery.value],
//     );
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User Page'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8),
//             child: TextField(
//               decoration: const InputDecoration(
//                 labelText: 'ユーザー検索',
//                 prefixIcon: Icon(Icons.search),
//               ),
//               onChanged: (value) => searchQuery.value = value,
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               itemCount: filteredUsers.length,
//               itemBuilder: (context, index) {
//                 final user = filteredUsers[index];
//                 return ListTile(
//                   leading: Stack(
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: NetworkImage(user.avatarUrl),
//                       ),
//                       if (user.unreadMessages > 0)
//                         Positioned(
//                           right: 0,
//                           child: Container(
//                             padding: const EdgeInsets.all(4),
//                             decoration: const BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                             child: Text(
//                               '${user.unreadMessages}',
//                               style: const TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 12,
//                               ),
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                   title: Text(user.name),
//                   subtitle: Text(user.status),
//                   trailing: user.isOnline ? const Icon(Icons.circle, color: Colors.green, size: 12) : null,
//                   onTap: () {
//                     if (onTapAction != null) {
//                       return onTapAction!(user);
//                     }
//
//                     const UserDetailRoute(id: 1).go(context);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
