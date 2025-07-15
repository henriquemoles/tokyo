import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class TokyoUtils {
  final currencyBrazil = NumberFormat("R\$#,##0.00", "pt_BR");
  DateFormat brazilianPatternMonthName = DateFormat('dd MMMM yyyy', 'pt_BR');
  DateFormat brazilianPattern = DateFormat('dd/MM/yyyy', 'pt_BR');

  final cpfMaskFormatter = MaskTextInputFormatter(
    mask: '###.###.###-##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  String stringToDateWithMonthNamed(String dateInString) {
    DateTime dateTime = DateTime.parse(dateInString);
    String formattedDate = brazilianPatternMonthName.format(dateTime);
    return formattedDate;
  }

  String stringToBRDate(String dateInString) {
    DateTime dateTime = DateTime.parse(dateInString);
    String formattedDate = brazilianPattern.format(dateTime);
    return formattedDate;
  }

  String convertingStringToCurrency(String? number) {
    if (number == null || !number.contains(RegExp(r'[\d+]'))) {
      return currencyBrazil.format(double.parse("0"));
    } else {
      final value = number.replaceAll(RegExp(r'[^0-9.]'), '');
      return currencyBrazil.format(double.parse(value));
    }
  }

  String? convertTopPercentageAliquote(dynamic input) {
    if (input == null || input == "null") {
      return '';
    } else {
      // Convert the string to a double
      double value = double.parse(input.toString());
      // Convert the double to a percentage string
      String percentageString = "${(value * 100).toStringAsFixed(1)}%";
      return percentageString;
    }
  }
}
