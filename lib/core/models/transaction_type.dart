class TransactionType {
  String id;
  String code;
  String label;
  int active;

  TransactionType({this.id, this.code, this.label, this.active});

  @override
  String toString() {
    return '{ ${this.code}, ${this.label}}';
  }

  TransactionType.fromMap(Map snapshot, String id)
      : id = id ?? '',
        code = snapshot['code'] ?? '',
        label = snapshot['label'] ?? '',
        active = snapshot['active'] ?? 1;

  toJson() {
    return {
      "code": code,
      "label": label,
      "active": active,
    };
  }
}
