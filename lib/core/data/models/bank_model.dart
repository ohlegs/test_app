import 'dart:convert';

class Banks {
  final String? bankName;
  final String? creditName;
  final double? interestRate;
  final int? maxAmount;
  final int? maxTerm;

  Banks({
    this.bankName,
    this.creditName,
    this.interestRate,
    this.maxAmount,
    this.maxTerm,
  });

  Banks copyWith({
    String? bankName,
    String? creditName,
    double? interestRate,
    int? maxAmount,
    int? maxTerm,
  }) => Banks(
    bankName: bankName ?? this.bankName,
    creditName: creditName ?? this.creditName,
    interestRate: interestRate ?? this.interestRate,
    maxAmount: maxAmount ?? this.maxAmount,
    maxTerm: maxTerm ?? this.maxTerm,
  );

  factory Banks.fromRawJson(String str) => Banks.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Banks.fromJson(Map<String, dynamic> json) => Banks(
    bankName: json["bankName"],
    creditName: json["creditName"],
    interestRate: json["interestRate"]?.toDouble(),
    maxAmount: json["maxAmount"],
    maxTerm: json["maxTerm"],
  );

  Map<String, dynamic> toJson() => {
    "bankName": bankName,
    "creditName": creditName,
    "interestRate": interestRate,
    "maxAmount": maxAmount,
    "maxTerm": maxTerm,
  };
}
