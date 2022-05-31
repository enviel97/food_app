import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_shop/helpers/constants.dart';
import 'package:get/get.dart';

class ApiClient extends GetConnect implements GetxService {
  late String token;
  late Map<String, String> _mainHeader;

  final String appBaseUrl;

  ApiClient(this.appBaseUrl) {
    baseUrl = appBaseUrl;
    timeout = const Duration(seconds: 30);
    token = AppConstants.API_KEY;
    _mainHeader = {
      'Content-type': 'application/json; charset=UTF-8',
      'authenticate': token,
    };
  }

  final Map<String, String> mimetype = {
    'png': 'image/png',
    'jpeg': 'image/jpeg',
    'jpg': 'image/jpg',
  };

  Future<Response> getData(
    String uri, {
    List<String>? params,
    Map<String, dynamic>? query,
  }) async {
    try {
      String _uri = uri;
      if (params != null && params.isNotEmpty) {
        _uri = '$uri/${params.join('/')}';
      }
      final response = await get(
        _uri,
        headers: _mainHeader,
        query: query,
      );
      return response;
    } catch (e) {
      debugPrint('[GET]: $uri - $e');
      return Response(statusCode: -1, statusText: e.toString());
    }
  }

  Future<Response> postData(
    String uri, {
    Map<String, dynamic>? body,
  }) async {
    try {
      final response = await post(uri, body, headers: _mainHeader);
      return response;
    } catch (e) {
      debugPrint('[GET]: $uri - $e');
      return Response(statusCode: -1, statusText: e.toString());
    }
  }

  /// This is request if has any media file need to request
  /// - Paramater:
  ///   * [uri - String]: concat with baseUrl to create a url of api
  ///   * [body - Map<String, dynamic>?]: all non-file data need to send
  ///   * [files - Map<String, dynamic>?]: all file need to request with [key]
  ///  is [fieldname] and value is file

  Future<Response> postDataWithMedia(
    String uri, {
    Map<String, dynamic>? body,
    Map<String, File>? files,
  }) async {
    try {
      final Map<String, dynamic> data = {...body ?? {}};
      FormData? form;
      if (files != null) {
        final Map<String, dynamic> formDatas = {};
        files.forEach((key, file) {
          final filename = file.path.split('/').last.split('.');
          formDatas.addAll({
            key: MultipartFile(
              file,
              filename: filename.first,
              contentType:
                  mimetype[filename.last] ?? 'application/octet-stream',
            )
          });
        });
        data.addAll(formDatas);
      }
      form = FormData(data);
      final clone = _mainHeader;
      clone.remove('Content-type');
      final response = await post(
        uri,
        form,
        headers: clone,
      );
      return response;
    } catch (e) {
      debugPrint('[GET]: $uri - $e');
      return Response(statusCode: -1, statusText: e.toString());
    }
  }

  Future<Response> patchData(String uri, {Map<String, dynamic>? body}) async {
    try {
      final response = await post(uri, body, headers: _mainHeader);
      return response;
    } catch (e) {
      debugPrint('[GET]: $uri - $e');
      return Response(statusCode: -1, statusText: e.toString());
    }
  }
}
