import 'package:flutter/material.dart';
import 'package:flutter/src/material/theme_data.dart';
import '../models/trans.dart';
import 'package:intl/intl.dart';
import './transitem.dart';

class Translist extends StatelessWidget {
  final List<Trans> transactions;
  final Function deletetx;

  Translist(this.transactions, this.deletetx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 400,
        child: transactions.isEmpty
            ? LayoutBuilder(builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text('No Transaction Aded Yet!',
                        style: Theme.of(context).textTheme.title),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        height: constraints.maxHeight * 0.6,
                        child: Image.asset('assets/images/zzz.png'))
                  ],
                );
              })
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Transitem(transactions: transactions[index], deletetx: deletetx);
                },
                itemCount: transactions.length,
              ));
  }
}

