import 'package:agile_crafts_task/injectors.dart';
import 'package:agile_crafts_task/src/features/home/model/request/product.dart';
import 'package:agile_crafts_task/src/features/home/model/response/product.dart';
import 'package:agile_crafts_task/src/features/home/repository/home.dart';
import 'package:agile_crafts_task/src/shared/custom_snackbar/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:path/path.dart';

// typedef ProductNotifier = AutoDisposeNotifierProviderFamily<CreateProductProvider, void,ProductModel>;
// final createProductProvider = ProductNotifier(CreateProductProvider.new);
typedef CreateProductNotifier = AutoDisposeNotifierProviderFamily<CreateProductProvider,void, ProductModel?>;
final createProductProvider = CreateProductNotifier(CreateProductProvider.new);
class CreateProductProvider extends AutoDisposeFamilyNotifier<void, ProductModel?> {
  final createProductFormKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  bool isAvailable = false;


  @override
  void build(ProductModel? arg) {
    if (arg != null) {
      nameController.text = arg.name;
      descriptionController.text = arg.description;
      isAvailable = arg.isAvailable;
    }
  }
 
  // Toggle the availability of the product
  void toggleIsAvailable() {
    isAvailable = !isAvailable;
    ref.notifyListeners();
  }

  // Create a new product
  Future<void> createProduct(BuildContext context) async{
    if (!(createProductFormKey.currentState?.validate() ?? false)) return;
    final name = nameController.text;
    final description = descriptionController.text;

    final product = ProductRequestModel(name: name, description: description, isAvailable: isAvailable);
    final response = await sl<HomeRepository>().saveProductData( product);
    response.fold(
      (error) {
        CustomSnackbar.show(context, error.toString(), isError: true);
      },
      (success) {
        CustomSnackbar.show(context, 'Product created successfully');
        context.pop();
      },
    );
  }

  // Edit an existing product
  Future<void> editProduct(BuildContext context, String id) async{
    if (!(createProductFormKey.currentState?.validate() ?? false)) return;
    final name = nameController.text;
    final description = descriptionController.text;

    final product = ProductRequestModel(name: name, description: description, isAvailable: isAvailable);
    final response = await sl<HomeRepository>().saveProductData(product);
    response.fold(
      (error) {
        CustomSnackbar.show(context, error.toString(), isError: true);
      },
      (success) {
        CustomSnackbar.show(context, 'Product updated successfully');
        context.pop();
      },
    );
  }
  
}