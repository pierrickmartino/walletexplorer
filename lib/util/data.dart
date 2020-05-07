import 'dart:math';
import 'package:charts_flutter/flutter.dart' as charts;

import '../ui/widgets/transactionTest.dart';

Random random = Random();
List names = [
  "Ling Waldner",
  "Gricelda Barrera",
  "Lenard Milton",
  "Bryant Marley",
  "Rosalva Sadberry",
  "Guadalupe Ratledge",
  "Brandy Gazda",
  "Kurt Toms",
  "Rosario Gathright",
  "Kim Delph",
  "Stacy Christensen",
];

List types = ["recieved", "sent"];

List assets = [
  {
    "icon": "asset_icon.png",
    "name": "Account 1",
    "alt": "NNN",
    "rate": 10297.66,
    "currency": "CHF",
    "depositary": "Bank 1",
    "color": charts.MaterialPalette.blue.shadeDefault,
  },
  {
    "icon": "asset_icon.png",
    "name": "Account 2",
    "alt": "NOV",
    "rate": 215.56,
    "currency": "CHF",
    "depositary": "Bank 1",
    "color": charts.MaterialPalette.blue.shadeDefault,
  },
  {
    "icon": "asset_icon.png",
    "name": "Account 3",
    "alt": "ROC",
    "rate": 0.32,
    "currency": "CHF",
    "depositary": "Bank 2",
    "color": charts.MaterialPalette.blue.shadeDefault,
  },
  {
    "icon": "asset_icon.png",
    "name": "Account 4",
    "alt": "LTC",
    "rate": 94.29,
    "currency": "CHF",
    "depositary": "Bank 4",
    "color": charts.MaterialPalette.blue.shadeDefault,
  },
  {
    "icon": "asset_icon.png",
    "name": "Account 5",
    "alt": "UBS",
    "rate": 82.57,
    "currency": "CHF",
    "depositary": "Bank 5",
    "color": charts.MaterialPalette.blue.shadeDefault,
  },
];

List coins = [
  {
    "icon": "assets/btc.png",
    "name": "Bitcoin",
    "alt": "BTC",
    "rate": r"$10,297.66",
    "color": charts.MaterialPalette.deepOrange.shadeDefault,
  },
  {
    "icon": "assets/eth.png",
    "name": "Etherium",
    "alt": "ETH",
    "rate": r"$215.56",
    "color": charts.MaterialPalette.blue.shadeDefault,
  },
  {
    "icon": "assets/xrp.png",
    "name": "Ripple",
    "alt": "XRP",
    "rate": r"$0.32",
    "color": charts.MaterialPalette.indigo.shadeDefault,
  },
  {
    "icon": "assets/ltc.png",
    "name": "Litecoin",
    "alt": "LTC",
    "rate": r"$94.29",
    "color": charts.MaterialPalette.gray.shadeDefault,
  },
  {
    "icon": "assets/xmr.png",
    "name": "Monero",
    "alt": "XMR",
    "rate": r"$82.57",
    "color": charts.MaterialPalette.red.shadeDefault,
  },
];

List<ObjecTest> transactions = new List<ObjecTest>.generate(100, (index) {
  return ObjecTest(
    name: names[random.nextInt(10)],
    date: "${random.nextInt(31).toString().padLeft(2, "0")}"
        "/${random.nextInt(12).toString().padLeft(2, "0")}/2019",
    amount: "\$${random.nextInt(1000).toString()}",
    type: types[random.nextInt(2)],
    dp: "assets/cm${random.nextInt(10)}.jpeg",
  );
});
