import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/component/bottomsheet_button.dart';
import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:bekloh_user/model/vechile_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChooseVechileWidget extends StatefulWidget {
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
    VechileType.Platinum,
    VechileType.Premium,
    VechileType.Standard
  ];


  @override
  void initState() {
    // TODO: implement initState
    deliveryBooking = (BlocProvider.of<DeliveryBookingBloc>(context).state
            as DeliveryVechileTypeNotSelectedState).booking;
    selectedVechileType = deliveryBooking.vechileType;
    if (selectedVechileType == null) {
      selectedVechileType = VechileType.Standard;
    }
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = CurvedAnimation(
      curve: Curves.easeInExpo,
      parent: animationController,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Image> images = [
      Image.asset(
        "assets/logos/truck1.png",
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 2.3,
        fit: BoxFit.cover,
      ),
      Image.asset(
        "assets/logos/truck.png",
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 2.6,
        fit: BoxFit.cover,
      ),
      Image.asset(
        "assets/logos/pickup.png",
        height: MediaQuery.of(context).size.width / 4,
        width: MediaQuery.of(context).size.width / 2.8,
        fit: BoxFit.cover,
      ),
    ];
    return Container(
      height: 400,
      child: Column(
        children: [
          Expanded(
            child:buildTaxis(images),
          ),

        ],
      ),
    );
  }

  Widget buildTaxis(List<Image> images) {

    return Container(
      height: 100,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: vechileType.length,
          itemBuilder: (context,index){
            return Container(
              width: 200,
              height: 100,
              child: Card(
                elevation: 5,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedVechileType = vechileType[index];
                      print(selectedVechileType);
                    });
                  },
                  child: Opacity(
                    opacity: vechileType[index] == selectedVechileType ? 1.0 : 0.5,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
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
                            vechileType[index].toString().replaceFirst("TaxiType.", ""),
                            style: Theme.of(context).textTheme.title,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
          ),
    );
  }
}
