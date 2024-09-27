import 'dart:convert';

class Beneficiary {
  final String nickName;
  final String phone;
  final double balanceUsed;
  final DateTime timeOfTransaction;

  Beneficiary({
    required this.nickName,
    required this.phone,
    required this.balanceUsed,
    required this.timeOfTransaction,
  });

  factory Beneficiary.fromRawJson(String str) =>
      Beneficiary.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Beneficiary.fromJson(Map<String, dynamic> json) => Beneficiary(
        nickName: json["nickName"],
        phone: json["phone"],
        balanceUsed: json["balance_used"] ?? 0.0,
        timeOfTransaction: json["transaction_time"] ?? DateTime.now(),
      );

  Map<String, dynamic> toJson() => {
        "nickName": nickName,
        "phone": phone,
        "balance_used": balanceUsed,
      };
}
