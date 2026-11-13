import 'package:flutter/material.dart';

import '../models/user.dart';

class UserAvatar extends StatelessWidget {
  final User user;
  final double radius;
  final VoidCallback? onTap;

  const UserAvatar({
    super.key,
    required this.user,
    this.radius = 30,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Widget content;

    if (user.avatarBytes != null) {
      content = Image.memory(
        user.avatarBytes!,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Text(
              user.initial,
              style: TextStyle(fontSize: radius, fontWeight: FontWeight.bold),
            ),
          );
        },
      );
    } else if (user.avatarStyle == 'male') {
      content = const Center(
        child: Text('👨🏻', style: TextStyle(fontSize: 38)),
      );
    } else if (user.avatarStyle == 'female') {
      content = const Center(
        child: Text('👩🏻', style: TextStyle(fontSize: 38)),
      );
    } else {
      content = Center(
        child: Text(
          user.initial,
          style: TextStyle(
            fontSize: radius,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
    }

    final Color backgroundColor = user.avatarStyle == 'female'
        ? Colors.pink.shade200
        : user.avatarStyle == 'male'
        ? Colors.blue.shade200
        : Colors.teal;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: radius,
            backgroundColor: backgroundColor,
            child: ClipOval(
              child: SizedBox(
                width: radius * 2,
                height: radius * 2,
                child: Center(child: content),
              ),
            ),
          ),

          if (onTap != null)
            Positioned(
              right: -2,
              bottom: -2,
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Colors.teal,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Theme.of(context).colorScheme.surface,
                    width: 2,
                  ),
                ),
                child: const Icon(
                  Icons.camera_alt,
                  size: 13,
                  color: Colors.white,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
