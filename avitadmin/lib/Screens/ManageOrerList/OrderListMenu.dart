import 'package:adminwallpaper/Screens/ManageOrerList/OrderStatusScreens/CancelOrder.dart';
import 'package:adminwallpaper/Screens/ManageOrerList/OrderStatusScreens/PendingOrders.dart';
import 'package:adminwallpaper/Screens/ManageOrerList/OrderStatusScreens/SoldOrders.dart';
import 'package:flutter/material.dart';

class OrderListMenu extends StatefulWidget {
  const OrderListMenu({Key? key}) : super(key: key);

  @override
  _OrderListMenuState createState() => _OrderListMenuState();
}

class _OrderListMenuState extends State<OrderListMenu> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.black.withOpacity(.7),
          appBar: TabBar(
            tabs: [
              Tab(
                text: "pending",
                icon: Icon(
                  Icons.pending_actions,
                  color: Colors.grey,
                ),
              ),
              Tab(
                text: "sold",
                icon: Icon(Icons.production_quantity_limits_rounded,
                    color: Colors.grey),
              ),
              Tab(
                text: "canceled",
                icon: Icon(Icons.cancel, color: Colors.grey),
              )
            ],
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.all(10),
            child: TabBarView(
              children: [PendingOrders(), SoldOrder(), CancelOrders()],
            ),
          ),
        ),
      ),
    );
  }
}
