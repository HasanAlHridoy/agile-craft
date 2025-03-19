import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:agile_crafts_task/src/core/database/hive_service.dart';
import 'package:agile_crafts_task/src/core/network/api_client.dart';
import 'package:agile_crafts_task/src/features/home/model/product.dart';
import 'package:agile_crafts_task/src/shared/enum/method.dart';
import 'package:dartz/dartz.dart';

class HomeRepository {
  final ApiClient _apiClient;
  final HiveService _hiveService;

  HomeRepository(this._apiClient, this._hiveService);

  Future<Either> fetchProductData() async {
    try {
      final response = await _apiClient.request(ApiClientMethod.get, 'services/app/ProductSync/GetAllproduct', isAuthRequired: true);
      final data = ProductModel.fromJsonList(json.decode(response));
      log('Response type: ${data.first.name}');
      return Right(data);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      log('Error in Product: $e');
      return Left(e);
    }
  }
}
