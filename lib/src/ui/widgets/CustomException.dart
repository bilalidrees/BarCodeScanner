import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:barcode_scanner/src/bloc/utility/AppConfig.dart';
import 'package:barcode_scanner/src/ui/ui_constants/theme/string.dart';


class CustomException extends StatefulWidget {
  @override
  _CustomExceptionState createState() => _CustomExceptionState();
}

class _CustomExceptionState extends State<CustomException> {


  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          top: AppConfig.of(context).appWidth(10),
          left: AppConfig.of(context).appWidth(7.4),
          right: AppConfig.of(context).appWidth(10),
          bottom: AppConfig.of(context).appWidth(7.4)),
      height: AppConfig.of(context).appWidth(25),
      width: double.infinity,
      decoration: BoxDecoration(
        color:
             Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Container(
        margin: EdgeInsets.only(
            right: AppConfig.of(context).appWidth(3),
            left: AppConfig.of(context).appWidth(3)),
        height: AppConfig.of(context).appWidth(13),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            "You haven't played recently...",
            style: Theme.of(context)
                .textTheme
                .headline2!
                .copyWith(fontSize: AppConfig.of(context).appWidth(6)),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
          ),
        ),
      ),
    );
  }
}
