import 'package:equatable/equatable.dart';

abstract class DeliveryBookingState extends Equatable{
  DeliveryBookingState();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DeliveryMapLoading extends DeliveryBookingState{}

class DeliveryServiceTypeNotInitialized extends DeliveryBookingState{}

class DeliveryBookingNotInitializedState extends DeliveryBookingState {
  DeliveryBookingNotInitializedState();
}
class DeliveryBookingNotSelectedState extends DeliveryBookingState {
  DeliveryBookingNotSelectedState();
}

class DetailsNotFilledState extends DeliveryBookingState {}

class DeliveryNotSelectedState extends DeliveryBookingState {}

class DeliveryNotConfirmedState extends DeliveryBookingState {}

class PaymentNotInitializedState extends DeliveryBookingState {}

class DeliveryConfirmedState extends DeliveryBookingState {}

class DeliveryBookingCancelledState extends DeliveryBookingState {}

class DeliveryBookingLoadingState extends DeliveryBookingState {}

class DeliveryBookingConfirmedState extends DeliveryBookingState {}
