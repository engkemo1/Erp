class Item {
  int? id;
  int? itemId;
  String? itemNumber;
  int? unitNo;
  var currentPriceAfterTax;
  bool? autoBarcode;
  double? price;
  var wholesalePrice;
  var wholesale2xPrice;
  var  fourthPrice;
  var  fifthPrice;
  var sixthPrice;
  var seventhPrice;
  int? weight;
  int? conversionFactor;
  int? unitType;

  Item(
      {this.id,
        this.currentPriceAfterTax,
        this.itemId,
        this.itemNumber,
        this.unitNo,
        this.autoBarcode,
        this.price,
        this.wholesalePrice,
        this.wholesale2xPrice,
        this.fourthPrice,
        this.fifthPrice,
        this.sixthPrice,
        this.seventhPrice,
        this.weight,
        this.conversionFactor,
        this.unitType});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemId = json['item_id'];
    itemNumber = json['item_number'];
    unitNo = json['unit_no'];
    autoBarcode = json['auto_barcode'];
    currentPriceAfterTax=json['current_price_after_tax'];
    wholesalePrice = json['wholesale_price'];
    wholesale2xPrice = json['wholesale_2x_price'];
    fourthPrice = json['fourth_price'];
    fifthPrice = json['fifth_price'];
    sixthPrice = json['sixth_price'];
    seventhPrice = json['seventh_price'];
    weight = json['weight'];
    conversionFactor = json['conversion_factor'];
    unitType = json['unit_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['current_price_after_tax']=this.currentPriceAfterTax;
    data['item_id'] = this.itemId;
    data['item_number'] = this.itemNumber;
    data['unit_no'] = this.unitNo;
    data['auto_barcode'] = this.autoBarcode;
    data['price'] = this.price;
    data['wholesale_price'] = this.wholesalePrice;
    data['wholesale_2x_price'] = this.wholesale2xPrice;
    data['fourth_price'] = this.fourthPrice;
    data['fifth_price'] = this.fifthPrice;
    data['sixth_price'] = this.sixthPrice;
    data['seventh_price'] = this.seventhPrice;
    data['weight'] = this.weight;
    data['conversion_factor'] = this.conversionFactor;
    data['unit_type'] = this.unitType;
    return data;
  }
}