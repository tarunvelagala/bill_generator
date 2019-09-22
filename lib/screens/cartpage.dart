import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bill_generator/models/model.dart';

class CartPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  showBill() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Text(
                      "Order Reciept".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: ScopedModel.of<CartModel>(context,
                            rebuildOnChange: true)
                        .total,
                    itemBuilder: (context, index) {
                      return ScopedModelDescendant<CartModel>(
                        builder: (context, child, model) {
                          return ListTile(
                            title: Text(model.cart[index].qty.toString() +
                                " x " +
                                model.cart[index].title),
                            trailing: Text("\₹ " +
                                (model.cart[index].qty *
                                        model.cart[index].price)
                                    .toString()),
                          );
                        },
                      );
                    },
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  ListTile(
                    title: Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 18.0),
                    ),
                    trailing: Text("\₹ " +
                        ScopedModel.of<CartModel>(context,
                                rebuildOnChange: true)
                            .totalCartValue
                            .toString()),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.indigo,
          title: Text("Cart"),
          actions: <Widget>[
            FlatButton(
                child: Text(
                  "Clear",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => ScopedModel.of<CartModel>(context).clearCart())
          ],
        ),
        body: ScopedModel.of<CartModel>(context, rebuildOnChange: true)
                    .cart
                    .length ==
                0
            ? Center(
                child: Text("No items in Cart"),
              )
            : Container(
                padding: EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  Expanded(
                    child: ListView.builder(
                      itemCount: ScopedModel.of<CartModel>(context,
                              rebuildOnChange: true)
                          .total,
                      itemBuilder: (context, index) {
                        return ScopedModelDescendant<CartModel>(
                          builder: (context, child, model) {
                            return ListTile(
                              title: Text(model.cart[index].title),
                              subtitle: Text(model.cart[index].qty.toString() +
                                  " x " +
                                  model.cart[index].price.toString() +
                                  " = " +
                                  (model.cart[index].qty *
                                          model.cart[index].price)
                                      .toString()),
                              trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.add),
                                      onPressed: () {
                                        model.updateProduct(model.cart[index],
                                            model.cart[index].qty + 1);
                                        // model.removeProduct(model.cart[index]);
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.remove),
                                      onPressed: () {
                                        model.updateProduct(model.cart[index],
                                            model.cart[index].qty - 1);
                                        // model.removeProduct(model.cart[index]);
                                      },
                                    ),
                                  ]),
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Total: \₹ " +
                            ScopedModel.of<CartModel>(context,
                                    rebuildOnChange: true)
                                .totalCartValue
                                .toString() +
                            "",
                        style: TextStyle(
                            fontSize: 24.0, fontWeight: FontWeight.bold),
                      )),
                  SizedBox(
                      width: double.infinity,
                      child: RaisedButton(
                        color: Colors.yellow[900],
                        textColor: Colors.white,
                        elevation: 0,
                        child: Text("Bill".toUpperCase()),
                        onPressed: () => showBill(),
                      ))
                ])));
  }
}
