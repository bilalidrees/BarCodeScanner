import 'dart:convert';
import 'dart:io';

// import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:barcode_scanner/src/model/User.dart';
import 'package:barcode_scanner/src/resource/repository/user_repository.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/subjects.dart';
import 'bloc_provider.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as JSON;

class AuthenticationBloc implements BlocBase {
  static AuthenticationBloc? _authenticationBloc;
  final userRepository = UserRepository();

  final userAuthStreamController = BehaviorSubject<String>();

  Stream<String> get userAuthStream => userAuthStreamController.stream;

  final scannerAuthStreamController = BehaviorSubject<String>();

  Stream<String> get scannerAuthStream => scannerAuthStreamController.stream;

  static AuthenticationBloc getInstance() {
    if (_authenticationBloc == null) {
      _authenticationBloc = AuthenticationBloc();
    }
    return _authenticationBloc!;
  }

  void userAuth({User? user, String? url}) async {
    await userRepository.userAuth(user: user, url: url!).then((model) {
      userAuthStreamController.sink.add(model);
    }, onError: (exception) {
      userAuthStreamController.sink.addError(exception);
    });
  }

  void scanAuth({User? user, String? url}) async {
    await userRepository.scanAuth(user: user, url: url!).then((model) {
      scannerAuthStreamController.sink.add(model);
    }, onError: (exception) {
      scannerAuthStreamController.sink.addError(exception);
    });
  }

  @override
  void dispose() {
    userAuthStreamController.close();
  }
}
