import 'package:agile_crafts_task/src/core/config/size/size.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/context.dart';
import 'package:agile_crafts_task/src/core/utils/extensions/double.dart';
import 'package:agile_crafts_task/src/features/home/controller/create_product.dart';
import 'package:agile_crafts_task/src/features/home/model/response/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomDialog extends ConsumerWidget {
  final ProductModel? product;
  const CustomDialog({super.key, this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(createProductProvider(product));
    final notifier = ref.watch(createProductProvider(product).notifier);
    return Dialog(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      insetPadding: EdgeInsets.all(defaultPadding),
      child: Padding(
        padding: const EdgeInsets.all(defaultPadding),
        child: Form(
          key: notifier.createProductFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: defaultPadding,
            children: [
              Row(
                children: [
                  Expanded(child: Text('Create / Edit Product', style: context.text.titleLarge)),
                  IconButton(onPressed: () => Navigator.pop(context), icon: Icon(Icons.close)),
                ],
              ),
              TextFormField(
                style: context.text.bodyMedium,
                controller: notifier.nameController,
                decoration: InputDecoration(hintText: 'Enter Product Name'),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => v == null || v.isEmpty ? 'Field is required' : null,
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              TextFormField(
                style: context.text.bodyMedium,
                controller: notifier.descriptionController,
                maxLines: 4,
                decoration: InputDecoration(hintText: 'Enter Product Description'),
                textInputAction: TextInputAction.next,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (v) => v == null || v.isEmpty ? 'Field is required' : null,
                onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
              ),
              Row(
                children: [
                  Text('Is Available', style: context.text.bodyMedium),
                  Checkbox(value: notifier.isAvailable, onChanged: (_) => notifier.toggleIsAvailable()),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Colors.red)),
                      onPressed: () {
                        context.pop();
                      },
                      child: Text('Cancel'),
                    ),
                  ),
                  (defaultPadding).width,
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (product == null) {
                          notifier.createProduct(context);
                        } else {
                          notifier.editProduct(context, product!.id);
                        }
                      },
                      child: Text('Save'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
