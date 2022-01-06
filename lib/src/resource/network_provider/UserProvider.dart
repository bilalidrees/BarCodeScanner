import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:barcode_scanner/src/resource/NetworkClient.dart';
import 'package:http/http.dart' show Client;
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class UserProvider {
  Client client = Client();

  Future<NetworkClientState?> postData(
      {String? endpoint, String? result}) async {
    NetworkClientState networkClientState = NetworkClientState.getInstance();
    final response =
        networkClientState.postRequest(endpoint: endpoint!, jsonBody: result);
    return response;
  }
}
