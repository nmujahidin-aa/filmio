import '../constants/app_constants.dart';

class PriceCalculator {
  static int calculate(int days) {
    return days * AppConstants.rentalPricePerDay;
  }
}