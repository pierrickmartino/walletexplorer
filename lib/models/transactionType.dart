class TransactionType {
  final String code;
  final String label;
  final String icon;

  TransactionType({this.code, this.label, this.icon});

  @override
  String toString() {
    return '{ ${this.code}, ${this.label}, ${this.icon}}';
  }
}
