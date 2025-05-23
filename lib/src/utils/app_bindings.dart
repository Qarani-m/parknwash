import 'package:get/get.dart';
import 'package:parknwash/src/features/auth/controllers/forgot_password_controller.dart';
import 'package:parknwash/src/features/auth/controllers/login_controller.dart';
import 'package:parknwash/src/features/auth/controllers/onboarding_controller.dart';
import 'package:parknwash/src/features/auth/controllers/signup_controller.dart';
import 'package:parknwash/src/features/home/controller/booking_list_controller.dart';
import 'package:parknwash/src/features/home/controller/checkout_controller.dart';
import 'package:parknwash/src/features/home/controller/homecontroller.dart';
import 'package:parknwash/src/features/home/controller/my_booking_controller.dart';
import 'package:parknwash/src/features/parking/controllers/booking_finished_controller.dart';
import 'package:parknwash/src/features/parking/controllers/locations_controller.dart';
import 'package:parknwash/src/features/parking/controllers/parking_details_controller.dart';
import 'package:parknwash/src/features/profile/controller/favourites_controller.dart';
import 'package:parknwash/src/features/profile/controller/notifications_controller.dart';
import 'package:parknwash/src/features/profile/controller/payment_history_controller.dart';
import 'package:parknwash/src/features/profile/controller/profile_controller.dart';
import 'package:parknwash/src/features/washing/controllers/washing_homepage_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Homecontroller>(Homecontroller());
    Get.put<LoginController>(LoginController());
    Get.put<SignupController>(SignupController());
    Get.put<OnboardingController>(OnboardingController());
    Get.put<ProfileController>(ProfileController());
    Get.put<ForgotPasswordController>(ForgotPasswordController());
    Get.put<NotificationsController>(NotificationsController());
    Get.put<PaymentHistoryController>(PaymentHistoryController());
    Get.put<FavouritesController>(FavouritesController());
    Get.put<LocationsController>(LocationsController());
    Get.put<BookingFinishedController>(BookingFinishedController());
    Get.put<ParkingDetailsController>(ParkingDetailsController());
    Get.put<BookingListController>(BookingListController());
    Get.put<MyBookingController>(MyBookingController());
    Get.put<CheckoutController>(CheckoutController());
    Get.put<WashingHomepageController>(WashingHomepageController());

  }
}

