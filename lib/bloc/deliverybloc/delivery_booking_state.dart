import 'package:bekloh_user/model/delivery_booking.dart';
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

class DeliveryVechileTypeNotSelectedState extends DeliveryBookingState {
  final DeliveryBooking booking;
  DeliveryVechileTypeNotSelectedState({this.booking});
  @override
  List<Object> get props => [booking];
}

class PaymentMethodNotSelectedState extends DeliveryBookingState {
  final DeliveryBooking booking;
  PaymentMethodNotSelectedState({this.booking});
  @override
  List<Object> get props => [booking];
}

class DeliveryBookingConfirmedState extends DeliveryBookingState {}

class DeliveryBookingNotConfirmedState extends DeliveryBookingState {}

class DeliveryBookingCancelledState extends DeliveryBookingState {}

class DeliveryBookingLoadingState extends DeliveryBookingState {}


