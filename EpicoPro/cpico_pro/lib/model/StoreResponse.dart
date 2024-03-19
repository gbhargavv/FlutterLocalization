class StoreResponse {
  String? _code;
  String? _message;
  List<Data>? _data;

  StoreResponse({String? code, String? message, List<Data>? data}) {
    if (code != null) {
      this._code = code;
    }
    if (message != null) {
      this._message = message;
    }
    if (data != null) {
      this._data = data;
    }
  }

  String? get code => _code;

  set code(String? code) => _code = code;

  String? get message => _message;

  set message(String? message) => _message = message;

  List<Data>? get data => _data;

  set data(List<Data>? data) => _data = data;

  StoreResponse.fromJson(Map<String, dynamic> json) {
    _code = json['code'];
    _message = json['message'];
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this._code;
    data['message'] = this._message;
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  List<Stores>? _stores;

  Data({List<Stores>? stores}) {
    if (stores != null) {
      this._stores = stores;
    }
  }

  List<Stores>? get stores => _stores;

  set stores(List<Stores>? stores) => _stores = stores;

  Data.fromJson(Map<String, dynamic> json) {
    if (json['stores'] != null) {
      _stores = <Stores>[];
      json['stores'].forEach((v) {
        _stores!.add(new Stores.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._stores != null) {
      data['stores'] = this._stores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stores {
  String? _value;
  String? _title;

  Stores({String? value, String? title}) {
    if (value != null) {
      this._value = value;
    }
    if (title != null) {
      this._title = title;
    }
  }

  String? get value => _value;

  set value(String? value) => _value = value;

  String? get title => _title;

  set title(String? title) => _title = title;

  Stores.fromJson(Map<String, dynamic> json) {
    _value = json['value'];
    _title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['value'] = this._value;
    data['title'] = this._title;
    return data;
  }
}
