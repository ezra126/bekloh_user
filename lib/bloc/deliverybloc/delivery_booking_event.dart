import 'package:equatable/equatable.dart';

abstract class DeliveryBookingEvent extends Equatable {
  DeliveryBookingEvent();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DeliveryMapInitalizingEvent extends DeliveryBookingEvent{}

class DeliveryServiceTypeBookingEvent extends DeliveryBookingEvent{}

class DeliveryBookingStartEvent extends DeliveryBookingEvent {}

class DestinationSelectedEvent extends DeliveryBookingEvent {}

class DetailsSubmittedEvent extends DeliveryBookingEvent {}

class DeliveryVechileSelectedEvent extends DeliveryBookingEvent{}

class SelectPaymentMethodEvent extends DeliveryBookingEvent {}

class BackPressedEvent extends DeliveryBookingEvent {}

class DeliveryBookingCancelEvent extends DeliveryBookingEvent {}