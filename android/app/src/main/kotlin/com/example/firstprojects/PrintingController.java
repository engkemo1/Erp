package com.example.firstprojects;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.UUID;
import org.json.JSONArray;
import org.json.JSONObject;


public class PrintingController  {
  
    private static BluetoothSocket btsocket;
    private static OutputStream outputStream;
    HashMap<String, String> hashmap = new HashMap();
   String  payments;
    Context context;

    public PrintingController(Context context) {
        this.context = context;

    }


    
    public void onCreateCashReceipt(HashMap<String, String> hashmap) {
        this.hashmap = hashmap;
        printBill();
    }
    public void onCreateStatementOfAccount(HashMap<String, String> hashmap, String  payments) {
        this.hashmap = hashmap;
        this.payments = payments;
        statementOfAccount();
    }


    private BluetoothSocket getSocket(String macAddress) throws IOException {

        BluetoothDevice selectedBluetoothDevice = null;
        BluetoothAdapter mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        List<BluetoothDevice> pairedDeviceList = new ArrayList<>(mBluetoothAdapter.getBondedDevices());

        for (int i = 0; i < pairedDeviceList.size(); i++) {
            BluetoothDevice bluetoothDevice = pairedDeviceList.get(i);
            if (bluetoothDevice.getAddress().equals(macAddress)) {
                selectedBluetoothDevice = bluetoothDevice;
                break;
            }
        }

        UUID uuid = selectedBluetoothDevice.getUuids()[0]
                .getUuid();

        return selectedBluetoothDevice
                .createRfcommSocketToServiceRecord(uuid);
    }

    protected void printBill() {
        try {
            String macAddress = hashmap.get("macAddress");
            macAddress ="00:00:0F:04:D0:33";
            btsocket = getSocket(macAddress);
            btsocket.connect();
            OutputStream opstream = btsocket.getOutputStream();
            outputStream = opstream;
            Thread.sleep(1000);
            outputStream = btsocket.getOutputStream();
            MyThread myThread = new MyThread();
            myThread.start();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
    protected void statementOfAccount() {
        try {
            String macAddress = hashmap.get("macAddress");
            btsocket = getSocket(macAddress);
            btsocket.connect();
            OutputStream opstream = btsocket.getOutputStream();
            outputStream = opstream;
            Thread.sleep(1000);
            outputStream = btsocket.getOutputStream();
            MyThreadStatementOfAccount myThread = new MyThreadStatementOfAccount();
            myThread.start();
        } catch (IOException e) {
            e.printStackTrace();
        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }


    public void printPhoto(Bitmap bmp) throws Exception {

        if (bmp != null) {
            byte[] command = Utils.decodeBitmap(bmp);
            outputStream.write(PrinterCommands.ESC_ALIGN_CENTER);
            printText(command);
        }
    }


    private void printNewLine() {
        try {
            outputStream.write(PrinterCommands.FEED_LINE);
        } catch (IOException e) {
            e.printStackTrace();
        }

    }

    private void printText(byte[] msg) {
        try {
            outputStream.write(msg);
            printNewLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public class MyThread extends Thread {
        @Override
        public void run() {
            try {
              
             //   Bitmap largeIcon = BitmapFactory.decodeResource(context.getResources(), R.drawable.alkashef);

               // largeIcon= Bitmap.createScaledBitmap(largeIcon, 400, 120, false);
               // printPhoto(largeIcon);
                printPhoto(new ConvertTextToImage().header("سند قبض"));
                printPhoto(new ConvertTextToImage().headersubTitle("نسخة العميل"));
                printNewLine();
                printPhoto(new ConvertTextToImage().keyValue("الرقم الضريبي", hashmap.get("companyTaxNumber")));
                printPhoto(new ConvertTextToImage().keyValue("رقم الهاتف", hashmap.get("companyPhoneNumber")));
                printPhoto(new ConvertTextToImage().keyValue("العنوان", hashmap.get("companyAddress")));
                printPhoto(new ConvertTextToImage().headersubTitle("-------------"));
                printNewLine();
                printPhoto(new ConvertTextToImage().keyValue("رقم السند", hashmap.get("bondNo")));
                printPhoto(new ConvertTextToImage().keyValue("تاريخ السند", hashmap.get("bondDate")));
                printPhoto(new ConvertTextToImage().keyValue("اسم الحساب", hashmap.get("creditAccountName")));
                printPhoto(new ConvertTextToImage().keyValue("اسم المندوب", hashmap.get("salesmanName")));
                printPhoto(new ConvertTextToImage().keyValue("رقم هاتف المندوب", hashmap.get("salesmanPhoneNumber")));
                printPhoto(new ConvertTextToImage().keyValue("بيان السند", hashmap.get("statement")));
                printPhoto(new ConvertTextToImage().keyValue("المبلغ النقدي", hashmap.get("cashAmount")));
                printPhoto(new ConvertTextToImage().keyValue("مبلغ الشيكات", hashmap.get("checkAmount")));
                printPhoto(new ConvertTextToImage().keyValue("الاجمالي", hashmap.get("totalAmount")));
                printNewLine();
                printNewLine();
                printPhoto(new ConvertTextToImage().footer("اسم المستلم", "التوقيع"));
                printNewLine();


              //  printPhoto(new ConvertTextToImage().headersubTitle(new String(new char[10]).replace("\0", "ــــــــــــــــــــــــــــــ")));



                printNewLine();
                printNewLine();
                printNewLine();
                printNewLine();
                outputStream.flush();
                Thread.sleep(5000);
                btsocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    public class MyThreadStatementOfAccount extends Thread {
        @Override
        public void run() {
            try {
              
             //   Bitmap largeIcon = BitmapFactory.decodeResource(context.getResources(), R.drawable.alkashef);

             //   largeIcon= Bitmap.createScaledBitmap(largeIcon, 400, 120, false);
              //  printPhoto(largeIcon);
                printPhoto(new ConvertTextToImage().header("كشف حساب"));
                printPhoto(new ConvertTextToImage().headersubTitle("نسخة العميل"));
                printNewLine();
                printPhoto(new ConvertTextToImage().keyValue("الرقم الضريبي", hashmap.get("companyTaxNumber")));
                printPhoto(new ConvertTextToImage().keyValue("رقم الهاتف", hashmap.get("companyPhoneNumber")));
                printPhoto(new ConvertTextToImage().keyValue("العنوان", hashmap.get("companyAddress")));
                printPhoto(new ConvertTextToImage().headersubTitle("-------------"));
                printNewLine();
                printPhoto(new ConvertTextToImage().keyValue("اسم الحساب", hashmap.get("creditAccountName")));
                printPhoto(new ConvertTextToImage().keyValue("اسم المندوب", hashmap.get("salesmanName")));
                printPhoto(new ConvertTextToImage().keyValue("رقم هاتف المندوب", hashmap.get("salesmanPhoneNumber")));
              
                printPhoto(new ConvertTextToImage().keyValue("مدة العقد", hashmap.get("contractPeroid")+" شهر "));
                printPhoto(new ConvertTextToImage().keyValue("تاريخ بداية العقد", hashmap.get("contractStartDate")));
                printPhoto(new ConvertTextToImage().keyValue("تاريخ نهاية العقد", hashmap.get("contractEndDate")));


                printNewLine();
                printNewLine();

                printPhoto(new ConvertTextToImage().itemHeader());

                JSONArray jsonArray = new JSONArray(payments.toString());
                for (int i = 0; i < jsonArray.length(); i++) {
                    JSONObject obj = jsonArray.getJSONObject(i);
    
                    String status = obj.getString("status_name");
                    String dueDate =obj.getString("due_date");
                    String amount = obj.getString("amount");
                    String balance = obj.getString("balance");
                    printPhoto(new ConvertTextToImage().item(dueDate, status, amount, balance));
                  }

                printNewLine();
                printNewLine();
                printPhoto(new ConvertTextToImage().footer("اسم المستلم", "التوقيع"));
                printNewLine();
                
             //   printPhoto(new ConvertTextToImage().headersubTitle(new String(new char[10]).replace("\0", "ــــــــــــــــــــــــــــــ")));

                printNewLine();
                printNewLine();
                printNewLine();
                printNewLine();
                outputStream.flush();
                Thread.sleep((5000) + (250 * jsonArray.length()));
                btsocket.close();
            } catch (IOException e) {
                e.printStackTrace();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

}