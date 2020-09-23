import 'package:bloc/bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';

class DeliveryBookingBloc extends Bloc<DeliveryBookingEvent, DeliveryBookingState> {
  DeliveryBookingBloc() : super(DeliveryBookingNotInitializedState());


  @override
  Stream<DeliveryBookingState> mapEventToState(DeliveryBookingEvent event) {
    if(event is DeliveryBookingStartEvent){
    }
    if(event is DestinationSelectedEvent){}
    if(event is  DetailsSubmittedEvent){}
    if(event is DeliveryVechileSelectedEvent){}
    if(event is SelectPaymentMethodEvent){}
    if(event is BackPressedEvent){}
  }

}