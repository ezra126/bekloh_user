//import 'package:taxi_app/models/payment_method.dart';
import 'dart:ui';



class DeliveryItem {
  final List<Image> deliveryItemPic;
  final String itemDetailDescription;
  final List<String> items;


  DeliveryItem(
      this.items,
      this.deliveryItemPic,
      this.itemDetailDescription
      );

  DeliveryItem.named({
    this.items,
    this.deliveryItemPic,
    this.itemDetailDescription,
  });


}