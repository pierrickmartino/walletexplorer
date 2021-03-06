class Statistic {
  String id;
  String code;
  double credit;
  double debit;
  String year;
  String month;
  String quarter;
  String bank;
  String currency;
  String product;
  String relation;
  int counter;
  DateTime lastUpdatedDate;

  Statistic(
      {this.id,
      this.code,
      this.credit,
      this.debit,
      this.year,
      this.month,
      this.quarter,
      this.bank,
      this.currency,
      this.product,
      this.relation,
      this.counter,
      this.lastUpdatedDate});

  @override
  String toString() {
    return '{ ${this.code}, ${this.debit}, ${this.year}, ${this.month}, ${this.quarter}, ${this.bank}, ${this.currency}, ${this.product}, ${this.relation}, ${this.counter}, ${this.lastUpdatedDate}}';
  }

  @override
  Statistic.fromMap(Map snapshot, String id)
      : id = id ?? '',
        code = snapshot['code'] ?? '',
        credit = snapshot['credit'] ?? 0.0,
        debit = snapshot['debit'] ?? 0.0,
        year = snapshot['year'] ?? '',
        month = snapshot['month'] ?? '',
        quarter = snapshot['quarter'] ?? '',
        bank = snapshot['bank'] ?? '',
        currency = snapshot['currency'] ?? '',
        product = snapshot['product'] ?? '',
        relation = snapshot['relation'] ?? '',
        counter = snapshot['counter'] ?? 0,
        lastUpdatedDate = (snapshot['lastUpdatedDate']).toDate();

  toJson() {
    return {
      "code": code,
      "credit": credit,
      "debit": debit,
      "year": year,
      "month": month,
      "quarter": quarter,
      "bank": bank,
      "currency": currency,
      "product": product,
      "relation": relation,
      "counter": counter,
      "lastUpdatedDate": lastUpdatedDate,
    };
  }
}
