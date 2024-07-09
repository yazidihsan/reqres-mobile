import 'package:flutter/material.dart';
import 'package:reqres/theme_manager/space_manager.dart';

import '../../domain/entities/user.dart';

class UserCard extends StatelessWidget {
  const UserCard({
    super.key,
    required this.user,
  });

  final User user;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text(user.firstName ?? '-'),
          24.0.spaceY,
          Text(user.lastName ?? '-'),
          Text(user.email ?? '-')
        ],
      ),
    );
  }
}
