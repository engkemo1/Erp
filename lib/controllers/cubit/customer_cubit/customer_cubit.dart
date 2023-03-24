import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../../../api_helper/remote/api_base_helper.dart';
import '../../../models/Customers/customer_id_model.dart';
import '../../../models/Customers/initialize_model.dart.dart';
import '../../../models/account_statment_model/bonds_initialize_model.dart';
import '../../../models/bonds_model.dart';
import '../../../models/customers/create_customer_model.dart';
import '../../../models/selected_bottom_sheet_model/bank_model.dart';
import '../../../models/user/coordinates_model.dart';
import '../../../models/user/user.dart';
import '../../../utils/constants.dart';
import 'customer_state.dart';

class CustomerCubit extends Cubit<CustomerMainState> {
  CustomerCubit() : super(CustomerMainInitialState());

  static CustomerCubit get(context) => BlocProvider.of(context);
  final String CUSTOMER_END_POINT = "/accounting/customers";
  BondsInitializeModel? bondsInitializeModel;
  CustomerIdModel customerIdModel = CustomerIdModel();
  List<CreateCustomerModel> customers = [];
  List<CreateCustomerModel> customersSearch = [];

  InitializeModel initializeModel = InitializeModel();
  Bonds bonds = Bonds();
  String userJson = GetStorage().read("user");
  final ImagePicker picker = ImagePicker();
  File? profileImage;
  UserModel? user;

  deleteCustomer(var id, BuildContext context) async {
    String url = "accounting/customers/$id";
    emit(DeleteCustomerLoadingState());
    await ApiBaseHelper().delete(url).then((value) {
      emit(DeleteCustomerSuccessState());
      Get.snackbar('', value['message'],
          backgroundColor: CupertinoColors.white,
          colorText: Constants.textColor2);
      Navigator.of(context).pop();
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    });
    return customers;
  }

  Future<List<CreateCustomerModel>> getAllCustomers(int pageID) async {
    emit(GetCustomerLoadingState());
    String url = "accounting/customers";
   var  data ={
      'pageId':pageID.toString()
    };
    try {
      await ApiBaseHelper().get(url, null,body: data).then((value) {
        customers = (value as List)
            .map((e) => CreateCustomerModel.fromJson(e))
            .toList();
        emit(GetCustomerSuccessState());
      });
    } on Exception catch (ex) {
      emit(GetCustomerErrorState(ex));
      rethrow;
    }
    return customers;


  }

  Future<InitializeModel> initialize() async {
    String url = "accounting/customers/initialize";
    emit(InitializeLoadingState());
    try {
      await ApiBaseHelper()
          .get(url, null)
          .then((value) => initializeModel = InitializeModel.fromJson(value));
      emit(InitializeSuccessState());
    } on Exception catch (ex) {
      emit(InitializeErrorState(ex));
      rethrow;
    }
    return initializeModel;
  }

  Future<BondsInitializeModel> initializeBond() async {
    String url = "accounting/bonds/initialize";
    emit(GetBondsLoadingState());
    try {
      var response = await ApiBaseHelper().get(url, null);

      bondsInitializeModel = BondsInitializeModel.fromJson(response);
      emit(GetBondsSuccessState());
    } on Exception catch (error) {
      emit(GetBondsErrorState(error));
      rethrow;
    }
    return bondsInitializeModel!;
  }

  Future<CustomerIdModel> getUserById(id) async {
    emit(GetCustomerIdLoadingState());

    await ApiBaseHelper().get("accounting/customers/$id", null).then((value) {
      customerIdModel = CustomerIdModel.fromJson(value);
      emit(GetCustomerIdSuccessState());
    }).catchError((onError) {
      emit(GetCustomerIdErrorState(onError));
      Get.snackbar(
          'error'.tr,
          backgroundColor: CupertinoColors.white,
          colorText: Constants.textColor2,
          "${onError.toString()}");
    });
    return customerIdModel;
  }

  Future create(CreateCustomerModel customer) async {
    emit(CreateCustomerLoadingState());
    try {
      var response = await ApiBaseHelper().post(
          "accounting/customers", {"customer": jsonEncode(customer.toJson())});
      emit(CreateCustomerSuccessState());
    } on Exception catch (error) {
      emit(CreateCustomerErrorState(error));
      rethrow;
    }
  }

  Future<void> updateCustomer(
      CreateCustomerModel customer1, BuildContext context) async {
    emit(UpdateCustomerLoadingState());
    try {
      await ApiBaseHelper()
          .put("accounting/customers",
              {"customer": jsonEncode(customer1.toJson())}, null)
          .then((value) {
        return value;
      });
      emit(UpdateCustomerSuccessState());
    } on Exception catch (error) {
      emit(CreateCustomerErrorState(error));
      rethrow;
    }
  }

  Future<List<BanksModel>> getBanks() async {
    String url = "accounting/local_banks";
    List<BanksModel> banks = [];

    emit(GetBondsLoadingState());
    try {
      var response = await ApiBaseHelper().get(url, null);
      banks = (response as List).map((e) => BanksModel.fromJson(e)).toList();
      emit(GetBondsSuccessState());
      return banks;
    } on Exception catch (ex) {
      emit(GetBanksErrorState(ex));
      rethrow;
    }
  }

  void addSearchToList2(var searchName) {
    searchName = searchName.toLowerCase();
    customersSearch = customers.where((search) {
      var searchTitle = search.accountNo!.toString().toLowerCase();

      return searchTitle.contains(searchName);
    }).toList();

    if (searchName == "") {
      customersSearch.clear();
    } else {}
  }

  void addSearchToList(var searchName) {
    searchName = searchName.toLowerCase();

    customersSearch = customers.where((search) {
      var searchTitle = search.accountName!.toLowerCase();

      return searchTitle.contains(searchName);
    }).toList();
    if (searchName == "") {
      customersSearch.clear();
    } else {}
  }

  ////////////////////////////getting user image//////////////////////////////////////////////////

  getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
    } else {
      print("No Image Selected");
    }
  }

  clearImage() {
    profileImage = null;
  }

  List<String> imagesUrls = [];
  File? selectedFile;
  List<File> images = [];

  Future uploadImage({required String imagePath}) async {
    var response = ApiBaseHelper().postFile(imagePath);
    emit(UploadImageSuccessState());
    return response;
  }

  updateClientAddress(
      CreateCustomerModel customer, BuildContext context) async {
    emit(UpdateClientLoadingState());
    try {
      var response = await ApiBaseHelper().put("accounting/customers",
          {"customer": jsonEncode(customer.toJson())}, null);
      emit(UpdateClientSuccessState());
      Get.defaultDialog(
        title: "Alert",
        content: Text(" تم تعديل العنصر بنجاح"),
      );

      return response;
    } catch (ex) {
      emit(UpdateClientErrorState(ex));
      throw ex;
    }
  }

  final address = ''.obs;
  var userlat = ''.obs;
  final userlong = ''.obs;

  Future getLocation() async {
    await Future.delayed(Duration(seconds: 1));
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    final coordinates = new Coordinates(position.latitude, position.longitude);
    var addresses = await placemarkFromCoordinates(
        coordinates.latitude, coordinates.longitude);
    var first = addresses.first;
    String x = '${first.country}' + '${first.street}';
    return x;
  }

  int? branchNum;
  int? departmentNum;

  bool isInitialized = false;
  int? departmentId;
  int? branchId;
  bool isError = false;

  initializeBonds() async {
    try {
      bondsInitializeModel = await initializeBond();
      isInitialized = true;
      departmentId = bondsInitializeModel!.branches![0].id;
      branchId = bondsInitializeModel!.branches![0].id;
    } on Exception catch (ex) {
      isInitialized = false;
      print(ex);
      isError = true;
    }
  }

  Future<Bonds> getBonds(String departmentId, String branchId, String startDate,
      String endDate, String accountId) async {
    var body = {
      "startDate": startDate,
      "endDate": endDate,
      "branchId": branchId,
      "departmentId": departmentId,
      "accountId": accountId
    };
    emit(GetBondsLoadingState());
    try {
      user = UserModelFromJson(userJson);
      String url = "accounting/bonds/statement_of_account";
      var response = await ApiBaseHelper().get(url, body: body, null);
      bonds = Bonds.fromJson(response);
      emit(GetBondsSuccessState());
    } on Exception catch (error) {
      emit(GetBondsErrorState(error));
      rethrow;
    }
    return bonds;
  }
}
