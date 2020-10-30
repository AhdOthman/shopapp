
import 'package:flutter/material.dart ';
 
 class Chartbar extends StatelessWidget {
final String label;
final double spendamount;
final double spenrprc;

Chartbar(this.label, this.spendamount, this.spenrprc);
 
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraint) {
      return Column(children: <Widget>[
      Container(height: 20,child: FittedBox(child: Text('\$${spendamount.toStringAsFixed(0)}'))),
      SizedBox(height: 10),
      Container(
        height: constraint.maxHeight * 0.5,
        width: 10,
        child: Stack(children: <Widget> [
        Container(
         decoration: BoxDecoration(border: Border.all(color: Colors.grey, width: 1),
         color: Color.fromRGBO(220,220,220,1),
         borderRadius: BorderRadius.circular(10)
         )
       ),
       FractionallySizedBox(heightFactor: spenrprc,
       child: Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10)
) ,
       )
      )],),),

      SizedBox(height: 2,),
      Text(label),

    ],);
    }); 
  }
}