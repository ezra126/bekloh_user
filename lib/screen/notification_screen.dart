import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
 // List<Order> allOrders=[];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
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
            title: Text('Notification'),
            centerTitle: true,
            bottom: TabBar(
              tabs: [
                Tab(text: "Booking Notification",),
                Tab(text: "Mass Notification",),
              ],
            ),
          ),

          body: TabBarView(
            children: [
              Center(child: Text("no order")),
              Text('ggg')
            ],
          ),
        ),
      ),
    );
  }
}



