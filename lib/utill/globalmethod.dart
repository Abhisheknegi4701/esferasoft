
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../helper/responsive_helper.dart';

sendTo(BuildContext context, Widget widget){
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => widget));
}

sendToForever(BuildContext context, Widget widget){
  Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => widget), (route) => false);
}

errorDialog(BuildContext context, String error){
  showDialog(
      context: context,
      builder: (BuildContext context){
        return Dialog(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            padding: const EdgeInsets.only(
              top: 15,
              bottom: 15,
              left: 10,
              right: 10,
            ),
            margin: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0.0, 10.0),
                ),
              ],
            ),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "Error",
                    style: const TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(
                      error,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ResponsiveHelper.isMobile(context)? 16 : 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop(); // To close the dialog
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green
                        ),
                          child: Center(child: Text("Ok", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),))),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
  );
}

showPrint(String title, dynamic message){
  print("$title  =>=>   $message");
}

showToast(String message){
  Fluttertoast.showToast(
      backgroundColor: Colors.white,
      textColor: Colors.black,
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER);
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}








