import 'package:dataclass/dataclass.dart';

@dataClass
class ParkingData {
  var id;
  var imageUrl;
  var address;
  var rate;
  var parkOwner;
  var carOwner;
  var carLicense;
  var parkOwnerNumber;
  var carOwnerNumber;
  var startTime;
  var endTime;
  var startTimeInMilli;
  var endTimeInMilli;
  var status;

  ParkingData({
    this.id,
    this.imageUrl,
    this.address,
    this.rate,
    this.parkOwner,
    this.carOwner,
    this.carLicense,
    this.parkOwnerNumber,
    this.carOwnerNumber,
    this.startTime,
    this.endTime,
    this.startTimeInMilli,
    this.endTimeInMilli,
    this.status,
  });

  Map<String, dynamic> toJSON() => {
        'id': id,
        'imageUrl': imageUrl,
        'address': address,
        'rate': rate,
        'parkOwner': parkOwner,
        'carOwner': carOwner,
        'carLicense': carLicense,
        'carOwnerNumber': carOwnerNumber,
        'parkOwnerNumber': parkOwnerNumber,
        'startTime': startTime,
        'endTime': endTime,
        'startTimeInMilli': startTimeInMilli,
        'endTimeInMilli': endTimeInMilli,
        'status': status
      };
}
