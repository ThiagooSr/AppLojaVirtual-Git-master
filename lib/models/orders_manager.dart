import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:lojavirtualapp/models/order.dart';
import 'package:lojavirtualapp/models/user.dart';


//Classe que cria a ordem de lista de
// pedidos, no qual mostra no menu lateral pedidos.
class OrdersManager extends ChangeNotifier{

  User user;

  List<Order> orders = [];
//Esse final acessa o Firebase
  final Firestore firestore = Firestore.instance;

  StreamSubscription _subscription;

  void updateUser(User user){
    this.user = user;
     orders.clear();

    _subscription?.cancel();
    if(user != null){
      _listenToOrders();
    }
  }

  void _listenToOrders(){
    //Esse void, busca no firestore o usuário pelo ID que está logado
    //naquele momento e busca todos os pedidos e coloca na lista de pedidos.
    firestore.collection('orders').where('user', isEqualTo: user.id)
        .snapshots().listen(
            (event) {
          orders.clear();
          for(final doc in event.documents){
            orders.add(Order.fromDocument(doc));
          }


          notifyListeners();
        });
  }
  @override
  void dispose() {
    super.dispose();
    _subscription?.cancel();
  }


}