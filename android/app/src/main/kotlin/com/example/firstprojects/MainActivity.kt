package com.example.firstprojects
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import androidx.annotation.NonNull
import android.widget.Toast
import com.example.firstprojects.PrintingController
import com.google.gson.Gson
import com.google.gson.GsonBuilder
import com.google.gson.reflect.TypeToken
import java.lang.reflect.Type
import org.json.JSONArray

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.firstprojects/print"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
                  
            if (call.method == "cashReceipt") {
                var hashMap : HashMap<String, String>
                        = HashMap<String, String> ()

                val bondNo : String? = call.argument("bondNo");
                val bondDate : String? = call.argument("bondDate");
                val checkAmount : String? = call.argument("checkAmount");
                val totalAmount : String? = call.argument("totalAmount");
                val cashAmount : String? = call.argument("cashAmount");
                val macAddress : String? = call.argument("macAddress");
                val companyName : String? = call.argument("companyName");
                val salesmanName : String? = call.argument("salesmanName");
                val companyAddress : String? = call.argument("companyAddress");
                val companyPhoneNumber : String? = call.argument("companyPhoneNumber");
                val companyTaxNumber : String? = call.argument("companyTaxNumber");
                val creditAccountName : String? = call.argument("creditAccountName");
                val receivables : String? = call.argument("receivables");
                val salesmanPhoneNumber : String? = call.argument("salesmanPhoneNumber");
                val contractPeroid : String? = call.argument("contractPeroid");
                val contractStartDate : String? = call.argument("contractStartDate");
                val contractEndDate : String? = call.argument("contractEndDate");
                val statement : String? = call.argument("statement");
                val monthlyFees : String? = call.argument("monthlyFees");
                hashMap.put("bondNo", bondNo!!);
                hashMap.put("bondDate", bondDate!!);
                hashMap.put("cashAmount", cashAmount!!);
                hashMap.put("checkAmount", checkAmount!!);
                hashMap.put("totalAmount", totalAmount!!);
                hashMap.put("salesmanName", salesmanName!!);
                hashMap.put("macAddress", macAddress!!);
                hashMap.put("companyName", companyName!!);
                hashMap.put("companyTaxNumber", companyTaxNumber!!);
                hashMap.put("companyPhoneNumber", companyPhoneNumber!!);
                hashMap.put("companyAddress", companyAddress!!);
                hashMap.put("receivables", receivables!!);
                hashMap.put("creditAccountName", creditAccountName!!);
                hashMap.put("salesmanPhoneNumber", salesmanPhoneNumber!!);
                //hashMap.put("statement", statement!!);
               // hashMap.put("contractPeroid", contractPeroid!!);
              //  hashMap.put("contractStartDate", contractStartDate!!);
              //  hashMap.put("contractEndDate", contractEndDate!!);
              //  hashMap.put("monthlyFees", monthlyFees!!);


                PrintingController(applicationContext).onCreateCashReceipt(hashMap);



            } else if (call.method == "receivables") {

                var hashMap : HashMap<String, String>
                        = HashMap<String, String> ()

                val payments : String? = call.argument("payments");
                val macAddress : String? = call.argument("macAddress");
                val companyName : String? = call.argument("companyName");
                val salesmanName : String? = call.argument("salesmanName");
                val companyAddress : String? = call.argument("companyAddress");
                val companyPhoneNumber : String? = call.argument("companyPhoneNumber");
                val companyTaxNumber : String? = call.argument("companyTaxNumber");
                val creditAccountName : String? = call.argument("creditAccountName");
                val salesmanPhoneNumber : String? = call.argument("salesmanPhoneNumber");
                 val currentDate : String? = call.argument("currentDate");
                 val contractPeroid : String? = call.argument("contractPeroid");
                // val contractStartDate : String? = call.argument("contractStartDate");
                // val contractEndDate : String? = call.argument("contractEndDate");
                // val monthlyFees : String? = call.argument("monthlyFees");

                hashMap.put("salesmanName", salesmanName!!);
                hashMap.put("macAddress", macAddress!!);
                hashMap.put("companyName", companyName!!);
                hashMap.put("companyTaxNumber", companyTaxNumber!!);
                hashMap.put("companyPhoneNumber", companyPhoneNumber!!);
                hashMap.put("companyAddress", companyAddress!!);
                hashMap.put("creditAccountName", creditAccountName!!);
                hashMap.put("salesmanPhoneNumber", salesmanPhoneNumber!!);
                // hashMap.put("currentDate", currentDate!!);
                // hashMap.put("contractPeroid", contractPeroid!!);
                // hashMap.put("contractStartDate", contractStartDate!!);
                // hashMap.put("contractEndDate", contractEndDate!!);
                // hashMap.put("monthlyFees", monthlyFees!!);

                // val gson = Gson()

                // var result: List<Payment> = gson.fromJson(payments.toString(), Array<Payment>::class.java).toList()

                //  WalletERPCashReceiptV2(applicationContext).onCreateReceivables(hashMap, payments.toString());
                // NewPrintingModel(applicationContext).onCreateReceivables(hashMap, payments.toString());
                PrintingController(applicationContext).onCreateStatementOfAccount(hashMap, payments.toString());
            }
        }
    }
}

