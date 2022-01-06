import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:barcode_scanner/src/bloc/utility/SessionClass.dart';

import 'package:barcode_scanner/src/model/User.dart';
import 'package:barcode_scanner/src/resource/networkConstant.dart';
import 'package:barcode_scanner/src/resource/network_provider/UserProvider.dart';
import 'package:http/http.dart' as http;

import 'package:barcode_scanner/src/resource/NetworkClient.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:barcode_scanner/route_generator.dart';
import 'package:barcode_scanner/src/app.dart';
import 'package:barcode_scanner/src/bloc/utility/SessionClass.dart';
import 'package:barcode_scanner/src/bloc/utility/SharedPrefrence.dart';
import 'package:barcode_scanner/src/ui/ui_constants/theme/string.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http_parser/http_parser.dart';

class UserRepository {
  final userProvider = UserProvider();

  Future<String?> userAuth({User? user, String? url}) async {
    Map<String, dynamic> result = user!.toJson();
    String jsonUser = jsonEncode(result);
    NetworkClientState? response =
        await userProvider.postData(endpoint: url, result: jsonUser);

    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      final parsed = json.decode(onSuccessState.response!);
      if (onSuccessState.response!.contains("Error")) {
        return "Error";
      } else {
        return "Successfull";
      }
    } else if (response is OnFailureState) {
      //OnFailureState onErrorState = response;
      // throw onErrorState.throwable;
    }
  }

  Future<String?> scanAuth({User? user, String? url}) async {
    Map<String, dynamic> result = user!.toJson();
    String jsonUser = jsonEncode(result);

    NetworkClientState? response =
        await userProvider.postData(endpoint: url, result: jsonUser);
    if (response is OnSuccessState) {
      OnSuccessState onSuccessState = response;
      final parsed = json.decode(onSuccessState.response!);

      String data;
      if (onSuccessState.response!.contains("Successful")) {
        data = parsed["Successful"];
      } else {
        data = parsed["Error"];
      }

      return data;
    } else if (response is OnFailureState) {
      // OnFailureState onErrorState = response;
      // throw onErrorState.throwable;
    }
  }
}
