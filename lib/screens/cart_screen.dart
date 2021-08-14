import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../widgets/cart_item.dart' as ci;
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(15),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(fontSize: 20),
                  ),
                  Spacer(),
                  Chip(
                    label: Text(
                      '\$${cart.totalAmount.toStringAsFixed(2)}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  TextButton(
                    onPressed: () {
                      Provider.of<Orders>(context, listen: false).addOrder(
                          cart.item.values.toList(), cart.totalAmount);
                      cart.clear();
                    },
                    child: Text('ORDER NOW'),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => ci.CartItem(
              cart.item.values.toList()[i].id,
              cart.item.values.toList()[i].price,
              cart.item.values.toList()[i].quantity,
              cart.item.values.toList()[i].title,
              cart.item.keys.toList()[i],
            ),
            itemCount: cart.item.length,
          ))
        ],
      ),
    );
  }
}
