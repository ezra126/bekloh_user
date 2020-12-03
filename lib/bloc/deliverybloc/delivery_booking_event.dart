import 'package:bekloh_user/model/delivery_service_type.dart';
import 'package:bekloh_user/model/payment_type.dart';
import 'package:bekloh_user/model/vechile_type.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

abstract class DeliveryBookingEvent extends Equatable {
  DeliveryBookingEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}


class DeliveryBookingStartEvent extends DeliveryBookingEvent {

}

class DeliveryServiceTypeSelectedEvent extends DeliveryBookingEvent{
  final DeliveryServiceType serviceType;
  DeliveryServiceTypeSelectedEvent({this.serviceType});

  @override
  List<Object> get props => [serviceType];

}


class DestinationNotSelectedEvent extends DeliveryBookingEvent {
  final LatLng currentLocation;
  DestinationNotSelectedEvent(this.currentLocation);
  @override
  List<Object> get props => [currentLocation];
}

class PickupNotSelectedEvent extends DeliveryBookingEvent {
  final LatLng currentLocation;
  PickupNotSelectedEvent(this.currentLocation);
  @override
  List<Object> get props => [currentLocation];
}

class DestinationSelectedEvent extends DeliveryBookingEvent {
 // final LatLng destination;
  //final LatLng startingLoc;
  final LatLng destination;
  DestinationSelectedEvent(this.destination);
  @override
  List<Object> get props => [destination];
}

class PickupLocationSelectedEvent extends DeliveryBookingEvent {
  // final LatLng destination;
  //final LatLng startingLoc;
  final LatLng startingLoc;


  PickupLocationSelectedEvent({this.startingLoc});
  @override
  List<Object> get props => [startingLoc];
}

class DetailsSubmittedEvent extends DeliveryBookingEvent {
  final DateTime scheduledTime;
  final int labour;
  DetailsSubmittedEvent({this.scheduledTime,this.labour});
  @override
  List<Object> get props => [scheduledTime,labour];
}

class DeliveryVechileAndPaymentSelectedEvent extends DeliveryBookingEvent{
   final VechileType vechileType;
   final PaymentType paymentType;
   final String bookImage;
   DeliveryVechileAndPaymentSelectedEvent(this.vechileType,this.paymentType,this.bookImage);
   @override
   List<Object> get props => [VechileType,paymentType];
}

class UserConfirmMoveOrDeliveryEvent extends DeliveryBookingEvent{
  final bool deliverOrMoveNow;
  UserConfirmMoveOrDeliveryEvent({this.deliverOrMoveNow});
  @override
  List<Object> get props => [];
}

class DriverAcceptYourDeliveryOrMoveEvent extends DeliveryBookingEvent{

}

class SelectPaymentMethodEvent extends DeliveryBookingEvent {
  final PaymentType paymentType;
  SelectPaymentMethodEvent(this.paymentType);
  @override
  List<Object> get props => [paymentType];
}

class BackPressedEventFromPayment extends DeliveryBookingEvent {
  final PaymentType paymentType;
  BackPressedEventFromPayment(this.paymentType);
  @override
  List<Object> get props => [paymentType];
}

class BackPressedEvent extends DeliveryBookingEvent {
}



class DeliveryBookingCancelEvent extends DeliveryBookingEvent {}

