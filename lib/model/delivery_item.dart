//import 'package:taxi_app/models/payment_method.dart';
import 'delivery_service_type.dart';


class DeliveryItem {
  final String id;
  final DeliveryServiceType deliveryServiceType ;
  final String deliveryItemPic;
  final String itemDetail;


  DeliveryItem(
      this.id,
      this.deliveryServiceType,
      this.deliveryItemPic,
      this.itemDetail
      );

  DeliveryItem.named({
    this.id,
    this.deliveryServiceType,
    this.deliveryItemPic,
    this.itemDetail,
  });


}