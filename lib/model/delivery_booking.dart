//import 'package:taxi_app/models/payment_method.dart';

import 'package:bekloh_user/model/delivery_service_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_location.dart';
import 'vechile_type.dart';
import 'payment_type.dart';

class DeliveryBooking {
  final String id;
  //final GoogleLocation source;
  //final GoogleLocation destination;
  final LatLng source;
  final LatLng destination;
  final DateTime bookingTime;
  final VechileType vechileType;
  final double estimatedPrice;
  final PaymentType paymentType;
  final String promoApplied;
  final DeliveryServiceType deliveryServiceType;


  DeliveryBooking(
      this.id,
      this.source,
      this.destination,
      this.bookingTime,
      this.estimatedPrice,
      this.paymentType,
      this.promoApplied,
      this.vechileType,
      this.deliveryServiceType);

  DeliveryBooking.named({
    this.id,
    this.source,
    this.destination,
    this.bookingTime,
    this.vechileType,
    this.paymentType,
    this.estimatedPrice,
    this.promoApplied,
    this.deliveryServiceType
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
        vechileType: booking.vechileType ?? vechileType,
        deliveryServiceType: booking.deliveryServiceType?? deliveryServiceType
    );
  }

  
}