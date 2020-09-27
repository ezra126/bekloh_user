import 'package:bloc/bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';

class DeliveryBookingBloc extends Bloc<DeliveryBookingEvent, DeliveryBookingState> {
  DeliveryBookingBloc() : super(DeliveryBookingNotInitializedState());


  @override
  Stream<DeliveryBookingState> mapEventToState(DeliveryBookingEvent event) async* {
    if(event is DeliveryBookingStartEvent){
       yield DeliveryBookingNotInitializedState();
    }
    if(event is DestinationSelectedEvent){
      yield DestinationNotSelectedState();
    }
    if(event is  DetailsSubmittedEvent){}
    if(event is DeliveryVechileSelectedEvent){}
    if(event is SelectPaymentMethodEvent){}
    if(event is BackPressedEvent){
      yield DeliveryBookingNotInitializedState();
    }
  }

}