import 'package:flutter/material.dart';
import 'package:barcode_scanner/src/ui/ui_constants/theme/style.dart';
import 'package:barcode_scanner/src/bloc/utility/AppConfig.dart';

import 'package:barcode_scanner/src/ui/ui_constants/theme/AppColors.dart';

class CustomBackButton extends StatelessWidget {

  CustomBackButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: Alignment.topCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: AppConfig.of(context).appWidth(2),
                  top: AppConfig.of(context).appWidth(2)),
              padding: EdgeInsets.only(
                left: AppConfig.of(context).appWidth(1),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey[600]!,
                    offset: Offset(4.0, 4.0),
                    blurRadius: 3.0,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-2.0, -2.0),
                    blurRadius: 3.0,
                  ),
                ],
              ),
              child: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Navigator.pop(context);
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
