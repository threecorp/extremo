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

class UserPage extends HookConsumerWidget {
  const UserPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // dummy data
    final users = [
      User(
        name: 'Alice',
        status: 'Hello!',
        avatarUrl: 'https://via.placeholder.com/150',
        isOnline: true,
        unreadMessages: 2,
      ),
      User(
        name: 'Bob',
        status: 'Busy now',
        avatarUrl: 'https://via.placeholder.com/150',
        isOnline: false,
        unreadMessages: 0,
      ),
      User(
        name: 'Charlie',
        status: 'Available',
        avatarUrl: 'https://via.placeholder.com/150',
        isOnline: true,
        unreadMessages: 5,
      ),
    ];

    final searchQuery = useState('');

    final filteredUsers = useMemoized(
      () {
        return users.where((user) => user.name.toLowerCase().contains(searchQuery.value.toLowerCase())).toList();
      },
      [searchQuery.value],
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'ユーザー検索',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => searchQuery.value = value,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredUsers.length,
              itemBuilder: (context, index) {
                final user = filteredUsers[index];
                return ListTile(
                  leading: Stack(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user.avatarUrl),
                      ),
                      if (user.unreadMessages > 0)
                        Positioned(
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${user.unreadMessages}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  title: Text(user.name),
                  subtitle: Text(user.status),
                  trailing: user.isOnline ? const Icon(Icons.circle, color: Colors.green, size: 12) : null,
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${user.name} selected')),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class User {
  User({
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
