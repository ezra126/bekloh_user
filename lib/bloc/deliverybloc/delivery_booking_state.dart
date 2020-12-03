import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:bekloh_user/model/delivery_service_type.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class DeliveryBookingState extends Equatable{
  DeliveryBookingState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}





class DeliveryBookingNotInitializedState extends DeliveryBookingState {
  DeliveryBookingNotInitializedState();
}
class DeliveryBookingNotSelectedState extends DeliveryBookingState {
  DeliveryBookingNotSelectedState();
}

class DeliveryServiceTypeSelectedState extends DeliveryBookingState{
  final DeliveryServiceType serviceType;
  DeliveryServiceTypeSelectedState({this.serviceType});
  @override
  List<Object> get props => [serviceType];

}

class DestinationNotSelectedState extends DeliveryBookingState {
  final LatLng currentLocation;
  DestinationNotSelectedState(this.currentLocation);
  @override
  List<Object> get props => [currentLocation];

}

class PickupNotSelectedState extends DeliveryBookingState {
  final LatLng currentLocation;
  PickupNotSelectedState(this.currentLocation);
  @override
  List<Object> get props => [currentLocation];

}

class DetailsNotFilledState extends DeliveryBookingState {
  final DeliveryBooking booking;
  DetailsNotFilledState({this.booking});
  @override
  List<Object> get props => [booking];
}

class DeliveryVechileAndPaymentTypeNotSelectedState extends DeliveryBookingState {
  final DeliveryBooking booking;
  DeliveryVechileAndPaymentTypeNotSelectedState({this.booking});
  @override
  List<Object> get props => [booking];
}

class PaymentMethodNotSelectedState extends DeliveryBookingState {
  final DeliveryBooking booking;
  PaymentMethodNotSelectedState({this.booking});
  @override
  List<Object> get props => [booking];
}

class DeliveryBookingNotConfirmedState extends DeliveryBookingState {
  final DeliveryBooking booking;
  DeliveryBookingNotConfirmedState({this.booking});
  @override
  List<Object> get props => [booking];
}

class DeliveryBookingConfirmedState extends DeliveryBookingState {}

class SearchingForDriverState extends DeliveryBookingState{
  final DeliveryBooking booking;
  SearchingForDriverState({this.booking});
  @override
  List<Object> get props => [booking];
}

class DriverAcceptYourMoveOrDeliveryState extends DeliveryBookingState{
  final DeliveryBooking booking;
  DriverAcceptYourMoveOrDeliveryState({this.booking});
  @override
  List<Object> get props => [booking];
}




class DeliveryBookingCancelledState extends DeliveryBookingState {}

class DeliveryBookingLoadingState extends DeliveryBookingState {}


