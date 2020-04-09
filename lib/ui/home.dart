import 'package:flutter/material.dart';
import 'inputpenjualan.dart';
import 'package:vape_store/models/penjualan.dart';
import 'package:vape_store/helpers/dbhelper.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DbHelper dbHelper= DbHelper();
  int count = 0;
  List<Penjualan> penjualanList;

  @override
  Widget build(BuildContext context) {
    if(penjualanList == null){
      penjualanList = List<Penjualan>();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Penjualan Liquid Vape'),
        leading: Icon(Icons.smoking_rooms),
      ),
      body: createListView(),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Input Penjualan Liquid Vape',
        onPressed: () async{
          var penjualan = await navigateToEntryForm(context, null);
          if(penjualan != null) addPenjualan(penjualan);
        },
      ),
    );
  }

  Future<Penjualan> navigateToEntryForm(BuildContext context, Penjualan penjualan) async{
    var result = await Navigator.push(
      context, 
      MaterialPageRoute(
        builder: (BuildContext context){
          return InputPenjualan(penjualan);
        }
      )
    );
    return result;
  }

  ListView createListView(){
    TextStyle textStyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index){
        return Card(
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blue,
              child: Icon(Icons.shopping_cart),
            ),
            title: Text(
              this.penjualanList[index].name, 
              style: textStyle,
            ),
            // subtitle: Row(
            //   children: <Widget>[
            //     Text(this.penjualanList[index].tanggal),
            //     Text(
            //       " | Rp. " + this.penjualanList[index].harga, 
            //       style: TextStyle(fontWeight: FontWeight.bold),
            //     ),
            //   ],
            // ),
            
            subtitle: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(this.penjualanList[index].merk),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text(this.penjualanList[index].tanggal),
                    Text(
                      " | Rp. " + this.penjualanList[index].harga, 
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.yellow[600]
                      ),
                    ),
                  ],
                )
              ],
            ),

            trailing: GestureDetector(
              child: Icon(Icons.delete, color: Colors.red,),
              // onTap: () async{
              //   var penjualan = await navigateToEntryForm(context, this.penjualanList[index]);
              //   if(penjualan != null) deletePenjualan(penjualanList[index]);
              // },
              onTap: (){
                // deletePenjualan(penjualanList[index]);
                deletePenjualan(penjualanList[index]);
              },
            ),
            onTap: () async{
              var penjualan=await navigateToEntryForm(context, this.penjualanList[index]);
              if(Penjualan != null) editPenjualan(penjualan);
            },
          ),
        );
      },
    );
  }

  void addPenjualan(Penjualan object) async{
    int result = await dbHelper.insert(object);
    if(result > 0){
      updateListView();
    }
  }

  void editPenjualan(Penjualan object) async{
    int result = await dbHelper.update(object);
    if(result>0){
      updateListView();
      print("ini editPenjualan RESULT $result");
    }
  }

  void deletePenjualan(Penjualan object) async{
    int result = await dbHelper.delete(object.id);
    if(result > 0){
      updateListView();
    }
  }

  void updateListView(){
    final Future<Database> dbFuture = dbHelper.initDb();
    dbFuture.then((database){
      Future<List<Penjualan>> penjualanListFuture=dbHelper.getPenjualanList();
      penjualanListFuture.then((penjualanList){
        setState((){
          this.penjualanList = penjualanList;
          this.count = penjualanList.length;
        });
      });
    });
  }
}