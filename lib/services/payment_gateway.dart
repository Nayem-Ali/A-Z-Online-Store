import 'package:ecommerce/ui/style/app_styles.dart';
import 'package:flutter_sslcommerz/model/SSLCSdkType.dart';
import 'package:flutter_sslcommerz/model/SSLCTransactionInfoModel.dart';
import 'package:flutter_sslcommerz/model/SSLCommerzInitialization.dart';
import 'package:flutter_sslcommerz/model/SSLCurrencyType.dart';
import 'package:flutter_sslcommerz/sslcommerz.dart';
import 'package:get/get.dart';


class PaymentGateway{

  Future<void> sslCommerzGeneralCall(double amount) async {
    Sslcommerz sslcommerz = Sslcommerz(
      initializer: SSLCommerzInitialization(
        currency: SSLCurrencyType.BDT,
        product_category: "Art",
        sdkType: SSLCSdkType.TESTBOX,
        store_id: 'artsh6672e68f6d12a',
        store_passwd: 'artsh6672e68f6d12a@ssl',
        total_amount: amount,
        tran_id: '12124',
      ),
    );
    try {
      SSLCTransactionInfoModel result = await sslcommerz.payNow();

      if (result.status!.toLowerCase() == "failed") {
        Get.showSnackbar(AppStyles().failedSnackbar("Transaction Failed"));
        // Fluttertoast.showToast(
        //   msg: "Transaction is Failed....",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.red,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      } else if (result.status!.toLowerCase() == "closed") {
        Get.showSnackbar(AppStyles().failedSnackbar("Transaction Closed by User"));
        // Fluttertoast.showToast(
        //   msg: "SDK Closed by User",
        //   toastLength: Toast.LENGTH_SHORT,
        //   gravity: ToastGravity.CENTER,
        //   timeInSecForIosWeb: 1,
        //   backgroundColor: Colors.red,
        //   textColor: Colors.white,
        //   fontSize: 16.0,
        // );
      } else {
        Get.showSnackbar(
          AppStyles().successSnackbar("Transaction is ${result.status} and Amount is ${result.amount}"),
        );
        // Fluttertoast.showToast(
        //     msg:
        //     "Transaction is ${result.status} and Amount is ${result.amount}",
        //     toastLength: Toast.LENGTH_SHORT,
        //     gravity: ToastGravity.CENTER,
        //     timeInSecForIosWeb: 1,
        //     backgroundColor: Colors.black,
        //     textColor: Colors.white,
        //     fontSize: 16.0);
      }
    } catch (e) {
      Get.showSnackbar(AppStyles().successSnackbar(e.toString()));
    }
  }

}