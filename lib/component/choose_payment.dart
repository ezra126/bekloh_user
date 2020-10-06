import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_state.dart';
import 'package:bekloh_user/model/payment_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChoosePaymentWidget extends StatefulWidget {
  final Function selectedPaymentType;
  const ChoosePaymentWidget({Key key, this.selectedPaymentType}) : super(key: key);
  @override
  _ChoosePaymentWidgetState createState() => _ChoosePaymentWidgetState();
}

class _ChoosePaymentWidgetState extends State<ChoosePaymentWidget> {
  PaymentType selectedPaymentType;
  List<PaymentType> paymentTypeList = [
    PaymentType.Cash,
    PaymentType.Wallet
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     var booking= (BlocProvider.of<DeliveryBookingBloc>(context).state as PaymentMethodNotSelectedState).booking;
     selectedPaymentType = booking.paymentType;
    if (selectedPaymentType == null) {
      selectedPaymentType = PaymentType.Cash;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Select Payment",
                style: Theme.of(context).textTheme.headline,
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedPaymentType = PaymentType.Cash;
                      widget.selectedPaymentType(selectedPaymentType);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Color(0xffeeeeee).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            width: 56.0,
                            height: 56.0,
                            child: Icon(
                              Icons.attach_money
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "Cash",
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "Default(current payment)",
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            ],
                          ),
                        ),
                        selectedPaymentType == PaymentType.Cash
                            ? Icon(
                          Icons.check_circle,
                          size: 28.0,
                        )
                            : Container(
                          width: 0,
                          height: 0,
                        )
                      ],
                    ),
                  )
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                  onTap: (){
                    setState(() {
                      selectedPaymentType = PaymentType.Wallet;
                      widget.selectedPaymentType(selectedPaymentType);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                        color: Color(0xffeeeeee).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16.0),
                          child: Container(
                            width: 56.0,
                            height: 56.0,
                            child: Icon(
                                Icons.attach_money
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 16.0,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              Text(
                                "Wallet",
                                style: Theme.of(context).textTheme.title,
                              ),
                              SizedBox(
                                height: 4.0,
                              ),
                              Text(
                                "no amount in wallet",
                                style: Theme.of(context).textTheme.subtitle,
                              ),
                            ],
                          ),
                        ),
                        selectedPaymentType == PaymentType.Wallet
                            ? Icon(
                          Icons.check_circle,
                          size: 28.0,
                        )
                            : Container(
                          width: 0,
                          height: 0,
                        )
                      ],
                    ),
                  )
              ),
            ],
          ),
        ),
      ),
    );
  }


}
