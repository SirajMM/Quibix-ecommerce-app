// ignore_for_file: prefer_typing_uninitialized_variables

class Address {
  final String? id;
  final String? name;
  final int? pinCode;
  final String? permanentAddress;
  final String? state;
  final String? city;
  final bool? isDefaultAddress;
  final countyCode;
  final int? phoneNumber;

  Address({
    this.countyCode,
    this.phoneNumber,
    this.name,
    this.pinCode,
    this.permanentAddress,
    this.state,
    this.isDefaultAddress,
    this.city,
    this.id,
  });
}
