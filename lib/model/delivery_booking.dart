//import 'package:taxi_app/models/payment_method.dart';

import 'google_location.dart';
import 'vechile_type.dart';
import 'payment_type.dart';

class DeliveryBooking {
  final String id;
  final GoogleLocation source;
  final GoogleLocation destination;
  final DateTime bookingTime;
  final VechileType vechileType;
  final double estimatedPrice;
  final PaymentType paymentType;
  final String promoApplied;


  DeliveryBooking(
      this.id,
      this.source,
      this.destination,
      this.bookingTime,
      this.estimatedPrice,
      this.paymentType,
      this.promoApplied,
      this.vechileType,);

  DeliveryBooking.named({
    this.id,
    this.source,
    this.destination,
    this.bookingTime,
    this.vechileType,
    this.paymentType,
    this.estimatedPrice,
    this.promoApplied,
  });

  DeliveryBooking copyWith(DeliveryBooking booking) {
    return DeliveryBooking.named(
        id: booking.id ?? id,
        source: booking.source ?? source,
        destination: booking.destination ?? destination,
        bookingTime: booking.bookingTime ?? bookingTime,
        paymentType: booking.paymentType ?? paymentType,
        promoApplied: booking.promoApplied ?? promoApplied,
        estimatedPrice: booking.estimatedPrice ?? estimatedPrice,
        vechileType: booking.vechileType ?? vechileType);
  }
}