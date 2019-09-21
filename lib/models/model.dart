import 'package:bill_generator/utils/utils.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  List<Product> cart = [];
  double totalCartValue = 0;
  int get total => cart.length;
  void addProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    print(index);
    if (index != -1) {
      updateProduct(product, product.qty + 1);
    } else {
      cart.add(product);
      calculateTotal();
      notifyListeners();
    }
  }

  void removeProduct(product) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty = 1;
    cart.removeWhere((item) => item.id == product.id);
    calculateTotal();
    notifyListeners();
  }

  void updateProduct(product, qty) {
    int index = cart.indexWhere((i) => i.id == product.id);
    cart[index].qty = qty;
    if (cart[index].qty == 0) removeProduct(product);

    calculateTotal();
    notifyListeners();
  }

  void clearCart() {
    cart.forEach((f) => f.qty = 1);
    cart = [];
    notifyListeners();
  }

  void calculateTotal() {
    totalCartValue = 0;
    cart.forEach((f) {
      totalCartValue += f.price * f.qty;
    });
  }
}

class Product {
  int id;
  String title;
  int price;
  int qty;

  Product({this.id, this.title, this.price, this.qty});
}

/*
List<Product> products = [
  Product(id: 1, title: "Basmati Rice", price: 20.0, qty: 1),
  Product(id: 1, title: "Sonamasori Rice", price: 20.0, qty: 1),
  Product(id: 2, title: "Banana", price: 40.0, qty: 1),
  Product(id: 3, title: "Orange", price: 20.0, qty: 1),
  Product(id: 4, title: "Melon", price: 40.0, qty: 1),
  Product(id: 5, title: "Avocado", price: 25.0, qty: 1),
];
*/
var products = List<Product>.generate(itemsMap.length, (i) {
  return Product(
      id: i,
      title: itemsMap.keys.elementAt(i),
      price: itemsMap.values.elementAt(i),
      qty: 1);
});
