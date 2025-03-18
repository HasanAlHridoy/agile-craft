import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:agile_crafts_task/src/core/database/hive_service.dart';
import 'package:agile_crafts_task/src/core/network/api_client.dart';
import 'package:agile_crafts_task/src/features/sign_in/model/request/sign_in.dart';
import 'package:agile_crafts_task/src/shared/enum/method.dart';
import 'package:dartz/dartz.dart';
import 'package:hive_ce/hive.dart';


class SignInRepository {
  final ApiClient _apiClient;
  final HiveService _hiveService;

  SignInRepository(this._apiClient, this._hiveService);

  Future<Either> signin({required SigninParams params}) async {
    try {
      final response = await _apiClient.request(
        ApiClientMethod.post,
        'TokenAuth/Authenticate',
        data: params.toJson(),
        isAuthRequired: false,
      );
      final Map<String, dynamic> apiResponse = json.decode(response);
      final String accessToken = apiResponse["result"]["accessToken"];
      await _hiveService.putToken(accessToken);
      final data = _hiveService.getToken();
      log('Token from Hive: $data');
      return Right(apiResponse);
    } on SocketException catch (e) {
      return Left('No internet connection. $e');
    } catch (e) {
      log('Error in signin: $e');
      return Left(e);
    }
  }

  /// 🔹 Function to Save Token to Hive
  static Future<void> saveToken(String token) async {
    var box = await Hive.openBox('authBox');
    await box.put('access_token', token);
  }
}
