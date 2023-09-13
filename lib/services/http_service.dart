import 'dart:developer' as dev;
import 'dart:io';
import 'package:gamify_app/utils/constans.dart';
import 'package:gamify_app/utils/utils.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:gamify_app/utils/http_exception.dart';

class HttpService {
  static final HttpService _instance = HttpService._privateConstructor();
  static HttpService get instance => _instance;
  HttpService._privateConstructor();
  Map<String, String> headers = {
    'Content-Type': 'application/json',
  };
  Map<String, String> headersOctet = {
    'Content-Type': 'application/octet-stream',
  };

  final extensionFile = '.pdf';

  Future<dynamic> post(
    String path, {
    Object? params,
  }) async {
    dev.log('Llamado al Http Post con path $path', name: 'HttpService.post');
    var url = Uri.http(kBaseUrlService, kComplementUrl + path);
    var response = await http.post(
      url,
      body: params != null ? jsonEncode(params) : null,
      headers: headers,
    );
    dynamic data;
    if (response.statusCode == 200 || response.statusCode == 201) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 500 ||
        response.statusCode == 503) {
      data = jsonDecode(response.body);
      throw HttpException(
        statusCode: response.statusCode,
        error: data['error'],
        message: data['message'],
      );
    } else if (response.statusCode == 204) {
      return;
    } else {
      throw HttpException(message: kMensajeErrorGenerico);
    }
    dev.log('Data $data', name: 'HttpService.post');
    return data;
  }

  Future<dynamic> postFile({
    required String path,
    required File file,
    required Map<String, String> params,
  }) async {
    dev.log('Llamado al Http Post File con path $path',
        name: 'HttpService.postFile');
    var url = Uri.http(kBaseUrlService, kComplementUrl + path);
    var request = http.MultipartRequest('POST', url);
    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        file.readAsBytesSync(),
        filename: Utils.dateToString(dateTime: DateTime.now()) + extensionFile,
        contentType: MediaType('application', 'pdf'),
      ),
    );
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
      'Accept': 'application/json',
      "Access-Control-Allow-Origin": "*",
    });
    request.fields.addAll(params);
    http.StreamedResponse streamedResponse = await request.send();
    http.Response response = await http.Response.fromStream(streamedResponse);
    dynamic data;
    if (response.statusCode == 200 || response.statusCode == 201) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 500 ||
        response.statusCode == 503) {
      data = jsonDecode(response.body);
      throw HttpException(
          statusCode: response.statusCode,
          error: data['error'],
          message: data['error']);
    } else {
      throw HttpException(message: kMensajeErrorGenerico);
    }
    dev.log('Data $data', name: 'HttpService.postFile');
    return data;
  }

  Future<dynamic> get(
    String path, {
    Map<String, String>? params,
  }) async {
    dev.log('Llamado al Http Get con path $path', name: 'HttpService.get');
    var url = Uri.http(kBaseUrlService, kComplementUrl + path, params);
    var response = await http.get(url, headers: headers);
    dynamic data;
    if (response.statusCode == 200) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 500 ||
        response.statusCode == 503) {
      data = jsonDecode(response.body);
      throw HttpException(
          statusCode: response.statusCode,
          error: data['error'],
          message: data['message']);
    } else {
      throw HttpException(message: kMensajeErrorGenerico);
    }
    dev.log('Data $data', name: 'HttpService.get');
    return data;
  }

  Future<void> put(
    String path, {
    Map<String, dynamic>? params,
  }) async {
    dev.log('Llamado al Http Put con path $path y params $params',
        name: 'HttpService.put');
    var url = Uri.http(kBaseUrlService, kComplementUrl + path);
    var response = await http.put(
      url,
      body: params != null ? jsonEncode(params) : null,
      headers: headers,
    );
    dynamic data;
    if (response.statusCode == 200 || response.statusCode == 201) {
      return;
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 500 ||
        response.statusCode == 503) {
      data = jsonDecode(response.body);
      throw HttpException(
          statusCode: response.statusCode,
          error: data['error'],
          message: data['message']);
    } else {
      throw HttpException(message: kMensajeErrorGenerico);
    }
  }

  Future<dynamic> delete(
    String path,
  ) async {
    dev.log('Llamado al Http Delete con path $path',
        name: 'HttpService.delete');
    var url = Uri.http(kBaseUrlService, kComplementUrl + path);
    var response = await http.delete(
      url,
    );
    dynamic data;
    if (response.statusCode == 200 || response.statusCode == 201) {
      data = jsonDecode(utf8.decode(response.bodyBytes));
    } else if (response.statusCode == 400 ||
        response.statusCode == 401 ||
        response.statusCode == 500 ||
        response.statusCode == 503) {
      data = jsonDecode(response.body);
      throw HttpException(
        statusCode: response.statusCode,
        error: data['error'],
        message: data['message'],
      );
    } else if (response.statusCode == 204) {
      return;
    } else {
      throw HttpException(message: kMensajeErrorGenerico);
    }
    dev.log('Data $data', name: 'HttpService.delete');
    return data;
  }
}
