import 'dart:ui';

import 'package:agile_crafts_task/src/core/config/size/size.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/context.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/double.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDialog extends StatelessWidget {
  final String description;
  final String actionTitle;
  const CustomDialog({super.key, required this.description, required this.actionTitle});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
          child: Container(color: context.theme.shadowColor.withValues(alpha: 0.1)),
        ),

        Dialog(
          backgroundColor: context.theme.scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(defaultPadding)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(defaultPadding, defaultPadding * 2, defaultPadding, defaultPadding * 2),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline_sharp, size: context.getHeight(70), color: Colors.red),
                (defaultPadding).height,

                Text("Confirm", style: context.text.titleLarge),

                const SizedBox(height: 10),

                Text(description, textAlign: TextAlign.center, style: context.text.bodyMedium),

                (defaultPadding * 2).height,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: () => context.pop(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: Text(
                          "Cancel",
                          style: context.text.bodyLarge!.copyWith(color: context.theme.scaffoldBackgroundColor),
                        ),
                      ),
                    ),

                    (defaultPadding / 2).width,

                    Expanded(
                      flex: 5,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(actionTitle, style: context.text.bodyLarge!.copyWith(color: Colors.red)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
