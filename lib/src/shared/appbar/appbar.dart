import 'package:agile_crafts_task/src/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final Color? backgroundColor;
  final double height;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.backgroundColor,
    this.height = kToolbarHeight, // Default AppBar height
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: context.theme.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SafeArea(
        child: SizedBox(
          height: height,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              leading ?? const SizedBox(),
              Text(title ?? '', style: context.text.titleLarge!.copyWith(color: context.theme.scaffoldBackgroundColor)),
              Row(mainAxisSize: MainAxisSize.min, children: actions ?? []),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
