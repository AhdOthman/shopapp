import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTrans extends StatefulWidget {
  final Function addtx;

  NewTrans(this.addtx);

  @override
  _NewTransState createState() => _NewTransState();
}

class _NewTransState extends State<NewTrans> {
  final titleControl = TextEditingController();

  final amountControl = TextEditingController();

  DateTime selecteddate;

  void _submitdata() {
    if(amountControl.text.isEmpty){
      return;
    }
    final enteredtitle = titleControl.text;
    final enteredamount = double.parse(amountControl.text);

    if (enteredtitle.isEmpty || enteredamount <= 0 || selecteddate ==null) {
      return;
    }
    widget.addtx(enteredtitle, enteredamount, selecteddate);
    Navigator.of(context).pop();
  }

  void _presentdate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1999),
            lastDate: DateTime.now())
        .then((pickdate) {
      if (pickdate == null) {
        return;
      }
      setState(() {
        selecteddate = pickdate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
          child: Card(
        elevation: 6,
        child:
            Container(
              padding: EdgeInsets.only(top:10, left:10, right: 10, bottom: MediaQuery.of(context).viewInsets.bottom +10),
              child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[
          TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleControl,
              onSubmitted: (_) => _submitdata(),
          ),
          TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountControl,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitdata(),
          ),
          Container(
              margin: EdgeInsets.fromLTRB(2, 0, 0, 0),
              height: 70,
              child: Row(
                children: [
                  Expanded(
                      child: Text(selecteddate == null
                          ? 'No date chossen'
                          : 'Picked Date: ${DateFormat.yMd().format(selecteddate)}')),
                  FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Chosse date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      onPressed: _presentdate)
                ],
              ),
          ),
          Container(
              margin: EdgeInsets.all(6),
              child: RaisedButton(
                  textColor: Theme.of(context).textTheme.button.color,
                  color: Theme.of(context).primaryColor,
                  child: Text(
                    'AddTrans!',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  onPressed: _submitdata),
          )
        ]),
            ),
      ),
    );
  }
}
