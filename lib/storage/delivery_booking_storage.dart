import 'package:bekloh_user/model/delivery_booking.dart';

class DeliveryBookingStorage {
  static  DeliveryBooking _deliveryBooking;

  static Future<void> open() async {
    _deliveryBooking = DeliveryBooking.named();
  }

  static Future<DeliveryBooking> addDetails(DeliveryBooking deliveryBooking) async {
    _deliveryBooking = _deliveryBooking.copyWith(deliveryBooking);
    return _deliveryBooking;
  }

  //static Future<DeliveryBooking> getDeliveryBooking() async {
  static DeliveryBooking getDeliveryBooking() {
    return _deliveryBooking;
  }

  static resetDeliveryBooking(){
    return _deliveryBooking=null;
  }

   getDeliverySource(){
    return _deliveryBooking.source;
  }
}