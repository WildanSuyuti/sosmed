import 'package:flutter/material.dart';

class SliverSearchAppbar extends StatelessWidget
    implements PreferredSizeWidget {
  final FocusNode node;
  final String title;
  final String hint;
  final bool isSearch;
  final VoidCallback onTapIcon;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  const SliverSearchAppbar({
    Key? key,
    required this.title,
    required this.hint,
    required this.isSearch,
    required this.onTapIcon,
    this.onChanged,
    this.onSubmitted,
    required this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      backgroundColor: Colors.white,
      title: _buildTitleUI,
      leading: const BackButton(color: Colors.black),
      actions: [
        IconButton(
          onPressed: onTapIcon,
          icon: Icon(isSearch ? Icons.close : Icons.search),
          color: Colors.black,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  get _buildTitleUI {
    if (isSearch) {
      return TextField(
        focusNode: node,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle:
              const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
          border: InputBorder.none,
        ),
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      );
    }
    return Text(
      title,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ),
    );
  }
}
