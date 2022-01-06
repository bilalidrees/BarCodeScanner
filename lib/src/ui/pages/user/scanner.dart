import 'dart:io';

import 'package:barcode_scanner/route_generator.dart';
import 'package:barcode_scanner/src/bloc/AuthenticationBloc.dart';
import 'package:barcode_scanner/src/bloc/utility/AppConfig.dart';
import 'package:barcode_scanner/src/bloc/utility/SharedPrefrence.dart';
import 'package:barcode_scanner/src/bloc/utility/Validations.dart';
import 'package:barcode_scanner/src/model/User.dart';
import 'package:barcode_scanner/src/resource/networkConstant.dart';
import 'package:barcode_scanner/src/ui/pages/other_module/MainPageNavigator.dart';
import 'package:barcode_scanner/src/ui/ui_constants/theme/AppColors.dart';
import 'package:barcode_scanner/src/ui/widgets/CustomButton.dart';
import 'package:barcode_scanner/src/ui/widgets/CustomTextField.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:toast/toast.dart';

class BarCodeScanner extends StatefulWidget {
  @override
  _BarCodeScannerState createState() => _BarCodeScannerState();
}

class _BarCodeScannerState extends State<BarCodeScanner> {
  String _scanBarcode = 'Unknown';
  AuthenticationBloc authenticationBloc = AuthenticationBloc();
  TextEditingController barCodeController = TextEditingController();

  @override
  void initState() {
    authenticationBloc.scannerAuthStream.listen((result) {
      Navigator.pushNamed(context, RouteNames.MAINPAGE,
          arguments: ScreenArguments(data: result));
    }, onError: (exception) {
      Toast.show(exception.toString(), context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
    super.initState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
      User? user = await SharedPref.createInstance().getCurrentUser();
      authenticationBloc.scanAuth(
          user: User(
            coupon: barcodeScanRes,
            password: user!.password,
          ),
          url: NetworkConstants.LOGIN_URL);
    } on Exception {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        exit(0);
        return false;
      },
      child: SafeArea(
        child: Scaffold(
            body: Container(
                alignment: Alignment.center,
                child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      CustomButton(
                        onPressed: () {
                          scanBarcodeNormal();
                        },
                        radius: 10,
                        text: "Scan",
                        textColor: Colors.white,
                        backgorundColor: Colors.red,
                        width: AppConfig.of(context).appWidth(50),
                        isToShowEndingIcon: false,
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      Text('Scan result : $_scanBarcode\n',
                          style: TextStyle(fontSize: 20)),
                    
                      Padding(
                        padding:
                            EdgeInsets.all(AppConfig.of(context).appWidth(8)),
                        child: CustomTextField(
                            "BarCode",
                            TextInputType.text,
                            VALIDATION_TYPE.TEXT,
                            Icons.code,
                            barCodeController,
                            false,
                            () {}),
                      ),
                      CustomButton(
                        onPressed: () async {
                          User? user = await SharedPref.createInstance()
                              .getCurrentUser();
                          authenticationBloc.scanAuth(
                              user: User(
                                coupon: barCodeController.text,
                                password: user!.password,
                              ),
                              url: NetworkConstants.LOGIN_URL);
                        },
                        radius: 10,
                        text: "Check BarCode ",
                        textColor: Colors.white,
                        backgorundColor: Colors.red,
                        width: AppConfig.of(context).appWidth(50),
                        isToShowEndingIcon: false,
                      ),
                    ]))),
      ),
    );
  }
}
