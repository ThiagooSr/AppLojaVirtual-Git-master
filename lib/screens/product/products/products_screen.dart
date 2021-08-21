import 'package:flutter/material.dart';
import 'package:lojavirtualapp/common/custom_drawer/custom_drawer.dart';
import 'package:lojavirtualapp/models/product_manager.dart';
import 'package:lojavirtualapp/models/user_manager.dart';
import 'package:lojavirtualapp/screens/product/products/components/product_list_tile.dart';
import 'package:lojavirtualapp/screens/product/products/components/search_dialog.dart';
//import 'package:lojavirtualapp/screens/base/products/components/product_list_tile.dart';
//import 'package:lojavirtualapp/screens/base/products/components/search_dialog.dart';
import 'package:provider/provider.dart';
//import 'package:html/dom.dart';

class ProductsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Consumer<ProductManager>(
          builder: (_, productManager, __){
            if(productManager.search.isEmpty){
              return const Text('Produto');
            }else{
              return LayoutBuilder(
                  builder: (_, constraints){
                    return GestureDetector(
                      onTap: ()async{
                        final search = await showDialog<String>(
                            context: context,
                            builder: (_) => SearchDialog(
                              productManager.search
                            ),
                        );
                      },
                      child:Container(
                      width: constraints.biggest.width,
                      child: Text(
                          productManager.search,
                              textAlign: TextAlign.center,
                      ),
                    ),
                    );
                  }
              );
            }
          },

        ),
        centerTitle: true,
        actions: <Widget>[
          Consumer<ProductManager>(
            builder: (_, productManager, __) {
              if (productManager.search.isEmpty) {
                return IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () async {
                    final search = await showDialog<String>(
                        context: context, builder: (_) => SearchDialog(
                        productManager.search
                    ));
                    if (search != null) {
                      productManager.search = search;
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () async {
                    productManager.search = '';
                  },
                );
              }
            },
          ),
          Consumer<UserManager>(
            builder: (_, userManager, __){
              if(userManager.adminEnabled){
                return IconButton(
                  icon: Icon(Icons.add),
                  onPressed: (){
                    Navigator.of(context).pushNamed
                      ('/edit_product',
                    );

                  },
                );
              }else{
                return Container();
              }
            },
          )
        ],
      ),
      body: Consumer<ProductManager>(builder: (_, productManager, __) {
        final filtereProducts = productManager.filtereProducts;
        return ListView.builder(

            itemCount: productManager.filtereProducts.length,
            itemBuilder: (_, index) {
              return ProductListTile(productManager.filtereProducts[index]);
            });
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        foregroundColor: Theme.of(context).primaryColor,
        onPressed: (){
          Navigator.of(context).pushNamed('/cart');

        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}
