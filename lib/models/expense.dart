import 'dart:convert';

class Expense {
  final String? id;
  final String resource;
  final int amount;
  final DateTime date;
  final String isIncome;
  final String? imgPath;

  Expense({
    this.id,
    required this.resource,
    required this.amount,
    required this.date,
    required this.isIncome,
    this.imgPath,
  });

  Expense copyWith({
    String? id,
    String? resource,
    int? amount,
    DateTime? date,
    String? isIncome,
  }) {
    return Expense(
      id: id ?? this.id,
        resource: resource ?? this.resource,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      isIncome: isIncome ?? this.isIncome,
      imgPath: imgPath ?? this.imgPath


    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'resource': resource,
      'amount': amount,
      'date': date,
      'isIncome': isIncome,
    };
  }

  factory Expense.fromMap(Map<String, dynamic> map) {
    return Expense(
      id: map['id'],
      resource: map['resource'],
      amount: map['amount'],
      date: map['date'],
      isIncome: map['isIncome'],
      imgPath: map['imgPath'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Expense.fromJson(String source) =>
      Expense.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Expense(id: $id, resource: $resource, amount: $amount, date: $date, isIncome: $isIncome)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Expense &&
        other.id == id &&
        other.resource == resource &&
        other.amount == amount &&
        other.date == date &&
        other.isIncome == isIncome;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    resource.hashCode ^
    amount.hashCode ^
    date.hashCode ^
    isIncome.hashCode;
  }
}