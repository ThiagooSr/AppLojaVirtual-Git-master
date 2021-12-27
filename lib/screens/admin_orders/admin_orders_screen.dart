import 'package:flutter/material.dart';
import 'package:lojavirtualapp/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/common/custom_icon_button.dart';
import 'package:lojavirtualapp/common/empty_card.dart';
import 'package:lojavirtualapp/models/admin_orders__manager.dart';
import 'package:lojavirtualapp/screens/orders/components/order_tile.dart';
import 'package:provider/provider.dart';

class AdminOrdersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: const Text('Todos os Pedidos'),
        centerTitle: true,
      ),
      body: Consumer<AdminOrderManager>(
          builder: (_, ordersManager, __) {
        final filteredOrders = ordersManager.filteredOrders;

        return Column(
          children: <Widget>[
            if (ordersManager.userFilter != null)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 2),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Pedidos de ${ordersManager.userFilter.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    CustomIcomButton(
                      iconData: Icons.close,
                      color: Colors.white,
                      onTap: () {
                        ordersManager.setUserFilter(null);
                      },
                    )
                  ],
                ),
              ),
            if (filteredOrders.isEmpty)
              Expanded(
                child: EmptyCard(
                  title: 'Nenhuma venda realizada!',
                  iconData: Icons.border_clear,
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                    itemCount: filteredOrders.length,
                    itemBuilder: (_, index) {
                      return OrderTile(
                        filteredOrders[index],
                        showControls: true,
                      );
                    }),
              )
          ],
        );
      }),
    );
  }
}
