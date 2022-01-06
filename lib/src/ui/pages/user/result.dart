import 'package:barcode_scanner/src/bloc/utility/AppConfig.dart';
import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  String? data;

  Result({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          padding:
              const EdgeInsets.only(left: 20, top: 20, right: 20, bottom: 20),
          margin: const EdgeInsets.only(top: 20),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                    color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 45,
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(45)),
                    child: Image.asset(
                      data == "Valid coupon"
                          ? "assets/yes.jpg"
                          : "assets/no.jpg",
                      height: AppConfig.of(context).appWidth(100),
                      width: AppConfig.of(context).appWidth(100),
                    )),
              ),
              Text(
                data == "Valid coupon" ? " Success!" : "Error!",
                style: TextStyle(
                    fontSize: AppConfig.of(context).appWidth(7),
                    color: Colors.black,
                    fontWeight: FontWeight.w600),
              ),
              SizedBox(
                height: AppConfig.of(context).appWidth(2),
              ),
              Text(
                data,
                style: TextStyle(
                    fontSize: AppConfig.of(context).appWidth(5),
                    fontWeight: FontWeight.w500),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: AppConfig.of(context).appWidth(3),
              ),
              SizedBox(
                height: AppConfig.of(context).appWidth(3),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Close",
                        style: TextStyle(
                            fontSize: AppConfig.of(context).appWidth(5),
                            color: Colors.white),
                      )),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
