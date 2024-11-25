class CardInfo {
  String cardNumber;
  String cardHolderName;
  String expiryDate;
  String? cvv;

  CardInfo({
    required this.cardNumber,
    required this.cardHolderName,
    required this.expiryDate,
    this.cvv,
  });

  factory CardInfo.fromJson(Map<String, dynamic> json) {
    return CardInfo(
      cardNumber: json['card_number'],
      cardHolderName: json['card_holder_name'],
      expiryDate: json['expiry_date'],
      cvv: json['cvv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'card_number': cardNumber,
      'card_holder_name': cardHolderName,
      'expiry_date': expiryDate,
      'cvv': cvv,
    };
  }
}
