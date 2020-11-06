import 'package:bekloh_user/model/delivery_booking.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';

class Helper {
  final String tableOrders = 'myorder';
  final String columnId = '_id';
  final String columnDestinationLoc = 'destination';
  final String columnSourceLoc = 'source';
  final String columnBookingTime = 'bookingTime';
  final String columnVechileType = 'vechileType';
  final String columnPaymentType = 'paymentType';
  final String columnDeliveryServiceType = 'deliveryServiceType';
  final String columnBookImage = 'bookImage';


  static final Helper _instance = new Helper.internal();
  factory Helper() => _instance;

  static Database _db;

  Future<Database> get db async {
    if(_db != null)
      return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "myorder.db");
    var theDb = await openDatabase(path, version: 1, onCreate: (Database db, int version) async {
      await db.execute('''
          create table $tableOrders ( 
          $columnId integer primary key autoincrement, 
          $columnDestinationLoc text not null,
          $columnSourceLoc text not null,
          $columnBookingTime text not null,
          $columnVechileType text not null,
          $columnPaymentType text not null,
          $columnDeliveryServiceType text not null,
          $columnBookImage text not null
          )
          ''');
    });
    return theDb;
  }


  Helper.internal();

  Future<Order> insert(Order order) async {
    print('adedeedddd suceeeeeeeeeeeeeeeeeeeeeeeeeeeeee');
    var dbClient = await db;
    await dbClient.insert(tableOrders, order.toMap());
    return order;
  }

  Future<Order> getOrder(int id) async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableOrders,
        columns: [columnId, columnDestinationLoc,columnSourceLoc, columnBookingTime,
          columnVechileType,columnPaymentType,columnDeliveryServiceType,columnBookImage],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return Order.fromMap(maps.first);
    }
    return null;
  }

  Future<int> deleteOrder(int id) async {
    var dbClient = await db;
    print('delete sucess');
    return await dbClient.delete(tableOrders, where: '$columnId = ?', whereArgs: [id]);
  }


  Future<List<Order>> getAllOrders() async {
    List<Order> orders = List();
    var dbClient = await db;
    List<Map> maps = await dbClient.query(tableOrders,
      columns: [columnId, columnDestinationLoc,columnSourceLoc, columnBookingTime,
        columnVechileType,columnPaymentType,columnDeliveryServiceType,columnBookImage]);
    if (maps.length > 0) {
      maps.forEach((f) {
        orders.add(Order.fromMap(f));
//          print("getAllUsers"+ User.fromMap(f).toString());
      });
    }
    return orders;
  }

  Future<void> deleteAllOrders() async {
    var dbClient = await db;
    var result = await dbClient.delete(tableOrders);
    print('delete successssssssssssssssssssssss');
    return result;
  }

  Future<void> deleteDatabase() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "order.db");
    return databaseFactory.deleteDatabase(path).then((value) => {
      print('delete success')
    });
  }


  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}