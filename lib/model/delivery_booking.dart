//import 'package:taxi_app/models/payment_method.dart';

import 'package:bekloh_user/model/delivery_item_detail.dart';
import 'package:bekloh_user/model/delivery_service_type.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'google_location.dart';
import 'vechile_type.dart';
import 'payment_type.dart';

enum BookingStatus{ pending, completed ,canceled}
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
  final DeliveryItem deliveryItem;
  final String bookImage;
  final BookingStatus bookingStatus;
  final int numberOfLabour;
  final List<String> itemsImage;


  DeliveryBooking(
      this.id,
      this.source,
      this.destination,
      this.bookingTime,
      this.estimatedPrice,
      this.paymentType,
      this.promoApplied,
      this.vechileType,
      this.deliveryServiceType,
      this.deliveryItem,
      this.bookImage,
      this.bookingStatus,
      this.numberOfLabour,
      this.itemsImage,
  );

  DeliveryBooking.named({
    this.id,
    this.source,
    this.destination,
    this.bookingTime,
    this.vechileType,
    this.paymentType,
    this.estimatedPrice,
    this.promoApplied,
    this.deliveryServiceType,
    this.deliveryItem,
    this.bookImage,
    this.bookingStatus,
    this.numberOfLabour,
    this.itemsImage
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
        deliveryServiceType: booking.deliveryServiceType?? deliveryServiceType,
        deliveryItem: booking.deliveryItem ?? deliveryItem,
        bookImage: booking.bookImage ?? bookImage,
        numberOfLabour: booking.numberOfLabour ?? numberOfLabour,
        itemsImage: booking.itemsImage ?? itemsImage
    );
  }
}

class Order{
  int id;
  //final GoogleLocation source;
  //final GoogleLocation destination;
  String source;
  String destination;
  String bookingTime;
  String vechileType;
  double estimatedPrice;
  String paymentType;
  String promoApplied;
  String deliveryServiceType;
  String deliveryItem;
  String bookImage;
  String bookingStatus;
  int numberOfLabour;
  String itemsImage;

  //Order({this.id, this.source, this.destination, this.bookingTime, this.vechileType, this.estimatedPrice, this.paymentType,
  //this.promoApplied, this.deliveryServiceType, this.deliveryItem, this.bookImage, this.bookingStatus, this.numberOfLabour, this.itemsImage});

  Order();
  Map<String, dynamic> toMap() {
    return {
      'destination': destination,
      'source': source,
      'bookingTime': bookingTime,
      'vechileType' : vechileType,
      'paymentType': paymentType,
      'deliveryServiceType': deliveryServiceType,
      'bookImage': bookImage,
    };
  }

  Order.fromMap(Map<String, dynamic> map) {
    id = map['_id'];
    destination = map['destination'];
    source = map['source'];
    bookingTime = map['bookingTime'];
    vechileType = map['vechileType'];
    paymentType = map['paymentType'];
    deliveryServiceType = map['deliveryServiceType'];
    bookImage= map['bookImage'];
  }
}