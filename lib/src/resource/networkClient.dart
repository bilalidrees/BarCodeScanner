import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:barcode_scanner/route_generator.dart';
import 'package:barcode_scanner/src/app.dart';
import 'package:barcode_scanner/src/bloc/utility/SessionClass.dart';
import 'package:barcode_scanner/src/bloc/utility/SharedPrefrence.dart';
import 'package:barcode_scanner/src/ui/ui_constants/theme/string.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';
import 'NetworkConstant.dart';

class NetworkClientState {
  static const String URL = 'https://jsonplaceholder.typicode.com/posts';

  BuildContext? _buildContext;
  static NetworkClientState? networkClientState;
  String? token, apiUrl;
  SessionClass? sessionClass;
  Map<String, String>? _headers;
  http.Client? _client;
  var apiResponse;
  Dio dio = new Dio();

  NetworkClientState.createInstance() {}

  NetworkClientState() {}

  static NetworkClientState getInstance() {
    if (networkClientState == null) {
      networkClientState = NetworkClientState();
    }
    return networkClientState!;
  }

  Future<NetworkClientState?> postRequest(
      {String? endpoint, String? jsonBody}) async {
    try {
      final Map<String, String> headers = {
        'Content-type': 'application/json',
      };
      apiResponse = await http.post(endpoint, body: jsonBody, headers: headers);
      print("response ${apiResponse.body}");
      return NetworkClientState._onSuccess(apiResponse.body, endpoint!);
      // if (apiResponse.statusCode == 201 || apiResponse.statusCode == 200) {
      //   return NetworkClientState._onSuccess(apiResponse.body, endpoint);
      // } else {
      //   if (apiResponse.statusCode == 500)
      //     return NetworkClientState._onError(
      //         NetworkConstants.SERVER_ERROR, endpoint);
      //   else if (apiResponse.statusCode == 401 ||
      //       apiResponse.statusCode == 403) {
      //   } else
      //     return NetworkClientState._onError(
      //         "${apiResponse.body} ${apiResponse.statusCode}", endpoint);
      // }
    } on TimeoutException catch (_) {
      return NetworkClientState._onFailure(
          Exception("Timeout occured"), endpoint!);
    } on Error catch (exception) {
      if (apiResponse.statusCode == 403) {
      } else {
        return NetworkClientState._onFailure(Exception(exception), endpoint!);
      }
    } on Exception catch (exception) {
      //return NetworkClientState._onFailure(exception, endpoint);
    }
  }

  factory NetworkClientState._onSuccess(String response, String apiEndpoint) =
      OnSuccessState;

  factory NetworkClientState._onError(String error, String apiEndpoint) =
      OnErrorState;

  factory NetworkClientState._onFailure(Exception throwable, String endPoint) =
      OnFailureState;
}

class OnSuccessState extends NetworkClientState {
  String? response, apiEndpoint;

  OnSuccessState(this.response, this.apiEndpoint) : super.createInstance();
}

class OnErrorState extends NetworkClientState {
  String error, apiEndpoint;

  OnErrorState(this.error, this.apiEndpoint) : super.createInstance();
}

class OnFailureState extends NetworkClientState {
  Exception throwable;
  String apiEndpoint;

  OnFailureState(this.throwable, this.apiEndpoint) : super.createInstance();
}
