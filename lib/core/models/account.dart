class Account {
  String id;
  double balance;
  String bank;
  String currency;
  String description;
  String evaluationDate;
  String product;
  String refIBAN;
  String relation;
  String short;
  bool active;

  Account(
      {this.id,
      this.balance,
      this.bank,
      this.currency,
      this.description,
      this.evaluationDate,
      this.product,
      this.refIBAN,
      this.relation,
      this.active});

  @override
  String toString() {
    return '{ ${this.balance}, ${this.bank}, ${this.currency}, ${this.description}, ${this.evaluationDate}, ${this.product}, ${this.refIBAN}, ${this.short}, ${this.relation}}';
  }

  @override
  Account.fromMap(Map snapshot, String id)
      : id = id ?? '',
        balance = snapshot['balance'] ?? 0.0,
        bank = snapshot['bank'] ?? '',
        currency = snapshot['currency'] ?? '',
        description = snapshot['description'] ?? '',
        evaluationDate = snapshot['evaluationDate'] ?? '',
        product = snapshot['product'] ?? '',
        refIBAN = snapshot['refIBAN'] ?? '',
        relation = snapshot['relation'] ?? '',
        short = snapshot['short'] ?? '',
        active = snapshot['active'] ?? '';

  toJson() {
    return {
      "balance": balance,
      "bank": bank,
      "currency": currency,
      "description": description,
      "evaluationDate": evaluationDate,
      "product": product,
      "refIBAN": refIBAN,
      "relation": relation,
      "short": short,
      "active": active,
    };
  }
}
