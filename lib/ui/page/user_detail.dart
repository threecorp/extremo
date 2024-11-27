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

class UserDetailPage extends HookConsumerWidget {
  const UserDetailPage({
    super.key,
    required this.id,
  });

  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // bottom tab bar section
    const tabBars = TabBar(
      tabs: [
        Tab(icon: Icon(Icons.grid_on), text: 'Grid'),
        Tab(icon: Icon(Icons.person), text: 'Profile'),
        Tab(icon: Icon(Icons.chat), text: 'Message'),
      ],
    );

    // bottom tab bar section
    return DefaultTabController(
      length: tabBars.tabs.length, // tab count
      child: Scaffold(
        // appBar: AppBar(
        //   title: const Text('User Detail'),
        //   centerTitle: true,
        // ),
        body: Column(
          children: [
            // top profile section
            Container(
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'User Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Bio or description goes here. It can span multiple lines.',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _ProfileView(label: 'Posts', value: '123'),
                            _ProfileView(label: 'Followers', value: '456'),
                            _ProfileView(label: 'Following', value: '789'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // bottom tab bar section
            tabBars,
            // tab's contents
            Expanded(
              child: TabBarView(
                children: [
                  // Grid View iamges
                  GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 4,
                      mainAxisSpacing: 4,
                    ),
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return Container(
                        color: Colors.grey[300],
                        child: Center(
                          child: Text('Item $index'),
                        ),
                      );
                    },
                  ),
                  // profile detail view
                  Center(
                    child: Text(
                      'Detailed Profile Info',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  // Chat view
                  _ChatView(), // Adding the chat view here
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileView extends StatelessWidget {
  const _ProfileView({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(label),
      ],
    );
  }
}

// New Chat View Widget
class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: 10, // Number of messages
            itemBuilder: (context, index) {
              final isMe = index.isEven;
              return Align(
                alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isMe ? Colors.blue[100] : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isMe ? 'Message from me' : 'Message from them',
                  ),
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Type a message',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  // Send message action
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
