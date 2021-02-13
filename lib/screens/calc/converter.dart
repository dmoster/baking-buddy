import 'tspToReadableMeasurements.dart';
import 'ingredient.dart';

/// Get the converted amount of
dynamic getConvertedAmount(double valueToConvert, String fromType,
    String toType, Ingredient ingredient) {
  double toConversionFactor = getConversionFactor(toType, ingredient);
  double fromConversionFactor = getConversionFactor(fromType, ingredient);

  // Convert volume-based fromType to universal factor (c, T, tsp -> tsp)
  if (fromType == 'cups' ||
      fromType == 'tablespoons' ||
      fromType == 'teaspoons') {
    valueToConvert = getVolumeInTsp(valueToConvert, fromType);
    fromType = 'teaspoons';
  }

  // Calculate, convert to string, and return volume measurement
  if (toType == 'volume') {
    return getVolumeStr(calculateConversion(
        fromConversionFactor, toConversionFactor, valueToConvert));
  } else {
    // Calculate and return ounces or grams measurement
    return calculateConversion(
        fromConversionFactor, toConversionFactor, valueToConvert);
  }
}

/// Get a universal volume-based conversion factor
double getVolumeInTsp(double valueToConvert, String fromType) {
  if (fromType == 'cups') {
    return valueToConvert * 48;
  } else if (fromType == 'tablespoons') {
    return valueToConvert * 3;
  } else {
    return valueToConvert;
  }
}

/// Get the conversion factor for the specified ingredient
double getConversionFactor(String measurementType, Ingredient ingredient) {
  if (measurementType == 'ounces') {
    return double.parse(ingredient.ounces);
  } else if (measurementType == 'grams') {
    return double.parse(ingredient.grams);
  } else {
    return double.parse(ingredient.volume);
  }
}

/// Convert the amount from one unit to another
double calculateConversion(double fromConversionFactor,
    double toConversionFactor, double valueToConvert) {
  return toConversionFactor * valueToConvert / fromConversionFactor;
}
