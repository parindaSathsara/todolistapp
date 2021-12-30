import 'package:animated_widgets/animated_widgets.dart';
import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final String? title, description, buttonText;
  final Image? image;

  CustomDialog({
    @required this.title,
    @required this.description,
    @required this.buttonText,
    @required this.image,
  });

  @override
  Widget build(BuildContext context) {
    dialogContent(BuildContext context) {
      return Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
              top: Consts.avatarRadius + Consts.padding,
              bottom: Consts.padding,
              left: Consts.padding,
              right: Consts.padding,
            ),
            margin: EdgeInsets.only(top: Consts.avatarRadius),
            decoration: new BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(Consts.padding),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: const Offset(0.0, 10.0),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, // To make the card compact
              children: <Widget>[
                Text(
                  title!,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 16.0),
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(height: 24.0),
                Align(
                  alignment: Alignment.center,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // To close the dialog
                    },
                    child: Text(buttonText!),
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            left: Consts.padding,
            right: Consts.padding,
            child: Image(
              image: AssetImage('assets/images/logo.png'),
              width: 140,
              height: 140,
            )
          ),


        ],
      );
    }


    return ScaleAnimatedWidget.tween(
      enabled: true,
      duration: Duration(milliseconds: 300),
      scaleDisabled: 0.5,
      scaleEnabled: 1,
      child: Dialog(

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Consts.padding),
        ),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        child: dialogContent(context),
      ),
    );


  }
}




class Consts {
  Consts._();

  static const double padding = 16.0;
  static const double avatarRadius = 66.0;
}