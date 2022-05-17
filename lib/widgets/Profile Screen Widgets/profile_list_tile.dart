import 'package:flutter/material.dart';

class ProfileListTile extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final bool hasIcon;

  const ProfileListTile({
    required this.title,
    required this.leadingIcon,
    this.hasIcon = true,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(
        leadingIcon,
        color: const Color(0xff5859F3),
        size: 28,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      trailing: hasIcon
          ? const Icon(
              Icons.arrow_forward_ios,
              color: Colors.black,
              size: 20,
            )
          : const SizedBox.shrink(),
    );
  }
}
