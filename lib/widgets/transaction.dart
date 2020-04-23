class Transaction {
  final String name;
  final String date;
  final String amount;
  final String type;
  final String dp;

  final int transactionId;
  final String evaluationDate;
  final String relation;
  final String product;
  final String refIBAN;
  final String currency;
  final String dateFrom;
  final String dateTo;
  final String description;
  final String transactionDate;
  final String accountingDate;
  final String valueDate;
  final String description1;
  final String description2;
  final String description3;
  final String exchangeRate;
  final String subAmount;
  final String debitAmount;
  final String creditAmount;
  final String balance;
  
  Transaction({
    this.name, 
    this.date, 
    this.amount, 
    this.type, 
    this.dp,
    
    this.transactionId,
    this.evaluationDate,
    this.relation,
    this.product,
    this.refIBAN,
    this.currency,
    this.dateFrom,
    this.dateTo,
    this.description,
    this.transactionDate,
    this.accountingDate,
    this.valueDate,
    this.description1,
    this.description2,
    this.description3,
    this.exchangeRate,
    this.subAmount,
    this.debitAmount,
    this.creditAmount,
    this.balance, });
}

