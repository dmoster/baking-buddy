/// Volume Measurement Converter

/// This module allows for conversion of various volume measurements.

class Measurement {
  String amtLabel;
  String unit;
  String abbr;
  double valueInTsp;

  Measurement(this.amtLabel, this.unit, this.abbr, this.valueInTsp);

  String shortName() {
    return this.amtLabel;
  }

  String longName() {
    return this.amtLabel + ' ' + this.abbr;
  }
}

// Teaspoon = 1

// Teaspoons
final Measurement teaspoon = Measurement('1', 'teaspoon', 'tsp', 1);
final Measurement threeQuarterTsp = Measurement('3/4', 'teaspoon', 'tsp', 0.75);
final Measurement halfTsp = Measurement('1/2', 'teaspoon', 'tsp', 0.5);
final Measurement quarterTsp = Measurement('1/4', 'teaspoon', 'tsp', 0.25);
final Measurement eighthTsp = Measurement('1/8', 'teaspoon', 'tsp', 0.125);

// Tablespoons
final Measurement tablespoon = Measurement('1', 'tablespoon', 'T', 3);
final Measurement threeQuarterTbsp =
    Measurement('3/4', 'tablespoon', 'T', 2.25);
//final Measurement halfTbsp = Measurement('1/2', 'tablespoon', 'T', 1.5);

// Cups
final Measurement cup = Measurement('1', 'cup', 'c', 48);
final Measurement threeQuarterCup = Measurement('3/4', 'cup', 'c', 36);
final Measurement twoThirdCup = Measurement('2/3', 'cup', 'c', 32);
final Measurement halfCup = Measurement('1/2', 'cup', 'c', 24);
final Measurement thirdCup = Measurement('1/3', 'cup', 'c', 16);
final Measurement quarterCup = Measurement('1/4', 'cup', 'c', 12);
final Measurement eighthCup = Measurement('1/8', 'cup', 'c', 6);

String getVolumeStr(valueInTsp) {
  String measurementStr = '';
  int numCups = 0;
  int numTbsp = 0;
  int numTsp = 0;

  // Cups
  while (valueInTsp >= cup.valueInTsp) {
    ++numCups;
    valueInTsp -= cup.valueInTsp;
  }

  measurementStr = numCups > 0 ? numCups.toString() + ' ' : '';

  if (valueInTsp >= threeQuarterCup.valueInTsp) {
    measurementStr += threeQuarterCup.longName() + ' ';
    valueInTsp -= threeQuarterCup.valueInTsp;
  } else if (valueInTsp >= twoThirdCup.valueInTsp) {
    measurementStr += twoThirdCup.longName() + ' ';
    valueInTsp -= twoThirdCup.valueInTsp;
  } else if (valueInTsp >= halfCup.valueInTsp) {
    measurementStr += halfCup.longName() + ' ';
    valueInTsp -= halfCup.valueInTsp;
  } else if (valueInTsp >= thirdCup.valueInTsp) {
    measurementStr += thirdCup.longName() + ' ';
    valueInTsp -= thirdCup.valueInTsp;
  } else if (valueInTsp >= thirdCup.valueInTsp) {
    measurementStr += thirdCup.longName() + ' ';
    valueInTsp -= thirdCup.valueInTsp;
  } else if (valueInTsp >= quarterCup.valueInTsp) {
    measurementStr += quarterCup.longName() + ' ';
    valueInTsp -= quarterCup.valueInTsp;
  } else if (valueInTsp >= eighthCup.valueInTsp) {
    measurementStr += eighthCup.longName() + ' ';
    valueInTsp -= eighthCup.valueInTsp;
  } else if (numCups > 0) {
    measurementStr += cup.abbr + ' ';
  }

  // Tablespoons
  while (valueInTsp >= tablespoon.valueInTsp) {
    ++numTbsp;
    valueInTsp -= tablespoon.valueInTsp;
  }

  measurementStr += numTbsp > 0 ? numTbsp.toString() + ' ' : '';

  if (valueInTsp > threeQuarterTbsp.valueInTsp) {
    measurementStr += threeQuarterTbsp.longName() + ' ';
    valueInTsp -= threeQuarterTbsp.valueInTsp;
  }
  // else if (valueInTsp >= halfTbsp.valueInTsp) {
  //   measurementStr += halfTbsp.longName() + ' ';
  //   valueInTsp -= halfTbsp.valueInTsp;
  // }
  else if (numTbsp > 0) {
    measurementStr += tablespoon.abbr + ' ';
  }

  // Teaspoons
  while (valueInTsp >= teaspoon.valueInTsp) {
    ++numTsp;
    valueInTsp -= teaspoon.valueInTsp;
  }

  measurementStr += numTsp > 0 ? numTsp.toString() + ' ' : '';

  if (valueInTsp > threeQuarterTsp.valueInTsp) {
    measurementStr += threeQuarterTsp.longName();
    valueInTsp -= threeQuarterTsp.valueInTsp;
  } else if (valueInTsp >= halfTsp.valueInTsp) {
    measurementStr += halfTsp.longName();
    valueInTsp -= halfTsp.valueInTsp;
  } else if (valueInTsp >= quarterTsp.valueInTsp) {
    measurementStr += quarterTsp.longName();
    valueInTsp -= quarterTsp.valueInTsp;
  } else if (numTsp > 0) {
    measurementStr += teaspoon.abbr;
  }

  return measurementStr;

  //console.log(`You have ${ measurementStr }of your ingredient.`);
}

void main() {
  print(getVolumeStr(48)); // 1 c
  print(getVolumeStr(33.5)); // 2/3 c 1 1/2 tsp
  print(getVolumeStr(60)); // 1 1/4 c
  print(getVolumeStr(3)); // 1 T
  print(getVolumeStr(120)); // 2 1/2 c
  print(getVolumeStr(52)); // 1 c 1 T 1 tsp
}
