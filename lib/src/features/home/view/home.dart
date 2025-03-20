import 'dart:developer';

import 'package:agile_crafts_task/src/core/config/size/size.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/context.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/double.dart';
import 'package:agile_crafts_task/src/features/home/controller/home.dart';
import 'package:agile_crafts_task/src/features/home/view/components/create_or_edit.dart';
import 'package:agile_crafts_task/src/shared/riverpod/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomeView extends ConsumerWidget {
  const HomeView({super.key});
  static const String name = 'home';
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref
        .watch(productProvider)
        .when(
          error: riverpodError,
          loading: riverpodLoading,
          data: (_) {
            final notifier = ref.watch(productProvider.notifier);
            log(notifier.products.toString());
            return Scaffold(
              appBar: AppBar(
                title: Text('Products'),
                actions: [
                  IconButton(
                    onPressed: () {
                      showDialog(context: context, builder: (context) => CustomDialog());
                    },
                    icon: const Icon(Icons.add_circle_outline_sharp),
                  ),
                ],
              ),
              body: Padding(
                padding: const EdgeInsets.all(defaultPadding),
                child: ListView.separated(
                  itemCount: notifier.products.length,
                  separatorBuilder: (context, index) => (defaultPadding).height,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(notifier.products[index].name),
                      subtitle: Text(notifier.products[index].description),
                      trailing: IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return CustomDialog();
                            },
                          );
                        },
                        icon: Icon(Icons.edit),
                      ),
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        );
  }
}
