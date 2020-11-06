import 'package:bekloh_user/services/OrderService/order_dbprovider.dart';
import 'package:bekloh_user/model/delivery_booking.dart';

class OrderRepository {
  Helper _helper = Helper();


  Future<List<Order>> fetchAllOrders() => _helper.getAllOrders();

  Future<Order> fetchOrder(int id) => _helper.getOrder(id);

  Future<void> deleteOrder(int id) => _helper.deleteOrder(id);

  Future<Order> insert(Order order) =>_helper.insert(order);

  Future<void> deleteDb() => _helper.deleteDatabase();

  Future<void> deleteAllTrip() => _helper.deleteAllOrders();

// Future<List<Players>> fetchPlayersByName(String name) => _playerApiProvider.fetchPlayersByName(name);
}