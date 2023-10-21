import 'dart:convert';

import 'package:http/http.dart' as http;

import '../core.dart';

class NetworkException implements Exception {
  int statusCode;
  String? message;
  NetworkException(this.statusCode, {this.message});
}

class ApiClient {
  final http.Client httpClient;

  ApiClient(this.httpClient);

  Future<List<dynamic>> fetchList(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    Uri uri = await _createUri(path, queryParams: queryParams);

    final response = await httpClient.get(
      uri,
    );

    return _handleResponse(response);
  }

  List<dynamic> _handleResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode > 204) {
      throw NetworkException(response.statusCode);
    }
    try {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body) as List;
      }
    } catch (e) {
      throw Exception(e);
    }
    return [];
  }

  Future<Uri> _createUri(
    String path, {
    Map<String, String>? queryParams,
  }) async {
    Map<String, String> params = {
      'per_page': "10",
    };
    if (queryParams != null) {
      params.addAll(queryParams);
    }

    final uri = Uri.https(Constants.baseURL, "/v2$path", params);
    return uri;
  }
}