import 'package:url_launcher/url_launcher.dart';

final extension = Extension.function;

class Extension {
  static Extension get function => Extension._();
  Extension._();

  String digitConversion(var value) {
    if (value == null) return '';
    return value
        .toString()
        .replaceAll("0", "০")
        .replaceAll("1", "১")
        .replaceAll("2", "২")
        .replaceAll("3", "৩")
        .replaceAll("4", "৪")
        .replaceAll("5", "৫")
        .replaceAll("6", "৬")
        .replaceAll("7", "৭")
        .replaceAll("8", "৮")
        .replaceAll("9", "৯");
  }

  Future<void> launchCaller(String phone) async {
    var url = "tel:$phone";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
