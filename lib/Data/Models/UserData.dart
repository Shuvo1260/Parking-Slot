import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';

@dataClass
class UserData {
  var id;
  var name;
  var phoneNumber;
  var address;
  var email;
  var password;
  var imageUrl;

  UserData(
      {@required this.id,
      @required this.name,
      @required this.phoneNumber,
      @required this.address,
      @required this.email,
      @required this.password,
      @required this.imageUrl});

  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'address': address,
        'email': email,
        'password': password,
        'imageUrl': imageUrl
      };

  void fromJSON(Map data) {
    id = data['id'];
    name = data['name'];
    phoneNumber = data['phoneNumber'];
    address = data['address'];
    email = data['email'];
    password = data['password'];
    imageUrl = data['imageUrl'];
  }
}
