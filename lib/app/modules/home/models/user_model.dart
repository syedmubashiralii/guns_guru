class UserModel {
  String? address;
  String? city;
  String? cnic;
  // String? cnicBackSide;
  // String? cnicFrontSide;
  String? dob;
  String? gender;
  String? firstname;
  String? phoneno;
  String? lastname;
  List<License>? license;
  String? uid;

  UserModel(
      {this.address,
      this.city,
      this.cnic,
      // this.cnicBackSide,
      // this.cnicFrontSide,
      this.dob,
      this.gender,
      this.firstname,
      this.phoneno,
      this.lastname,
      this.license,
      this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    cnic = json['cnic'];
    // cnicBackSide = json['cnic_back_side'];
    // cnicFrontSide = json['cnic_front_side'];
    dob = json['dob'];
    phoneno= json['phoneno'];
    gender=json['gender'];
    firstname = json['firstname'];
    lastname= json['lastname'];
    if (json['license'] != null) {
      license = <License>[];
      json['license'].forEach((v) {
        license!.add(License.fromJson(v));
      });
    }
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['cnic'] = cnic;
    data['gender'] = gender;
    // data['cnic_back_side'] = this.cnicBackSide;
    // data['cnic_front_side'] = this.cnicFrontSide;
    data['dob'] = dob;
    data['phoneno'] = phoneno;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    if (license != null) {
      data['license'] = license!.map((v) => v.toJson()).toList();
    }
    data['uid'] = uid;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['address'] = address;
    data['city'] = city;
    data['cnic'] = cnic;
    // data['cnic_back_side'] = this.cnicBackSide;
    // data['cnic_front_side'] = this.cnicFrontSide;
    data['dob'] = dob;
    data['gender']=gender;
    data['phoneno'] = phoneno;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    if (license != null) {
      data['license'] = license!.map((v) => v.toMap()).toList();
    }
    data['uid'] = uid;
    return data;
  }
}

class License {
  List<AmmunitionDetail>? ammunitionDetail;
  String? licenseAmmunitionLimit;
  String? licenseCalibre;
  String? licenseDateOfIssuance;
  String? licenseIssuaingQuota;
  String? licenseIssuingAuthority;
  String? licenseJurisdiction;
  String? licenseNumber;
  String? licenseweaponType;
  String? licensePicture;
  String? licenseTrackingNumber;
  String? licenseValidTill;
  bool? licenseValidated;
  WeaponDetails? weaponDetails;
  List<WeaponFiringRecord>? weaponFiringRecord;
  List<WeaponServiceRecord>? weaponServiceRecord;

  License(
      {this.ammunitionDetail,
      this.licenseAmmunitionLimit,
      this.licenseCalibre,
      this.licenseDateOfIssuance,
      this.licenseIssuaingQuota,
      this.licenseIssuingAuthority,
      this.licenseJurisdiction,
      this.licenseNumber,
      this.licenseweaponType,
      this.licensePicture,
      this.licenseTrackingNumber,
      this.licenseValidated,
      this.licenseValidTill,
      this.weaponDetails,
      this.weaponFiringRecord,
      this.weaponServiceRecord});

  License.fromJson(Map<String, dynamic> json) {
    if (json['ammunitionDetail'] != null) {
      ammunitionDetail = <AmmunitionDetail>[];
      json['ammunitionDetail'].forEach((v) {
        ammunitionDetail!.add(AmmunitionDetail.fromJson(v));
      });
    }
    licenseAmmunitionLimit = json['licenseAmmunitionLimit'];
    licenseCalibre = json['licenseCalibre'];
    licenseDateOfIssuance = json['licenseDateOfIssuance'];
    licenseIssuaingQuota = json['licenseIssuaingQuota'];
    licenseIssuingAuthority = json['licenseIssuingAuthority'];
    licenseJurisdiction = json['licenseJurisdiction'];
    licenseNumber = json['licenseNumber'];
    licenseweaponType=json['weaponType'];
    licensePicture = json['licensePicture'];
    licenseTrackingNumber = json['licenseTrackingNumber'];
    licenseValidTill = json['licenseValidTill'];
    licenseValidated = json['licenseValidated'];
    weaponDetails = json['weaponDetails'] != null
        ? WeaponDetails.fromJson(json['weaponDetails'])
        : null;
    if (json['weaponFiringRecord'] != null) {
      weaponFiringRecord = <WeaponFiringRecord>[];
      json['weaponFiringRecord'].forEach((v) {
        weaponFiringRecord!.add(WeaponFiringRecord.fromJson(v));
      });
    }
    if (json['weaponServiceRecord'] != null) {
      weaponServiceRecord = <WeaponServiceRecord>[];
      json['weaponServiceRecord'].forEach((v) {
        weaponServiceRecord!.add(WeaponServiceRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ammunitionDetail != null) {
      data['ammunitionDetail'] =
          ammunitionDetail!.map((v) => v.toJson()).toList();
    }
    data['licenseAmmunitionLimit'] = licenseAmmunitionLimit;
    data['weaponType'] =licenseweaponType;
    data['licenseCalibre'] = licenseCalibre;
    data['licenseDateOfIssuance'] = licenseDateOfIssuance;
    data['licenseIssuaingQuota'] = licenseIssuaingQuota;
    data['licenseIssuingAuthority'] = licenseIssuingAuthority;
    data['licenseJurisdiction'] = licenseJurisdiction;
    data['licenseNumber'] = licenseNumber;
    data['licensePicture'] = licensePicture;
    data['licenseTrackingNumber'] = licenseTrackingNumber;
    data['licenseValidTill'] = licenseValidTill;
    data['licenseValidated'] = licenseValidated;
    if (weaponDetails != null) {
      data['weaponDetails'] = weaponDetails!.toJson();
    }
    if (weaponFiringRecord != null) {
      data['weaponFiringRecord'] =
          weaponFiringRecord!.map((v) => v.toJson()).toList();
    }
    if (weaponServiceRecord != null) {
      data['weaponServiceRecord'] =
          weaponServiceRecord!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ammunitionDetail != null) {
      data['ammunitionDetail'] =
          ammunitionDetail!.map((v) => v.toMap()).toList();
    }
    data['licenseAmmunitionLimit'] = licenseAmmunitionLimit;
    data['licenseCalibre'] = licenseCalibre;
    data['weaponType']=licenseweaponType;
    data['licenseDateOfIssuance'] = licenseDateOfIssuance;
    data['licenseIssuaingQuota'] = licenseIssuaingQuota;
    data['licenseIssuingAuthority'] = licenseIssuingAuthority;
    data['licenseJurisdiction'] = licenseJurisdiction;
    data['licenseNumber'] = licenseNumber;
    data['licensePicture'] = licensePicture;
    data['licenseTrackingNumber'] = licenseTrackingNumber;
    data['licenseValidTill'] = licenseValidTill;
    data['licenseValidated'] = licenseValidated;
    if (weaponDetails != null) {
      data['weaponDetails'] = weaponDetails!.toMap();
    }
    if (weaponFiringRecord != null) {
      data['weaponFiringRecord'] =
          weaponFiringRecord!.map((v) => v.toMap()).toList();
    }
    if (weaponServiceRecord != null) {
      data['weaponServiceRecord'] =
          weaponServiceRecord!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class AmmunitionDetail {
  String? ammunitionBrand;
  String? ammunitionCaliber;
  String? ammunitionPurchaseDate;
  String? ammunitionPurchasedFrom;
  String? ammunitionQuantityPurchased;
  String? typeOfRound;

  AmmunitionDetail(
      {this.ammunitionBrand,
      this.ammunitionCaliber,
      this.ammunitionPurchaseDate,
      this.ammunitionPurchasedFrom,
      this.typeOfRound,
      this.ammunitionQuantityPurchased});

  AmmunitionDetail.fromJson(Map<String, dynamic> json) {
    ammunitionBrand = json['ammunitionBrand'];
    typeOfRound= json['typeOfRound'];
    ammunitionCaliber = json['ammunitionCaliber'];
    ammunitionPurchaseDate = json['ammunitionPurchaseDate'];
    ammunitionPurchasedFrom = json['ammunitionPurchasedFrom'];
    ammunitionQuantityPurchased = json['ammunitionQuantityPurchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ammunitionBrand'] = ammunitionBrand;
    data['typeOfRound'] = typeOfRound;
    data['ammunitionCaliber'] = ammunitionCaliber;
    data['ammunitionPurchaseDate'] = ammunitionPurchaseDate;
    data['ammunitionPurchasedFrom'] = ammunitionPurchasedFrom;
    data['ammunitionQuantityPurchased'] = ammunitionQuantityPurchased;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ammunitionBrand'] = ammunitionBrand;
    data['ammunitionCaliber'] = ammunitionCaliber;
    data['typeOfRound'] = typeOfRound;
    data['ammunitionPurchaseDate'] = ammunitionPurchaseDate;
    data['ammunitionPurchasedFrom'] = ammunitionPurchasedFrom;
    data['ammunitionQuantityPurchased'] = ammunitionQuantityPurchased;
    return data;
  }
}

class WeaponDetails {
  String? weaponCaliber;
  String? weaponMake;
  String? weaponModel;
  String? weaponNo;
  String? weaponType;
  String? weaponauthorizedealername;
  String? weaponauthorizedealeraddress;
  String? weaponauthorizedealerphonenumber;
  String? weaponpurchaserecipt;
  String? weaponpurchasedate;

  WeaponDetails({
    this.weaponCaliber,
    this.weaponMake,
    this.weaponModel,
    this.weaponNo,
    this.weaponType,
    this.weaponauthorizedealername,
    this.weaponauthorizedealeraddress,
    this.weaponauthorizedealerphonenumber,
    this.weaponpurchaserecipt,
    this.weaponpurchasedate,
  });

  WeaponDetails.fromJson(Map<String, dynamic> json) {
    weaponCaliber = json['weaponCaliber'];
    weaponMake = json['weaponMake'];
    weaponModel = json['weaponModel'];
    weaponNo = json['weaponNo'];
    weaponType = json['weaponType'];
    weaponauthorizedealername = json['weaponauthorizedealername'];
    weaponauthorizedealeraddress = json['weaponauthorizedealeraddress'];
    weaponauthorizedealerphonenumber = json['weaponauthorizedealerphonenumber'];
    weaponpurchaserecipt = json['weaponpurchaserecipt'];
    weaponpurchasedate = json['weaponpurchasedate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weaponCaliber'] = weaponCaliber;
    data['weaponMake'] = weaponMake;
    data['weaponModel'] = weaponModel;
    data['weaponNo'] = weaponNo;
    data['weaponType'] = weaponType;
    data['weaponauthorizedealername'] = weaponauthorizedealername;
    data['weaponauthorizedealeraddress'] = weaponauthorizedealeraddress;
    data['weaponauthorizedealerphonenumber'] = weaponauthorizedealerphonenumber;
    data['weaponpurchaserecipt'] = weaponpurchaserecipt;
    data['weaponpurchasedate'] = weaponpurchasedate;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weaponCaliber'] = weaponCaliber;
    data['weaponMake'] = weaponMake;
    data['weaponModel'] = weaponModel;
    data['weaponNo'] = weaponNo;
    data['weaponType'] = weaponType;
    data['weaponauthorizedealername'] = weaponauthorizedealername;
    data['weaponauthorizedealeraddress'] = weaponauthorizedealeraddress;
    data['weaponauthorizedealerphonenumber'] = weaponauthorizedealerphonenumber;
    data['weaponpurchaserecipt'] = weaponpurchaserecipt;
    data['weaponpurchasedate'] = weaponpurchasedate;
    return data;
  }
}

class WeaponFiringRecord {
  String? weaponFiringLocation;
  String? weaponFiringNotes;
  String? weaponFiringShotsFired;
  String? weaponfiringDate;

  WeaponFiringRecord(
      {this.weaponFiringLocation,
      this.weaponFiringNotes,
      this.weaponFiringShotsFired,
      this.weaponfiringDate});

  WeaponFiringRecord.fromJson(Map<String, dynamic> json) {
    weaponFiringLocation = json['weaponFiringLocation'];
    weaponFiringNotes = json['weaponFiringNotes'];
    weaponFiringShotsFired = json['weaponFiringShotsFired'];
    weaponfiringDate = json['weaponfiringDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weaponFiringLocation'] = weaponFiringLocation;
    data['weaponFiringNotes'] = weaponFiringNotes;
    data['weaponFiringShotsFired'] = weaponFiringShotsFired;
    data['weaponfiringDate'] = weaponfiringDate;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weaponFiringLocation'] = weaponFiringLocation;
    data['weaponFiringNotes'] = weaponFiringNotes;
    data['weaponFiringShotsFired'] = weaponFiringShotsFired;
    data['weaponfiringDate'] = weaponfiringDate;
    return data;
  }
}

class WeaponServiceRecord {
  String? weaponServiceDate;
  String? weaponServiceDoneBy;
  String? weaponServiceNotes;
  List<String>? weaponServicePartsChanged;

  WeaponServiceRecord(
      {this.weaponServiceDate,
      this.weaponServiceDoneBy,
      this.weaponServiceNotes,
      this.weaponServicePartsChanged});

  WeaponServiceRecord.fromJson(Map<String, dynamic> json) {
    weaponServiceDate = json['weaponServiceDate'];
    weaponServiceDoneBy = json['weaponServiceDoneBy'];
    weaponServiceNotes = json['weaponServiceNotes'];
    weaponServicePartsChanged =
        json['weaponServicePartsChanged'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weaponServiceDate'] = weaponServiceDate;
    data['weaponServiceDoneBy'] = weaponServiceDoneBy;
    data['weaponServiceNotes'] = weaponServiceNotes;
    data['weaponServicePartsChanged'] = weaponServicePartsChanged;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['weaponServiceDate'] = weaponServiceDate;
    data['weaponServiceDoneBy'] = weaponServiceDoneBy;
    data['weaponServiceNotes'] = weaponServiceNotes;
    data['weaponServicePartsChanged'] = weaponServicePartsChanged;
    return data;
  }
}
