// To parse this JSON data, do
//
//     final currencies = currenciesFromJson(jsonString);

import 'dart:convert';

Currencies currenciesFromJson(String str) => Currencies.fromJson(json.decode(str));

String currenciesToJson(Currencies data) => json.encode(data.toJson());

class Currencies {
    Currencies({
        required this.currencies,
    });

    List<Currency> currencies;

    factory Currencies.fromJson(Map<String, dynamic> json) => Currencies(
        currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "currencies": List<dynamic>.from(currencies.map((x) => x.toJson())),
    };
}

class Currency {
    Currency({
        this.id,
        this.nameAr,
        this.nameEn,
        this.coinTransfer,
        this.shortcutName,
        this.coinExchange,
        this.coinDefault,
        this.coinSign,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    String? nameAr;
    String? nameEn;
    double? coinTransfer;
    String? shortcutName;
    String? coinExchange;
    bool ?coinDefault;
    String? coinSign;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        id: json["id"],
        nameAr: json["name_ar"],
        nameEn: json["name_en"],
        coinTransfer: json["coin_transfer"].toDouble(),
        shortcutName: json["shortcut_name"],
        coinExchange: json["coin_exchange"],
        coinDefault: json["coin_default"],
        coinSign: json["coin_sign"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name_ar": nameAr,
        "name_en": nameEn,
        "coin_transfer": coinTransfer,
        "shortcut_name": shortcutName,
        "coin_exchange": coinExchange,
        "coin_default": coinDefault,
        "coin_sign": coinSign,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
