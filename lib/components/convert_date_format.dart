import 'package:intl/intl.dart';

String convertDateFormat(String inputDate) {
  DateTime tempDate = DateFormat('yyyy-MM-dd').parse(inputDate);

  String outputDate = "";
  if (tempDate.month > 10) {
    outputDate = DateFormat('dd-TMM-yyyy').format(tempDate);
  } else {
    outputDate = DateFormat('dd-TM-yyyy').format(tempDate);
  }
  return outputDate;
}
