import 'package:equatable/equatable.dart';

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
  DestinationNotSelectedState();

}

class DetailsNotFilledState extends DeliveryBookingState {}

class DeliveryVechileTypeNotSelectedState extends DeliveryBookingState {}

class PaymentMethodNotSelectedState extends DeliveryBookingState {}

class DeliveryBookingConfirmedState extends DeliveryBookingState {}

class DeliveryBookingNotConfirmedState extends DeliveryBookingState {}

class DeliveryBookingCancelledState extends DeliveryBookingState {}

class DeliveryBookingLoadingState extends DeliveryBookingState {}


