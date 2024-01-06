import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        webPosition: "center",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2);
  }
}
