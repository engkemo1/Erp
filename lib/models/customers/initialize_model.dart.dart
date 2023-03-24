import '../selected_bottom_sheet_model/Areas.dart';
import '../selected_bottom_sheet_model/Branches.dart';
import '../selected_bottom_sheet_model/Currencies.dart';
import '../selected_bottom_sheet_model/PayType.dart';
import '../selected_bottom_sheet_model/SalesTypes.dart';
import '../selected_bottom_sheet_model/sales_men_model.dart';


class InitializeModel{
  InitializeModel({
    this.areas,
    this.branches,
    this.currencies,
    this.payTypes,
    this.salesmen,
    this.salesTypes,
});
  List<Area>? areas;
  List<Branch>? branches;
  List<Currency>? currencies;
  List<PayType>? payTypes;
  List<Salesman>? salesmen;
  List<SalesType>? salesTypes;


  factory InitializeModel.fromJson(Map<String, dynamic> json) => InitializeModel(
    areas: List<Area>.from(json["areas"].map((x) => Area.fromJson(x))),
    branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
    currencies: List<Currency>.from(json["currencies"].map((x) => Currency.fromJson(x))),
    payTypes: List<PayType>.from(json["payTypes"].map((x) => PayType.fromJson(x))),
    salesmen: List<Salesman>.from(json["salesmen"].map((x) => Salesman.fromJson(x))),
    salesTypes: List<SalesType>.from(json["salesTypes"].map((x) => SalesType.fromJson(x))),



  );
}