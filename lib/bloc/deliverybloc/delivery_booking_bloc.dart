import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:bekloh_user/model/delivery_service_type.dart';
import 'package:bekloh_user/storage/delivery_booking_storage.dart';
import 'package:bloc/bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import  "dart:convert";

class DeliveryBookingBloc extends Bloc<DeliveryBookingEvent, DeliveryBookingState> {
  DeliveryBookingBloc() : super(DeliveryBookingNotInitializedState());


  @override
  Stream<DeliveryBookingState> mapEventToState(DeliveryBookingEvent event) async* {
    if(event is DeliveryServiceTypeSelectedEvent){


       final DeliveryServiceType deliveryServiceType=event.serviceType;
       DeliveryBookingStorage.open();
       DeliveryBookingStorage.addDetails(DeliveryBooking.named(deliveryServiceType: deliveryServiceType));
     //  DeliveryBookingStorage.getDeliveryBooking().then((value)  {print(value.deliveryServiceType);});
       yield DeliveryServiceTypeSelectedState(serviceType: deliveryServiceType);
    }

    if(event is DestinationNotSelectedEvent){
      final LatLng currentLocation=event.currentLocation;
      var booking = await DeliveryBookingStorage.getDeliveryBooking();
     // DeliveryBookingStorage.addDetails(DeliveryBooking.named(source: event.currentLocation ));
     // if(booking==null){
     //   DeliveryBookingStorage.open(); DeliveryBookingStorage.addDetails(DeliveryBooking.named(source: event.currentLocation ));
  //    }

      yield DestinationNotSelectedState(currentLocation);
    }

    if(event is PickupNotSelectedEvent){
     // DeliveryBookingStorage.open();
     // print('longiiiiiiiii');
      final LatLng currentLocation=event.currentLocation;
     // print(event.currentLocation.longitude);
      yield PickupNotSelectedState(currentLocation);
    }

    if(event is DestinationSelectedEvent){
     // var booking = await DeliveryBookingStorage.getDeliveryBooking();
      LatLng destination=event.destination;
      DeliveryBooking deliveryBooking;
      deliveryBooking =await DeliveryBookingStorage.addDetails(DeliveryBooking.named(destination: destination ));
     // yield DetailsNotFilledState(booking: deliveryBooking);
    }


    if(event is PickupLocationSelectedEvent){
      //DeliveryBookingStorage.open();
      LatLng startingLoc=event.startingLoc;

      DeliveryBooking deliveryBooking;

      deliveryBooking =await DeliveryBookingStorage.addDetails(DeliveryBooking.named(source: startingLoc));
      var booking = await DeliveryBookingStorage.getDeliveryBooking();
      print(booking.source);
     // yield DetailsNotFilledState();
    }
    if(event is DetailsSubmittedEvent){
      DeliveryBooking deliveryBooking;
      deliveryBooking =await DeliveryBookingStorage.addDetails(DeliveryBooking.named(bookingTime: event.scheduledTime,numberOfLabour: event.labour));
      deliveryBooking= await DeliveryBookingStorage.getDeliveryBooking();
      yield DeliveryVechileAndPaymentTypeNotSelectedState(booking: deliveryBooking);
    }
    if(event is DeliveryVechileAndPaymentSelectedEvent){
      DeliveryBooking deliveryBooking;
      print('ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff');
      deliveryBooking=await DeliveryBookingStorage.
      addDetails(DeliveryBooking.named(vechileType: event.vechileType,paymentType: event.paymentType,bookImage: event.bookImage));
      yield DeliveryBookingNotConfirmedState(booking: deliveryBooking);
    }
    if(event is SelectPaymentMethodEvent){
      DeliveryBooking deliveryBooking;
      deliveryBooking=await DeliveryBookingStorage.addDetails(DeliveryBooking.named(paymentType: event.paymentType));
      yield  DeliveryVechileAndPaymentTypeNotSelectedState(booking: deliveryBooking);
    }

    if(event is BackPressedEventFromPayment){
      DeliveryBooking deliveryBooking;
      deliveryBooking=await DeliveryBookingStorage.addDetails(DeliveryBooking.named(paymentType: event.paymentType));
      yield  DeliveryVechileAndPaymentTypeNotSelectedState(booking: deliveryBooking);
    }

    if(event is BackPressedEvent){
      switch (state.runtimeType) {
        case DeliveryServiceTypeSelectedState:
          DeliveryBookingStorage.resetDeliveryBooking();
          yield DeliveryBookingNotInitializedState();
          break;
        case DeliveryBookingNotConfirmedState:
          DeliveryBooking deliveryBooking;
          deliveryBooking= await DeliveryBookingStorage.getDeliveryBooking();
          yield DeliveryVechileAndPaymentTypeNotSelectedState(booking: deliveryBooking);
          break;
        case PaymentMethodNotSelectedState:
          DeliveryBooking deliveryBooking;
          deliveryBooking= await DeliveryBookingStorage.getDeliveryBooking();
          //print(deliveryBooking.source.longitude);
          yield  DeliveryVechileAndPaymentTypeNotSelectedState(booking: deliveryBooking);
          break;
        default:
          yield DeliveryBookingNotInitializedState();
          break;
      }


    }

  }

}


/*
List<String> items=[
  "hello","israel", "meska","belachew"
];

String encoded= json.encode(items);
// var encoded = json.encode([1, 2, { "a": null }]);
//var decoded = json.decode('["foo", { "bar": 499 }]');

String itemString= '\'${items.toString()}\'';



var decoded=json.decode('${encoded}');

print(decoded[0]);*/
