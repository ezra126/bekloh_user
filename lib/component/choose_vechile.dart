import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/component/bottomsheet_button.dart';
import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:bekloh_user/model/vechile_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseVechileWidget extends StatefulWidget {
  final double totalPrice;
  final Function currentVechileType;
  final ScrollController scrollController;
  ChooseVechileWidget({this.totalPrice, this.currentVechileType,this.scrollController});
  @override
  _ChooseVechileWidgetState createState() => _ChooseVechileWidgetState();
}

class _ChooseVechileWidgetState extends State<ChooseVechileWidget>
    with TickerProviderStateMixin<ChooseVechileWidget> {
  AnimationController animationController;

  Animation animation;
  DeliveryBooking deliveryBooking;
  VechileType selectedVechileType;
  List<VechileType> vechileType = [
    VechileType.Isuzu,
    VechileType.BoxVan,
    VechileType.Pickup
  ];

  void estimatePrice(){

  }

  @override
  void initState() {
    // TODO: implement initState
    deliveryBooking = (BlocProvider.of<DeliveryBookingBloc>(context).state as  DeliveryVechileAndPaymentTypeNotSelectedState).booking;
    selectedVechileType = deliveryBooking.vechileType;
    if (selectedVechileType == null) {
       //selectedVechileType = VechileType.Isuzu;
    }
   
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Image> images = [
      Image.asset(
        "assets/logos/truck1.png",
        height: MediaQuery.of(context).size.height/ 9,
       // width: MediaQuery.of(context).size.width / 2.3,
        fit: BoxFit.cover,
      ),
      Image.asset(
        "assets/logos/truck.png",
        height: MediaQuery.of(context).size.height/ 9,
      //  width: MediaQuery.of(context).size.width / 2.6,
        fit: BoxFit.cover,
      ),
      Image.asset(
        "assets/logos/pickup.png",
        height: MediaQuery.of(context).size.height/ 9,
        //width: MediaQuery.of(context).size.width / 2.8,
        fit: BoxFit.cover,
      ),
      Image.asset(
        "assets/logos/truck.png",
        height: MediaQuery.of(context).size.height/ 9,
        //  width: MediaQuery.of(context).size.width / 2.6,
        fit: BoxFit.cover,
      ),
      Image.asset(
        "assets/logos/pickup.png",
        height: MediaQuery.of(context).size.height/ 9,
        //width: MediaQuery.of(context).size.width / 2.8,
        fit: BoxFit.cover,
      ),
    ];
    return ListView.builder(
        controller: widget.scrollController,
        //shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: vechileType.length,
        itemBuilder: (context,index){
          return Container(
            height: 120,
            width: 150,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Card(
              elevation: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedVechileType = vechileType[index];
                    print(selectedVechileType);
                    //print(VechileType.Platinum);
                    widget.currentVechileType(selectedVechileType);
                  });
                },
                child: Opacity(
                  opacity: vechileType[index] == selectedVechileType ? 1 : 0.7,
                  child: Container(
                    height: 100,
                    //  height: vechileType[index] == selectedVechileType ? 180 : 150,
                    padding: const EdgeInsets.only(top: 0,left: 12,right: 12),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: vechileType[index] == selectedVechileType? Colors.red : Colors.transparent,
                        width: 2.0,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Column(
                            children: [
                              Text(
                                vechileType[index].toString().replaceFirst("VechileType.", ""),
                                style: Theme.of(context).textTheme.title,
                              ),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(16.0),
                                child: images[index],
                              ),
                            ],
                          ),
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            vechileType[index] == selectedVechileType
                                ? Icon(
                              Icons.check_circle,
                              size: 28.0,
                            )
                                : Container(
                              width: 0,
                              height: 0,
                            ),
                            vechileType[index] == selectedVechileType ?
                              Text('Vechicle Price',style: TextStyle(fontWeight: FontWeight.bold),)
                                :Padding(
                              padding: EdgeInsets.only(top: 12),
                              child:  Text('Vechicle Price',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),

                            SizedBox(height: 10,),
                            Text('22 br')
                          ],
                        )


                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
    );
     /* Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [

        buildTaxis(images),
        Container(
          height: 200,
        )

       //  ,

      ],
    );*/
  }

  Widget buildTaxis(List<Image> images) {
    return ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: vechileType.length,
        itemBuilder: (context,index){
          return Container(
            height: 120,
            width: 150,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Card(
                elevation: 10,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedVechileType = vechileType[index];
                      print(selectedVechileType);
                     // print(VechileType.Platinum);
                      widget.currentVechileType(selectedVechileType);
                    });
                  },
                  child: Opacity(
                    opacity: vechileType[index] == selectedVechileType ? 1 : 0.7,
                    child: Container(

                    //  height: vechileType[index] == selectedVechileType ? 180 : 150,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: vechileType[index] == selectedVechileType? Colors.red : Colors.transparent,
                          width: 2.0,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16.0),
                            child: images[index],
                          ),
                          SizedBox(
                            height: 12.0,
                          ),
                          Text(
                            vechileType[index].toString().replaceFirst("VechileType.", ""),
                            style: Theme.of(context).textTheme.title,
                          ),
                          SizedBox(
                            height: 12.0,
                          ),

                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }
        );
  }
}
