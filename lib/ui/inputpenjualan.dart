import 'package:flutter/material.dart';
import 'package:vape_store/models/penjualan.dart';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';



class InputPenjualan extends StatefulWidget {
  final Penjualan penjualan;
  InputPenjualan(this.penjualan);
  @override
  _InputPenjualanState createState() => _InputPenjualanState(this.penjualan);
}

class _InputPenjualanState extends State<InputPenjualan> {
  Penjualan penjualan;
  _InputPenjualanState(this.penjualan);

  TextEditingController nameController = TextEditingController();
  TextEditingController merkController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController tanggalController = TextEditingController();
  final format=DateFormat('yyyy-MM-dd');

  @override
  Widget build(BuildContext context) {
    if(penjualan != null){
      nameController.text = penjualan.name;
      merkController.text = penjualan.merk;
      hargaController.text = penjualan.harga;
      tanggalController.text = penjualan.tanggal;
    }

    return Scaffold(
      appBar: AppBar(
        title: penjualan==null?Text("Transaksi Baru"):Text("Update Transaksi"),
        leading: Icon(Icons.keyboard_arrow_left),
      ),

      body: Padding(
        padding: EdgeInsets.only(
          top: 15.0,
          left: 10.0,
          right: 10.0
        ),

        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nama Pembeli",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)
                  ),
                ),
                onChanged: (value){

                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: merkController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Merk Liquid Vape",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)
                  ),
                ),
                onChanged: (value){

                },
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                controller: hargaController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Harga",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(3.0)
                  ),
                ),
                onChanged: (value){

                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: <Widget>[
                  DateTimeField(
                    controller: tanggalController,
                    format: format, 
                    onShowPicker: (context, currentValue){
                      return showDatePicker(
                        context: context, 
                        initialDate: currentValue??DateTime.now(), 
                        firstDate: DateTime(2020), 
                        lastDate: DateTime(2045)
                      );
                    },
                    decoration: InputDecoration(
                      labelText: "Tanggal",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(3.0)
                      )
                    ),
                  )
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Simpan",
                        textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        if(penjualan == null){
                          penjualan=Penjualan(
                            nameController.text, 
                            merkController.text, 
                            hargaController.text, 
                            tanggalController.text
                          );
                        }
                        else{
                          penjualan.name=nameController.text;
                          penjualan.merk=merkController.text;
                          penjualan.harga=hargaController.text;
                          penjualan.tanggal=tanggalController.text;
                          print("ini Update ya");
                        }
                        Navigator.pop(context, penjualan);
                      },
                    ),
                  ),

                  Container(width: 5.0,),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        "Batal",
                        textScaleFactor: 1.5,
                      ),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}