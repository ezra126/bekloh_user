import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:bekloh_user/storage/delivery_booking_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryBookingBloc extends Bloc<DeliveryBookingEvent, DeliveryBookingState> {
  DeliveryBookingBloc() : super(DeliveryBookingNotInitializedState());


  @override
  Stream<DeliveryBookingState> mapEventToState(DeliveryBookingEvent event) async* {
    if(event is DeliveryBookingStartEvent){
       yield DeliveryBookingNotInitializedState();
    }

    if(event is DestinationNotSelectedEvent){
      print('longiiiiiiiii');
      final LatLng currentLocation=event.currentLocation;
      print(event.currentLocation.longitude);
      var booking = await DeliveryBookingStorage.getDeliveryBooking();
     // DeliveryBookingStorage.addDetails(DeliveryBooking.named(source: event.currentLocation ));
      if(booking==null){
        DeliveryBookingStorage.open();
        DeliveryBookingStorage.addDetails(DeliveryBooking.named(source: event.currentLocation ));
      }

      yield DestinationNotSelectedState(currentLocation);
    }

    if(event is PickupNotSelectedEvent){
     // DeliveryBookingStorage.open();
      print('longiiiiiiiii');
      final LatLng currentLocation=event.currentLocation;
      print(event.currentLocation.longitude);
      yield PickupNotSelectedState(currentLocation);
    }
    if(event is DestinationSelectedEvent){
      var booking = await DeliveryBookingStorage.getDeliveryBooking();

      LatLng destination=event.destination;
      DeliveryBooking deliveryBooking;
      deliveryBooking =await DeliveryBookingStorage.addDetails(DeliveryBooking.named(destination: destination ));
      yield DetailsNotFilledState(booking: deliveryBooking);
    }
    if(event is PickupLocationSelectedEvent){
      DeliveryBookingStorage.open();
      LatLng startingLoc=event.startingLoc;
      DeliveryBooking deliveryBooking;

      deliveryBooking =await DeliveryBookingStorage.addDetails(DeliveryBooking.named(source: startingLoc));
      var booking = await DeliveryBookingStorage.getDeliveryBooking();
      print(booking.source);
      print('ffffffffffffffffffffffffffffffffffffffffff');
     // yield DetailsNotFilledState();
    }
    if(event is DetailsSubmittedEvent){
      DeliveryBooking deliveryBooking;
      deliveryBooking= await DeliveryBookingStorage.getDeliveryBooking();
      yield DeliveryVechileTypeNotSelectedState(booking: deliveryBooking);
    }
    if(event is DeliveryVechileSelectedEvent){
      DeliveryBooking deliveryBooking;
      deliveryBooking= await DeliveryBookingStorage.getDeliveryBooking();

      yield PaymentMethodNotSelectedState(booking: deliveryBooking);
    }
    if(event is SelectPaymentMethodEvent){
      DeliveryBooking deliveryBooking;
      deliveryBooking= await DeliveryBookingStorage.getDeliveryBooking();
      yield DeliveryVechileTypeNotSelectedState(booking: deliveryBooking);
    }
    if(event is BackPressedEvent){
      switch (state.runtimeType) {
        case PaymentMethodNotSelectedState:
          DeliveryBooking deliveryBooking;
          deliveryBooking= await DeliveryBookingStorage.getDeliveryBooking();
          //print(deliveryBooking.source.longitude);
          yield DeliveryVechileTypeNotSelectedState(booking: deliveryBooking);
          break;
        default:
          yield DeliveryBookingNotInitializedState();
          break;
      }


    }

  }

}