import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:agile_crafts_task/src/core/database/hive_service.dart';
import 'package:agile_crafts_task/src/shared/enum/method.dart';
import 'package:http/http.dart' as http;

class ApiClient {
  final HiveService _hiveService;

  ApiClient(this._hiveService);
  String url = 'https://stg-zero.propertyproplus.com.au/api';

  Future<String> request(
    ApiClientMethod method,
    String endPoint, {
    Map<String, dynamic>? data,
    bool isAuthRequired = true,
  }) async {
    String? token;
    if (isAuthRequired) {
      token = _hiveService.getToken();
      if (token == null) {
        throw 'Session expired. Please sign in again.';
      }
    }
    final headers = {
      'Content-Type': 'application/json',
      'Abp.TenantId': '10',
      if (isAuthRequired) 'Authorization': 'Bearer $token',
    };

    var request = http.Request(method.value, Uri.parse('$url/$endPoint'));
    if (data != null) request.body = json.encode(data);
    request.headers.addAll(headers);
    final response = await request.send();
    final body = await response.stream.bytesToString();

    return body;
  }
}
