import 'cash receipt model/cash_receipt_model.dart';

class Bonds {
  List<Null>? rows;
  int? count;
  String? finalBalance;
  String? finalBalanceText;
  String? chequeAmount;
  List<Cheques>? cheques;
  String? balanceState;

  Bonds(
      {this.rows,
        this.count,
        this.finalBalance,
        this.finalBalanceText,
        this.chequeAmount,
        this.cheques,
        this.balanceState});

  Bonds.fromJson(Map<String, dynamic> json) {
    // if (json['rows'] != null) {
    //   rows = <Null>[];
    //   json['rows'].forEach((v) {
    //     rows!.add(new Null.fromJson(v));
    //   });
    // }
    count = json['count'];
    finalBalance = json['finalBalance'];
    finalBalanceText = json['finalBalanceText'];
    chequeAmount = json['chequeAmount'];
    if (json['cheques'] != null) {
      cheques = <Cheques>[];
      json['cheques'].forEach((v) {
        cheques!.add(new Cheques.fromJson(v));
      });
    }
    balanceState = json['balanceState'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.rows != null) {
    //   data['rows'] = this.rows!.map((v) => v!.toJson()).toList();
    // }
    data['count'] = this.count;
    data['finalBalance'] = this.finalBalance;
    data['finalBalanceText'] = this.finalBalanceText;
    data['chequeAmount'] = this.chequeAmount;
    if (this.cheques != null) {
      data['cheques'] = this.cheques!.map((v) => v.toJson()).toList();
    }
    data['balanceState'] = this.balanceState;
    return data;
  }
}
