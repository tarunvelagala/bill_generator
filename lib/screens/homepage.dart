import 'package:bill_generator/screens/cartpage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bill_generator/models/model.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
                context,
                CupertinoPageRoute(
                    builder: (BuildContext context) => CartPage())),
          ),
        ],
      ),
      body: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Menu",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                // shrinkWrap: true,
                itemCount: products.length,
                itemBuilder: (BuildContext context, int index) {
                  return ScopedModelDescendant<CartModel>(
                    builder: (context, child, model) {
                      return ListTile(
                        title: Text(products[index].title),
                        subtitle:
                            Text("\₹ " + products[index].price.toString()),
                        trailing: OutlineButton(
                            child: Text(
                              "ADD",
                              style: TextStyle(color: Colors.yellow[900]),
                            ),
                            onPressed: () {
                              model.addProduct(products[index]);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                duration: Duration(seconds: 1),
                                backgroundColor: Colors.indigo,
                                content: Text(
                                  "Added " + products[index].title,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ));
                            }),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*GridView.builder(
        padding: EdgeInsets.all(8.0),
        itemCount: products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.8),
        itemBuilder: (context, index) {
          return ScopedModelDescendant<CartModel>(
              builder: (context, child, model) {
            return Card(
                child: Column(children: <Widget>[
              /*Image.network(
                products[index].imgUrl,
                height: 120,
                width: 120,
              )*/
              Text(
                products[index].title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("\$" + products[index].price.toString()),
              OutlineButton(
                  child: Text("Add"),
                  onPressed: () => model.addProduct(products[index]))
            ]));
          });
        },
      ),
*/
