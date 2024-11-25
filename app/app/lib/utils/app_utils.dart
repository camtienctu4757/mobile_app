import 'package:intl/intl.dart';

class AppUtils {
  const AppUtils._();
  // Example:
  // static String mapGenderToText(Gender gender) {
  //   switch (gender) {
  //     case Gender.unknown:
  //       return '';
  //     case Gender.male:
  //       return S.current.re1_male;
  //     case Gender.female:
  //       return S.current.re1_female;
  //     case Gender.other:
  //       return S.current.re1_other;
  //   }
  // }
  static String formatCurrency(double amount) {
    final formatCurrency = NumberFormat.simpleCurrency(locale: 'vi_VN');
    return formatCurrency.format(amount);
  }

  static String formatDate(DateTime date) {
    String result_day = AppUtils.formatdayofweek(date);
    result_day += "ngày " +
        date.day.toString() +
        " tháng " +
        date.month.toString() +
        " năm " +
        date.year.toString();
    return result_day;
  }

  static String formatdayofweek(DateTime day) {
    switch (day.weekday) {
      case 1:
        return " Thứ 2, ";
      case 6:
        return "Thứ 7, ";
      case 7:
        return "Chủ nhật, ";
      default:
        return "Thứ " + (day.weekday + 1).toString() + ", ";
    }
  }

  static String formattime(DateTime date) {
    return date.hour.toString() + ":" + date.minute.toString();
  }
}
