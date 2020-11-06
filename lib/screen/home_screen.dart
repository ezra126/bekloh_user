import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_bloc.dart';
import 'package:bekloh_user/bloc/deliverybloc/delivery_booking_event.dart';
import 'package:bekloh_user/component/home_drawer.dart';
import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:bekloh_user/model/delivery_service_type.dart';
import 'package:bekloh_user/router/screens_argument.dart';
import 'package:bekloh_user/screen/account_screen.dart';
import 'package:bekloh_user/screen/notification_screen.dart';
import 'package:bekloh_user/screen/order_view_screen.dart';
import 'package:bekloh_user/services/OrderService/order_repository.dart';
import 'package:bekloh_user/storage/delivery_booking_storage.dart';
import 'package:bekloh_user/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.black);
  AssetImage apartment;
  AssetImage smallMove;
  static  List<Widget> _widgetOptions = <Widget>[
    ServiceSelector(),
    MyOrder(),
    NotificationScreen(),
    AccountScreen()

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('My order')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notification')
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Account'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.black45,
       // selectedLabelStyle: TextStyle(color:Colors.amber[800] ),
       // unselectedLabelStyle: TextStyle(color:Colors.blue),
        onTap: _onItemTapped,
      ),
    );
  }

}

class ServiceSelector extends StatefulWidget {
  @override
  _ServiceSelectorState createState() => _ServiceSelectorState();
}

class _ServiceSelectorState extends State<ServiceSelector> {
  AssetImage apartment;
  AssetImage smallMove;

  @override
  void didChangeDependencies() {
    apartment = AssetImage('assets/apartment.jpg');
    precacheImage(apartment, context);
    smallMove=  AssetImage("assets/smallmove.jpg");
    precacheImage(smallMove, context);
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       // backgroundColor: Colors.blue,
        title: Text('Bekloh'),
        centerTitle: true,
      ),
     // drawer: Drawer(child: MainDrawer()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            InkWell(
              onTap: (){
              //  BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryServiceTypeSelectedEvent(serviceType: DeliveryServiceType.SmallMove));
              //  Navigator.pushNamed(context, selectLocationRoute,arguments: ScreenArguments(LatLng(0,0)));
                Navigator.pushNamed(context, searchDriverRoute);
              },
              child: Container(
                height: 270,
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 13,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: smallMove,
                              fit: BoxFit.cover,
                            ),
                            // borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                            child: Text(
                              "Small Move",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),),
                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text('Small Move',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(height: 10,),
                              Text('An easy way to move one or two items')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
               BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryServiceTypeSelectedEvent(serviceType: DeliveryServiceType.HouseMove));
              //  DeliveryBookingStorage.getDeliveryBooking().then((value)  {
                //  print('valueeeeeeeeeeeeeeeeeeeeee');
                  //print(value.deliveryServiceType);});
               Navigator.pushNamed(context, selectLocationRoute,arguments: ScreenArguments(LatLng(0,0)));
              },
              child: Container(
                height: 270,
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 13,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/apartment.jpg"),
                              fit: BoxFit.cover,
                            ),
                            // borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                            child: Text(
                              "House move",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text('Store pickup & delivery',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(height: 10,),
                              Text('Get your in store purchase home')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: (){
                BlocProvider.of<DeliveryBookingBloc>(context).add(DeliveryServiceTypeSelectedEvent(serviceType: DeliveryServiceType.StoreDelivery));
                Navigator.pushNamed(context, selectLocationRoute,arguments: ScreenArguments(LatLng(0,0)));
              },
              child: Container(
                height: 270,
                padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  elevation: 13,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          width: 400,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/storedelivery.jpg"),
                              fit: BoxFit.fill,
                            ),
                            //     borderRadius: BorderRadius.circular(12),
                          ),
                          child: Container(
                            margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                            child: Text(
                              "Store Delivery",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        flex: 2,
                        child: Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text('Store pickup & delivery',style: TextStyle(fontWeight: FontWeight.bold),),
                              ),
                              SizedBox(height: 10,),
                              Text('Get your in store purchase home')
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  List<Order> allOrders=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void refresh(){
    context.repository<OrderRepository>().fetchAllOrders().then((value) {
      setState(() {
        allOrders = value;
      });
    });}

  @override
  void didChangeDependencies() {
    context.repository<OrderRepository>().fetchAllOrders().then((value) {
      setState(() {
        allOrders=value;
      });
      print('total orgder');
    //  print(allOrders[]);
    });
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Order'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "Pending",),
                Tab(text: "completed",),
              ],
            ),
          ),

          body: TabBarView(
            children: [
              (allOrders!=null) ?
           Container(
            child:  ListView.builder(
              reverse: false,
              itemCount: allOrders.length,
              itemBuilder: (context,int index){
                return PendingOrderList(order:allOrders[index],refresh: refresh,);
              },
            )):
              Center(child: Text("no order")),

              Text('ggg')
            ],
          ),
        ),
      ),
    );
  }
}

class PendingOrderList extends StatefulWidget{
  final Order order;
  final Function refresh;
  PendingOrderList({this.order,this.refresh});

  @override
  _PendingOrderListState createState() => _PendingOrderListState();
}

class _PendingOrderListState extends State<PendingOrderList> {
  @override
  Widget build(BuildContext context) {
    DateTime parseDt = DateTime.parse(widget.order.bookingTime);
    DateFormat.yMMMMEEEEd().format(parseDt);

  //  final String minutesStr = (( int.parse(order.bookingTime) / 60) % 60).floor().toString().padLeft(2, '0');
  //  final String secondsStr = ( int.parse(order.bookingTime) % 60).floor().toString().padLeft(2, '0');

    return new Card(
      child: new Container(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrderViewScreen(),
                      settings: RouteSettings(arguments: widget.order,),
                    ));

              },
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                    children: [
                      Text(DateFormat('E d MMM \'at\'').add_jm().format(DateTime.parse(widget.order.bookingTime))
                        ,style:TextStyle(fontWeight: FontWeight.bold,fontSize: 15) ,),
                      Text('300 birr')
                    ],
                  ),
                  SizedBox(height: 5,),
                  Text(widget.order.vechileType,style:TextStyle(fontWeight: FontWeight.w300,fontSize: 15)),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 0,top: 0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 0),
                              child: Icon(Icons.trip_origin, color: Colors.blue,),
                            ),
                            Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                            Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                            Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                            Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                            Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                            // Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                            //   Icon(Icons.fiber_manual_record, color: Colors.grey, size: 5),
                            Padding(
                              padding: const EdgeInsets.only(top: 2.0),
                              child: Icon(Icons.location_on, color: Colors.red,),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 5,),
                      Container(
                        padding: EdgeInsets.only(left: 0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Pick Up Location',style: TextStyle(fontWeight: FontWeight.w200),),
                            Container(
                                height: 30,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Text('Admas University Megnagna Campus,Admas',
                                        // textAlign: TextAlign.justify,
                                        maxLines: 5, // you can change it accordingly
                                        overflow: TextOverflow.clip,
                                      ),
                                    )
                                  ],
                                )),
                            Text('DropOff Location',style: TextStyle(fontWeight: FontWeight.w200),),
                            Container(
                                height: 30,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Text('Admas University Megnagna Campus,Admas',
                                        // textAlign: TextAlign.justify,
                                        maxLines: 5, // you can change it accordingly
                                        overflow: TextOverflow.clip,
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Divider(height: 1,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height:40,
                      child: Center(
                        child: Text('RESCHEDULE',style: TextStyle(color: Colors.white),),
                      ),
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(width: 12,),
                  Expanded(
                    child: GestureDetector(
                      onTap: (){
                        showDialog(
                            context: context,
                            builder: (dialogContext)=>AlertDialog(
                              title: new Text("Cancel Booking"),
                              content: new Text("Are you sure you want to Cancel your Booking?"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text('Yes'),
                                  onPressed: () {
                                    context.repository<OrderRepository>().deleteOrder(widget.order.id);
                                    widget.refresh();
                                    Navigator.of(dialogContext).pop();
                                  },
                                ),
                                FlatButton(
                                  child: Text('No'),
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop();

                                  },
                                )
                              ],
                            )
                        );
                      },
                      child: Container(
                        height:40,
                        child: Center(
                          child: Text('CANCEL BOOKING',style: TextStyle(color: Colors.white),),
                        ),
                        color: Colors.blue,
                      ),
                    ),
                  )
                ],),
            )

          ],
        )
      ),
    );
  }
}

/*
* Row(
          children: <Widget>[
            Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text( ""),
                ),

                Text("")

              ],
            ),
            SizedBox(width: 30,),
            Column(
              children: [
                Align(
                    child: Text('Israel')),
                Align(
                    child: Text('paid by cash')),
              ],
            ),

            Align(
              alignment: Alignment.center,
              child: Text('\$\ ${order.paymentType}'),
            )
            //  new Text(,style: TextStyle(fontSize: 20.0),)
          ],
        ),*/



/*
*
* import 'package:bekloh_user/component/home_drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectLocationScreen extends StatefulWidget {
  @override
  _SelectLocationScreenState createState() => _SelectLocationScreenState();
}

class _SelectLocationScreenState extends State<SelectLocationScreen> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static  List<Widget> _widgetOptions = <Widget>[
    ServiceSelector(),
    MyOrder(),
    Text(
      'Index 2: Notification',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.format_list_bulleted),
            title: Text('My order')
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            title: Text('Notification')
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

}

class ServiceSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bekloh'),
        centerTitle: true,
      ),
      drawer: Drawer(child: MainDrawer()),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 270,
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 13,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/smallmove.jpg"),
                            fit: BoxFit.cover,
                          ),
                          // borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Text(
                            "Mindfulness",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),),
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text('Small Move',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 10,),
                            Text('An easy way to move one or two items')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 270,
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 13,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/apartment.jpg"),
                            fit: BoxFit.cover,
                          ),
                          // borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Text(
                            "House move",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text('Store pickup & delivery',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 10,),
                            Text('Get your in store purchase home')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 270,
              padding: EdgeInsets.symmetric(horizontal: 25,vertical: 20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                elevation: 13,
                child: Column(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Container(
                        width: 400,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/storedelivery.jpg"),
                            fit: BoxFit.fill,
                          ),
                          //     borderRadius: BorderRadius.circular(12),
                        ),
                        child: Container(
                          margin: EdgeInsets.fromLTRB(15, 15, 0, 0),
                          child: Text(
                            "Store Delivery",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Text('Store pickup & delivery',style: TextStyle(fontWeight: FontWeight.bold),),
                            ),
                            SizedBox(height: 10,),
                            Text('Get your in store purchase home')
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text('My Order'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "Pending",),
                Tab(text: "completed",),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
*/
