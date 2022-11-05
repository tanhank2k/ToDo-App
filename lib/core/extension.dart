import 'package:intl/intl.dart';

extension FormatString on String {
  String parseVietnamese() {
    String str = this;
    str = str.replaceAll(RegExp(r"à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ"), "a");
    str = str.replaceAll(RegExp(r"è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ"), "e");
    str = str.replaceAll(RegExp(r"ì|í|ị|ỉ|ĩ"), "i");
    str = str.replaceAll(RegExp(r"ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ"), "o");
    str = str.replaceAll(RegExp(r"ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ"), "u");
    str = str.replaceAll(RegExp(r"ỳ|ý|ỵ|ỷ|ỹ"), "y");
    str = str.replaceAll(RegExp(r"đ"), "d");
    return str;
  }
}

extension FormatDateTime on DateTime? {
  String format(String newPattern) {
    return this == null ? '' : DateFormat(newPattern).format(this!);
  }

  String formatDateAndTimeToString() {
    return this == null ? '' : DateFormat('HH:mm dd/MM/yyyy').format(this!);
  }

  String formatDateToString() {
    return this == null ? '' : DateFormat('dd/MM/yyyy').format(this!);
  }

  String formatWeekDay() {
    if (this == null) return '';
    int weekDay = this!.weekday;
    String weekDateConverted = weekDay < 7 ? 'T.${weekDay + 1}' : 'CN';
    return '$weekDateConverted, ${this!.day.toString().padLeft(2, '0')} Th ${this!.month.toString().padLeft(2, '0')}, ${this!.year}';
  }
}

extension CheckData<T> on T {
  bool isNullOrEmpty() {
    return this == null || this == '' || this == 'null' || this == {} || this == ' ' ? true : false;
  }

  bool isNotNullEmpty() {
    return this == null || this == '' || this == 'null' || this == {} || this == ' ' ? false : true;
  }

  bool isListNotNullOrEmpty() {
    if (this != null && this is List && (this as List).isNotEmpty) return true;
    return false;
  }
}
