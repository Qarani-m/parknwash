import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ParkingDetailsController extends GetxController {
  final box = GetStorage();

  TextEditingController vehicleRegController = TextEditingController();
  TextEditingController hrsController = TextEditingController();
  TextEditingController minutesController = TextEditingController();
  TextEditingController secsController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  void showPaymentDialog(BuildContext context) {
    String cat = box.read("category") ?? "0";

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Booking fee'),
          content: Text(
            textAlign: TextAlign.center,
            'A boking fee of KSH ${cat == "1" ? 100 : 200} is required, press OK to proceed',
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(fontWeight: FontWeight.w400),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                initatePayment(cat);
              },
            ),
          ],
        );
      },
    );
  }
}

void initatePayment(String cat) {
  String consumerSecret = "kxUnaJKvqrnYxzea";
  String consumerKey = "IPQMSpMGRKm6g45rrCzZRmt1C3xR4MII";

  Get.offNamed("/booking_finished");
}
