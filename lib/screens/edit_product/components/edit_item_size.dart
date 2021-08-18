import 'package:flutter/material.dart';
import 'package:lojavirtualapp/common/custom_icon_button.dart';
import 'package:lojavirtualapp/models/item_size.dart';

class EditItemSize extends StatelessWidget {

  const EditItemSize({Key key,
    this.size, this.onRemove, this.onMoveUp, this.onMoveDow}) : super(key: key);

  final ItemSize size;
  final VoidCallback onRemove;
  final VoidCallback onMoveUp;
  final VoidCallback onMoveDow;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 20,
          child: TextFormField(
            initialValue: size.name,
            decoration: const InputDecoration(
              labelText: 'Título',
              isDense: true,
            ),
            validator: (name){
              if(name.isEmpty)
                return'Invalido';
              return null;
            },
            onChanged: (name) => size.name = name,
          ),
        ),
        const SizedBox(width: 5,),
        Expanded(
          flex: 20,
          child: TextFormField(
            initialValue: size.stock?.toString(),
            decoration: const InputDecoration(
              labelText: 'Estoque',
              isDense: true,

            ),
            keyboardType: TextInputType.number,
            validator: (stock){
              if (int.tryParse(stock) == null)
                return'Invalido';
              return null;
            },
            onChanged: (stock) => size.stock = int.tryParse(stock),
          ),
        ),
        const SizedBox(width: 5,),
        Expanded(
          flex: 30,
          child: TextFormField(
            initialValue: size.price?.toStringAsFixed(2),
            decoration: const InputDecoration(
              labelText: 'Preço',
              isDense: true,
              prefixText: 'R\$'
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            validator: (price){
              if(num.tryParse(price) == null)
                return 'Invalido';
              return null;
            },
            onChanged: (price) => size.price = num.tryParse(price),
          ),
        ),
        CustomIcomButton(
          iconData: Icons.remove,
          color: Colors.red,
          onTap: onRemove,
        ),
        CustomIcomButton(
          iconData: Icons.arrow_drop_up,
          color: Colors.black,
          onTap: onMoveUp,
        ),
        CustomIcomButton(
          iconData: Icons.arrow_drop_down,
          color: Colors.black,
          onTap: onMoveDow,
        ),
      ],
    );
  }
}
