class AddressModel {
  final String? id;
  final String name;
  final String phoneNumber;
  final String pincode;
  final String stateName;
  final String cityName;
  final String houseName;
  final String areaName;

  AddressModel(
      {this.id,
      required this.name,
      required this.phoneNumber,
      required this.pincode,
      required this.stateName,
      required this.cityName,
      required this.houseName,
      required this.areaName});

  factory AddressModel.fromMap(Map<String, dynamic> map, {String? documentId}) {
    return AddressModel(
        id: documentId ?? map['id'] ?? '',
        name: map['name'] ?? '',
        phoneNumber: map['phoneNumber'] ?? '',
        pincode: map['pincode'] ?? '',
        stateName: map['stateName'] ?? '',
        cityName: map['cityName'] ?? '',
        houseName: map['houseName'] ?? '',
        areaName: map['areaName'] ?? '');
  }

  // Method to convert to map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'phoneNumber': phoneNumber,
      'pincode': pincode,
      'stateName': stateName,
      'cityName': cityName,
      'houseName': houseName,
      'areaName': areaName
    };
  }
}
