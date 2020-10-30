import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/text.dart';
import 'package:intl/intl.dart';
import 'package:shopapp/widgets/chart.dart';
import 'package:shopapp/widgets/newtrans.dart';
import './widgets/trans_list.dart';
import './models/trans.dart';

void main() {
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //       DeviceOrientation.portraitDown

  // ]);
  runApp(Myapp());
}

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.red,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white),
              ),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                      title: TextStyle(
                    fontFamily: 'OpenSans-Italic.ttf',
                    fontSize: 20,
                  )))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Trans> _usertrans = [
    // Trans(
    //   id: 'id1',
    //   title: 'name',
    //   amount: 99.09,
    //   date: DateTime.now(),
    // ),
    // Trans(id: 'id2', title: 'ahd', amount: 99.99, date: DateTime.now())
  ];
  bool _showChart = false;

  List<Trans> get _recentTrans {
    return _usertrans.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addnewTrans(String txTitle, double txAmount, DateTime choseendate) {
    final newTx = Trans(
        title: txTitle,
        amount: txAmount,
        date: choseendate,
        id: DateTime.now().toString());
    setState(() {
      _usertrans.add(newTx);
    });
  }

  void _startnewtrans(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () {},
            child: NewTrans(_addnewTrans),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deletetrans(String id) {
    setState(() {
      _usertrans.removeWhere((tx) => tx.id == id);
    });
  }

  List <Widget> buildlandscape (MediaQueryData mediaquery, AppBar appBar, Widget txlist){return [ Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Show Chart'),
                Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    }),
              ],
            ), _showChart
              ? Container(
                  height: (mediaquery.size.height -
                          appBar.preferredSize.height -
                          mediaquery.padding.top) *
                      0.7,
                  child: Chart(_recentTrans))
              : txlist,];}
List <Widget> buildport (MediaQueryData mediaquery, AppBar appBar, Widget txlist) {
return [Container(
                height: (mediaquery.size.height -
                        appBar.preferredSize.height -
                        mediaquery.padding.top) *
                    0.3,
                child: Chart(_recentTrans)), txlist];
}
  @override
  Widget build(BuildContext context) {
    final mediaquery =MediaQuery.of(context);
    final islandscape =
        mediaquery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Personal Expenese',
      ),
      actions: <Widget>[
        IconButton(
            icon: Icon(Icons.add), onPressed: () => _startnewtrans(context))
      ],
    );
    final txlist = Container(
        height: (mediaquery.size.height -
                appBar.preferredSize.height -
                mediaquery.padding.top) *
            0.7,
        child: Translist(_usertrans, _deletetrans));
    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
          child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (islandscape)
           ...buildlandscape(mediaquery,  appBar, txlist) ,
          if (!islandscape)
        ...buildport ( mediaquery,  appBar, txlist),
          
          
        ],
      )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startnewtrans(context),
      ),
    );
  }
}
