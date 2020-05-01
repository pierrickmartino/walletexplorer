class TransactionType {
  String id;
  String code;
  String label;
  String icon;
  bool active;

  TransactionType({this.id, this.code, this.label, this.icon, this.active});

  @override
  String toString() {
    return '{ ${this.code}, ${this.label}, ${this.icon}}';
  }

  TransactionType.fromMap(Map snapshot, String id)
      : id = id ?? '',
        code = snapshot['code'] ?? '',
        label = snapshot['label'] ?? '',
        icon = snapshot['icon'] ?? '',
        active = snapshot['active'] ?? '';

  toJson() {
    return {
      "code": code,
      "label": label,
      "icon": icon,
      "active": active,
    };
  }
}
