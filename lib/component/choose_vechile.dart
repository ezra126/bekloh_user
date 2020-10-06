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
  ChooseVechileWidget({this.totalPrice, this.currentVechileType});
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

  void estimatePrice(){

  }

  @override
  void initState() {
    // TODO: implement initState
    deliveryBooking = (BlocProvider.of<DeliveryBookingBloc>(context).state as DeliveryVechileTypeNotSelectedState).booking;
    selectedVechileType = deliveryBooking.vechileType;
    if (selectedVechileType == null) {
      selectedVechileType = VechileType.Platinum;
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
         buildTaxis(images),
      ],
    );
  }

  Widget buildTaxis(List<Image> images) {
    return Container(
      padding: EdgeInsets.only(top: 0),
      height: 180,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: vechileType.length,
          itemBuilder: (context,index){
            return Card(
              elevation: 10,
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedVechileType = vechileType[index];
                    print(selectedVechileType);
                    print(VechileType.Platinum);
                    widget.currentVechileType(selectedVechileType);
                  });
                },
                child: Opacity(
                  opacity: vechileType[index] == selectedVechileType ? 1.0 : 0.5,
                  child: Container(
                    height: vechileType[index] == selectedVechileType ? 180 : 150,
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
            );
          }
          ),
    );
  }
}
