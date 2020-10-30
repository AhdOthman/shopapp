import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/trans.dart';
import '../widgets/trans_list.dart';

class Transitem extends StatelessWidget {
  const Transitem({
    Key key,
    @required this.transactions,
    @required this.deletetx,
  }) : super(key: key);

  final Trans transactions;
  final Function deletetx;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 5,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: FittedBox(
                child: Text('\$${transactions.amount}')),
          ),
        ),
        title: Text(
         transactions.title,
          style: Theme.of(context).textTheme.title,
        ),
        subtitle: Text(
            DateFormat.yMMMMd().format(transactions.date)),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                
                label: Text('Delete'),
               textColor: Theme.of(context).errorColor,
                onPressed: () => deletetx(
                      transactions.id,  
                    ))
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () =>
                    deletetx(transactions.id)),
      ),
    );
  }
}
