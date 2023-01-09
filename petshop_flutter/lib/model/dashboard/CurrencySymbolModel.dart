class CurrencySymbolModel {
  String? currency;
  String? currency_symbol;

  CurrencySymbolModel({this.currency, this.currency_symbol});

  factory CurrencySymbolModel.fromJson(Map<String, dynamic> json) {
    return CurrencySymbolModel(
      currency: json['currency'],
      currency_symbol: json['currency_symbol'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currency'] = this.currency;
    data['currency_symbol'] = this.currency_symbol;
    return data;
  }
}
