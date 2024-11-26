// import 'package:extremo/domain/model/extremo.dart';
// import 'package:extremo/domain/usecase/artifact.dart';
// import 'package:extremo/ui/layout/error_view.dart';
// import 'package:extremo/ui/layout/extremo_type_chips.dart';
// import 'package:extremo/ui/layout/favorite_button.dart';
// import 'package:extremo/ui/layout/paging_controller.dart';
// import 'package:extremo/ui/layout/progress_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extremo/misc/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MenuPage extends HookConsumerWidget {
  const MenuPage({
    super.key,
    this.isModal = false,
    this.onTapAction,
  });

  final bool isModal;
  final void Function(Menu)? onTapAction;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // dummy data
    final menus = [
      Menu(
        name: 'M1',
        status: 'Hello!',
        avatarUrl: 'https://via.placeholder.com/150',
        isOnline: true,
        unreadMessages: 2,
      ),
      Menu(
        name: 'M2',
        status: 'Busy now',
        avatarUrl: 'https://via.placeholder.com/150',
        isOnline: false,
        unreadMessages: 0,
      ),
      Menu(
        name: 'M3',
        status: 'Available',
        avatarUrl: 'https://via.placeholder.com/150',
        isOnline: true,
        unreadMessages: 5,
      ),
    ];
    final searchQuery = useState('');

    final filteredMenus = useMemoized(
      () {
        return menus.where((menu) => menu.name.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
      },
      [searchQuery.value],
    );

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Menu Page'),
        leading: isModal
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
        actions: isModal
            ? [
                Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ]
            : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'メニュー検索',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => searchQuery.value = value,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMenus.length,
              itemBuilder: (context, index) {
                final menu = filteredMenus[index];
                return ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(menu.avatarUrl),
                      ),
                      if (menu.unreadMessages > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${menu.unreadMessages}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(menu.name),
                  subtitle: Text(menu.status),
                  trailing: menu.isOnline ? const Icon(Icons.circle, color: Colors.green, size: 12) : null,
                  onTap: () {
                    if (onTapAction != null) {
                      return onTapAction!(menu);
                    }

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${menu.name} selected')),
                    );
                  },
                  // onTap: () {
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     SnackBar(content: Text('${menu.name} selected')),
                  //   );
                  // },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Menu {
  Menu({
    required this.name,
    required this.status,
    required this.avatarUrl,
    required this.isOnline,
    required this.unreadMessages,
  });

  final String name;
  final String status;
  final String avatarUrl;
  final bool isOnline;
  final int unreadMessages;
}
