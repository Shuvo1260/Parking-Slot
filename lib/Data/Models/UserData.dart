import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';

@dataClass
class UserData {
  var id;
  var name;
  var phoneNumber;
  var license;
  var email;
  var password;
  var imageUrl;

  UserData(
      {@required this.id,
      @required this.name,
      @required this.phoneNumber,
      @required this.license,
      @required this.email,
      @required this.password,
      @required this.imageUrl});

  Map<String, dynamic> toJSON() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'license': license,
        'email': email,
        'password': password,
        'imageUrl': imageUrl
      };

  void fromJSON(Map data) {
    id = data['id'];
    name = data['name'];
    phoneNumber = data['phoneNumber'];
    license = data['license'];
    email = data['email'];
    password = data['password'];
    imageUrl = data['imageUrl'];
  }
}
