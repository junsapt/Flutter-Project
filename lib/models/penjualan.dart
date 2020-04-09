class Penjualan{
  int _id;
  String _name;
  String _merk;
  String _harga;
  String _tanggal;

  Penjualan(this._name, this._merk, this._harga, this._tanggal);

  Penjualan.fromMap(Map<String, dynamic> map){
    this._id=map['id'];
    this._name=map['name'].toString();
    this._merk=map['merk'].toString();
    this._harga=map['harga'].toString();
    this._tanggal=map['tanggal'].toString();
  }

  int get id => _id;
  String get name => _name;
  String get merk => _merk;
  String get harga => _harga;
  String get tanggal => _tanggal;

  set name(String value){
    name=value;
  }
  set merk(String value){
    merk=value;
  }
  set harga(String value){
    harga=value;
  }
  set tanggal(String value){
    tanggal=value;
  }

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map= Map<String, dynamic>();

    map['id']=this._id;
    map['name']=name;
    map['merk']=merk;
    map['harga']=harga;
    map['tanggal']=tanggal;

    return map;
  }
}

