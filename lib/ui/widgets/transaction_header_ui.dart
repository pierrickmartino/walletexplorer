import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../../core/models/transaction.dart';

class TransactionHeaderUI extends StatefulWidget {
  final Transaction transaction;

  TransactionHeaderUI({this.transaction});

  @override
  _TransactionHeaderState createState() => _TransactionHeaderState();
}

class _TransactionHeaderState extends State<TransactionHeaderUI> {
  NumberFormat numberFormat =
      NumberFormat.currency(locale: 'de_CH', symbol: '', decimalDigits: 2);

  IconData getIconDataByCode(String transactionTypeCode) {
    switch (transactionTypeCode) {
      case 'bankFees':
        {
          return MaterialCommunityIcons.bank_minus;
        }
        break;
      case 'carTransport':
        {
          return MaterialCommunityIcons.car_back;
        }
        break;
      case 'communicationMedia':
        {
          return MaterialCommunityIcons.cellphone_link;
        }
        break;
      case 'health':
        {
          return MaterialCommunityIcons.pharmacy;
        }
        break;
      case 'household':
        {
          return MaterialCommunityIcons.cart;
        }
        break;
      case 'housingEnergy':
        {
          return MaterialCommunityIcons.home_city;
        }
        break;
      case 'leisureSport':
        {
          return MaterialCommunityIcons.soccer;
        }
        break;
      case 'otherExpenses':
        {
          return MaterialCommunityIcons.credit_card_minus;
        }
        break;
      case 'personalExpenses':
        {
          return MaterialCommunityIcons.account;
        }
        break;
      case 'savingsInvestments':
        {
          return MaterialCommunityIcons.piggy_bank;
        }
        break;
      case 'taxesCharges':
        {
          return MaterialCommunityIcons.book_minus_multiple;
        }
        break;
      case 'vacationTravel':
        {
          return MaterialCommunityIcons.beach;
        }
        break;
      case 'withdrawal':
        {
          return MaterialCommunityIcons.minus_circle;
        }
        break;
      case 'capitalIncome':
        {
          return MaterialCommunityIcons.note_plus;
        }
        break;
      case 'deposit':
        {
          return MaterialCommunityIcons.plus_circle;
        }
        break;
      case 'donationInheritance':
        {
          return MaterialCommunityIcons.wallet_giftcard;
        }
        break;
      case 'familyAllowances':
        {
          return MaterialCommunityIcons.account_group;
        }
        break;
      case 'loan':
        {
          return MaterialCommunityIcons.swap_vertical_variant;
        }
        break;
      case 'otherIncome':
        {
          return MaterialCommunityIcons.filter_plus;
        }
        break;
      case 'refund':
        {
          return MaterialCommunityIcons.cash_refund;
        }
        break;
      case 'salesThings':
        {
          return MaterialCommunityIcons.sale;
        }
        break;
      case 'wagesIncome':
        {
          return MaterialCommunityIcons.briefcase_plus;
        }
        break;
      case 'internalTransfer':
        {
          return MaterialCommunityIcons.swap_horizontal;
        }
      case 'familyChildren':
        {
          return MaterialCommunityIcons.human_child;
        }
      case 'unknown':
        {
          return Icons.zoom_in;
        }
        break;
      default:
        {
          return Icons.zoom_in;
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: <Widget>[
            Icon(
              getIconDataByCode(widget.transaction.type),
              size: 30,
              color: widget.transaction.type == ""
                  ? Color(0xffE0FF4F)
                  : widget.transaction.debitAmount > 0
                      ? Theme.of(context).bottomAppBarColor
                      : Theme.of(context).accentColor,
            ),
            SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(widget.transaction.description1,
                    style: TextStyle(
                      fontSize: 12,
                    )),
                Text(widget.transaction.description2,
                    style: TextStyle(
                      fontSize: 12,
                    )),
                Text(widget.transaction.description3,
                    style: TextStyle(
                      fontSize: 12,
                    )),
              ],
            ),
            // Text(
            // widget.transaction.description2 == ""
            //     ? (widget.transaction.description1.length < 23
            //         ? widget.transaction.description1
            //         : widget.transaction.description1.substring(0, 23))
            //     : (widget.transaction.description2.length < 23
            //         ? widget.transaction.description2
            //         : widget.transaction.description2.substring(0, 23)),
            // style: TextStyle(
            //   fontSize: 12,
            // )),
            Spacer(),
            Text(
              widget.transaction.debitAmount > 0
                  ? "- ${numberFormat.format(widget.transaction.debitAmount)}"
                  : "+ ${numberFormat.format(widget.transaction.creditAmount)}",
              style: TextStyle(
                color: widget.transaction.debitAmount > 0
                    ? Theme.of(context).bottomAppBarColor
                    : Theme.of(context).accentColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
