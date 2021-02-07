import 'package:dataclass/dataclass.dart';
import 'package:flutter/cupertino.dart';

@dataClass
class PlaceData {
  var id;
  var address;
  var imageUrl;
  var rate;
  var phoneNumber;
  var totalSlot;
  var parkedSlot;
  var owner;
  PlaceData({
    @required this.id,
    @required this.address,
    @required this.imageUrl,
    @required this.rate,
    @required this.phoneNumber,
    @required this.totalSlot,
    @required this.parkedSlot,
    @required this.owner,
  });

  Map<String, dynamic> toJSON() => {
        'id': id,
        'address': address,
        'imageUrl': imageUrl,
        'rate': rate,
        'phoneNumber': phoneNumber,
        'totalSlot': totalSlot,
        'parkedSlot': parkedSlot,
        'owner': owner
      };

  void fromJSON(Map data) {
    id = data['id'];
    address = data['address'];
    imageUrl = data['imageUrl'];
    rate = data['rate'];
    phoneNumber = data['phoneNumber'];
    totalSlot = data['totalSlot'];
    parkedSlot = data['parkedSlot'];
    owner = data['owner'];
  }
}
