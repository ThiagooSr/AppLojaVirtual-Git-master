import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lojavirtualapp/models/home_manager.dart';
import 'package:lojavirtualapp/models/product.dart';
import 'package:lojavirtualapp/models/product_manager.dart';
import 'package:lojavirtualapp/models/section.dart';
import 'package:lojavirtualapp/models/section_item.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

class ItemTile extends StatelessWidget {
  const ItemTile(this.item);

  final SectionItem item;
  @override
  Widget build(BuildContext context) {
    final homeManager = context.watch<HomeManager>();
    return GestureDetector(
      onTap: () {
        if (item.product != null) {
          final product =
              context.read<ProductManager>().findProductById(item.product);
          if (product != null) {
            Navigator.of(context).pushNamed('/product', arguments: product);
          }
        }
      },
      onLongPress: homeManager.editing
          ? () {
              showDialog(
                  context: context,
                  builder: (_) {
                    final product = context
                        .read<ProductManager>()
                        .findProductById(item.product);
                    return AlertDialog(
                      title: const Text('Editar Item'),
                      content: product != null
                          ? ListTile(
                              contentPadding: EdgeInsets.zero,
                              leading: Image.network(product.images.first),
                              title: Text(product.name),
                              subtitle: Text(
                                  'R\$ ${product.basePrice.toStringAsFixed(2)}'),
                            )
                          : null,
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            context.read<Section>().removeItem(item);
                            Navigator.of(context).pop();
                          },
                          textColor: Colors.red,
                          child: const Text('Excluir'),
                        ),
                        FlatButton(
                          onPressed: () async {
                            if (product != null) {
                              item.product = null;
                            } else {
                              final Product product =
                                  await Navigator.of(context)
                                      .pushNamed('/select_product') as Product;
                              item.product = product?.id;
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text(
                              product != null ? 'Desvincular' : 'Vincular'),
                        ),
                      ],
                    );
                  });
            }
          : null,
      child: AspectRatio(
        aspectRatio: 1,
        child: item.image is String
            ? Container(
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Container(
                decoration: BoxDecoration(
                    borderRadius:
                    const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                        image: NetworkImage(item.image as String),
                        fit: BoxFit.cover))))
            : Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Image.file(
            item.image as File,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
