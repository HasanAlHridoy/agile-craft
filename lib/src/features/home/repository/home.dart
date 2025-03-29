import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:agile_crafts_task/src/core/database/hive_service.dart';
import 'package:agile_crafts_task/src/core/network/api_client.dart';
import 'package:agile_crafts_task/src/features/home/model/request/product.dart';
import 'package:agile_crafts_task/src/features/home/model/response/product.dart';
import 'package:agile_crafts_task/src/shared/enum/method.dart';
import 'package:agile_crafts_task/src/shared/internet/provider/internet.dart';
import 'package:dartz/dartz.dart';

class HomeRepository {
  final ApiClient _apiClient;
  final HiveService _hiveService;

  HomeRepository(this._apiClient, this._hiveService);

  Future<Either> fetchProductData() async {
    final isConnected = await isOnline();

    if (!isConnected) {
      final data = _hiveService.getProductData();
      if (data != null) {
        log('No internet connection, using cached data.');
        return Right(data);
      } else {
        return Left('No internet connection and no cached data available.');
      }
    }
    try {
      final response = await _apiClient.request(
        ApiClientMethod.get,
        'services/app/ProductSync/GetAllproduct',
        isAuthRequired: true,
      );
      final data = ProductModel.fromJsonList(json.decode(response));
      log('Product Data using internet');
      if (data.isNotEmpty) {
        await _hiveService.putProductData(data);
      }
      return Right(data);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      log('Error in Product: $e');
      return Left(e);
    }
  }

  Future<Either> saveProductData(ProductRequestModel requestProductModel) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.post,
        'services/app/ProductSync/CreateOrEdit',
        data: requestProductModel.toJson(),
        isAuthRequired: true,
      );
      return Right(response);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      log('Error in Product: $e');
      return Left(e);
    }
  }

  Future<Either> updateProductData(ProductRequestModel requestProductModel) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.patch,
        'services/app/ProductSync/CreateOrEdit',
        data: requestProductModel.toJson(),
        isAuthRequired: true,
      );
      return Right(response);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      log('Error in Product: $e');
      return Left(e);
    }
  }
}
