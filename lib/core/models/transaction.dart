class Transaction {
  String id;
  String accountingDate;
  String balance;
  double creditAmount;
  String dateFrom;
  String dateTo;
  double debitAmount;
  String description;
  String description1;
  String description2;
  String description3;
  String evaluationDate;
  String exchangeRate;
  String product;
  String refIBAN;
  String relation;
  String subAmount;
  String transactionDate;
  String valueDate;
  String type;
  String icon;

  Transaction(
      {this.id,
      this.accountingDate,
      this.balance,
      this.creditAmount,
      this.dateFrom,
      this.dateTo,
      this.debitAmount,
      this.description,
      this.description1,
      this.description2,
      this.description3,
      this.evaluationDate,
      this.exchangeRate,
      this.product,
      this.refIBAN,
      this.relation,
      this.subAmount,
      this.transactionDate,
      this.valueDate,
      this.type,
      this.icon});

  @override
  String toString() {
    return '{ ${this.accountingDate}, ${this.balance}, ${this.creditAmount}, ${this.dateFrom}, ${this.dateTo}, ${this.debitAmount}, ${this.description}, ${this.description1}, ${this.description2}, ${this.description3}, ${this.evaluationDate}, ${this.exchangeRate}, ${this.product}, ${this.refIBAN}, ${this.relation}, ${this.subAmount}, ${this.transactionDate}, ${this.valueDate}, ${this.type}, ${this.icon}}';
  }

  @override
  Transaction.fromMap(Map snapshot, String id)
      : id = id ?? '',
        accountingDate = snapshot['accountingDate'] ?? '',
        balance = snapshot['balance'] ?? '',
        creditAmount = snapshot['creditAmount'] ?? '',
        dateFrom = snapshot['dateFrom'] ?? '',
        dateTo = snapshot['dateTo'] ?? '',
        debitAmount = snapshot['debitAmount'] ?? '',
        description = snapshot['description'] ?? '',
        description1 = snapshot['description1'] ?? '',
        description2 = snapshot['description2'] ?? '',
        description3 = snapshot['description3'] ?? '',
        evaluationDate = snapshot['evaluationDate'] ?? '',
        exchangeRate = snapshot['exchangeRate'] ?? '',
        product = snapshot['product'] ?? '',
        refIBAN = snapshot['refIBAN'] ?? '',
        relation = snapshot['relation'] ?? '',
        subAmount = snapshot['subAmount'] ?? '',
        transactionDate = snapshot['transactionDate'] ?? '',
        valueDate = snapshot['valueDate'] ?? '',
        type = snapshot['type'] ?? '',
        icon = snapshot['icon'] ?? '';

  toJson() {
    return {
      "accountingDate": accountingDate,
      "balance": balance,
      "creditAmount": creditAmount,
      "dateFrom": dateFrom,
      "dateTo": dateTo,
      "debitAmount": debitAmount,
      "description": description,
      "description1": description1,
      "description2": description2,
      "description3": description3,
      "evaluationDate": evaluationDate,
      "exchangeRate": exchangeRate,
      "product": product,
      "refIBAN": refIBAN,
      "relation": relation,
      "subAmount": subAmount,
      "transactionDate": transactionDate,
      "valueDate": valueDate,
      "type": type,
      "icon": icon,
    };
  }
}
