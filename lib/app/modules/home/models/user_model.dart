class UserModel {
  String? address;
  String? city;
  String? cnic;
  String? cnicBackSide;
  String? cnicFrontSide;
  String? dob;
  String? fullname;
  List<License>? license;
  String? uid;

  UserModel(
      {this.address,
      this.city,
      this.cnic,
      this.cnicBackSide,
      this.cnicFrontSide,
      this.dob,
      this.fullname,
      this.license,
      this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    cnic = json['cnic'];
    cnicBackSide = json['cnic_back_side'];
    cnicFrontSide = json['cnic_front_side'];
    dob = json['dob'];
    fullname = json['fullname'];
    if (json['license'] != null) {
      license = <License>[];
      json['license'].forEach((v) {
        license!.add(new License.fromJson(v));
      });
    }
    uid = json['uid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['cnic'] = this.cnic;
    data['cnic_back_side'] = this.cnicBackSide;
    data['cnic_front_side'] = this.cnicFrontSide;
    data['dob'] = this.dob;
    data['fullname'] = this.fullname;
    if (this.license != null) {
      data['license'] = this.license!.map((v) => v.toJson()).toList();
    }
    data['uid'] = this.uid;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data =  Map<String, dynamic>();
    data['address'] = this.address;
    data['city'] = this.city;
    data['cnic'] = this.cnic;
    data['cnic_back_side'] = this.cnicBackSide;
    data['cnic_front_side'] = this.cnicFrontSide;
    data['dob'] = this.dob;
    data['fullname'] = this.fullname;
    if (this.license != null) {
      data['license'] = this.license!.map((v) => v.toMap()).toList();
    }
    data['uid'] = this.uid;
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
  String? licensePicture;
  String? licenseTrackingNumber;
  String? licenseValidTill;
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
      this.licensePicture,
      this.licenseTrackingNumber,
      this.licenseValidTill,
      this.weaponDetails,
      this.weaponFiringRecord,
      this.weaponServiceRecord});

  License.fromJson(Map<String, dynamic> json) {
    if (json['ammunitionDetail'] != null) {
      ammunitionDetail = <AmmunitionDetail>[];
      json['ammunitionDetail'].forEach((v) {
        ammunitionDetail!.add(new AmmunitionDetail.fromJson(v));
      });
    }
    licenseAmmunitionLimit = json['licenseAmmunitionLimit'];
    licenseCalibre = json['licenseCalibre'];
    licenseDateOfIssuance = json['licenseDateOfIssuance'];
    licenseIssuaingQuota = json['licenseIssuaingQuota'];
    licenseIssuingAuthority = json['licenseIssuingAuthority'];
    licenseJurisdiction = json['licenseJurisdiction'];
    licenseNumber = json['licenseNumber'];
    licensePicture = json['licensePicture'];
    licenseTrackingNumber = json['licenseTrackingNumber'];
    licenseValidTill = json['licenseValidTill'];
    weaponDetails = json['weaponDetails'] != null
        ? new WeaponDetails.fromJson(json['weaponDetails'])
        : null;
    if (json['weaponFiringRecord'] != null) {
      weaponFiringRecord = <WeaponFiringRecord>[];
      json['weaponFiringRecord'].forEach((v) {
        weaponFiringRecord!.add(new WeaponFiringRecord.fromJson(v));
      });
    }
    if (json['weaponServiceRecord'] != null) {
      weaponServiceRecord = <WeaponServiceRecord>[];
      json['weaponServiceRecord'].forEach((v) {
        weaponServiceRecord!.add(new WeaponServiceRecord.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ammunitionDetail != null) {
      data['ammunitionDetail'] =
          this.ammunitionDetail!.map((v) => v.toJson()).toList();
    }
    data['licenseAmmunitionLimit'] = this.licenseAmmunitionLimit;
    data['licenseCalibre'] = this.licenseCalibre;
    data['licenseDateOfIssuance'] = this.licenseDateOfIssuance;
    data['licenseIssuaingQuota'] = this.licenseIssuaingQuota;
    data['licenseIssuingAuthority'] = this.licenseIssuingAuthority;
    data['licenseJurisdiction'] = this.licenseJurisdiction;
    data['licenseNumber'] = this.licenseNumber;
    data['licensePicture'] = this.licensePicture;
    data['licenseTrackingNumber'] = this.licenseTrackingNumber;
    data['licenseValidTill'] = this.licenseValidTill;
    if (this.weaponDetails != null) {
      data['weaponDetails'] = this.weaponDetails!.toJson();
    }
    if (this.weaponFiringRecord != null) {
      data['weaponFiringRecord'] =
          this.weaponFiringRecord!.map((v) => v.toJson()).toList();
    }
    if (this.weaponServiceRecord != null) {
      data['weaponServiceRecord'] =
          this.weaponServiceRecord!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.ammunitionDetail != null) {
      data['ammunitionDetail'] =
          this.ammunitionDetail!.map((v) => v.toMap()).toList();
    }
    data['licenseAmmunitionLimit'] = this.licenseAmmunitionLimit;
    data['licenseCalibre'] = this.licenseCalibre;
    data['licenseDateOfIssuance'] = this.licenseDateOfIssuance;
    data['licenseIssuaingQuota'] = this.licenseIssuaingQuota;
    data['licenseIssuingAuthority'] = this.licenseIssuingAuthority;
    data['licenseJurisdiction'] = this.licenseJurisdiction;
    data['licenseNumber'] = this.licenseNumber;
    data['licensePicture'] = this.licensePicture;
    data['licenseTrackingNumber'] = this.licenseTrackingNumber;
    data['licenseValidTill'] = this.licenseValidTill;
    if (this.weaponDetails != null) {
      data['weaponDetails'] = this.weaponDetails!.toMap();
    }
    if (this.weaponFiringRecord != null) {
      data['weaponFiringRecord'] =
          this.weaponFiringRecord!.map((v) => v.toMap()).toList();
    }
    if (this.weaponServiceRecord != null) {
      data['weaponServiceRecord'] =
          this.weaponServiceRecord!.map((v) => v.toMap()).toList();
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

  AmmunitionDetail(
      {this.ammunitionBrand,
      this.ammunitionCaliber,
      this.ammunitionPurchaseDate,
      this.ammunitionPurchasedFrom,
      this.ammunitionQuantityPurchased});

  AmmunitionDetail.fromJson(Map<String, dynamic> json) {
    ammunitionBrand = json['ammunitionBrand'];
    ammunitionCaliber = json['ammunitionCaliber'];
    ammunitionPurchaseDate = json['ammunitionPurchaseDate'];
    ammunitionPurchasedFrom = json['ammunitionPurchasedFrom'];
    ammunitionQuantityPurchased = json['ammunitionQuantityPurchased'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ammunitionBrand'] = this.ammunitionBrand;
    data['ammunitionCaliber'] = this.ammunitionCaliber;
    data['ammunitionPurchaseDate'] = this.ammunitionPurchaseDate;
    data['ammunitionPurchasedFrom'] = this.ammunitionPurchasedFrom;
    data['ammunitionQuantityPurchased'] = this.ammunitionQuantityPurchased;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ammunitionBrand'] = this.ammunitionBrand;
    data['ammunitionCaliber'] = this.ammunitionCaliber;
    data['ammunitionPurchaseDate'] = this.ammunitionPurchaseDate;
    data['ammunitionPurchasedFrom'] = this.ammunitionPurchasedFrom;
    data['ammunitionQuantityPurchased'] = this.ammunitionQuantityPurchased;
    return data;
  }
}


class WeaponDetails {
  String? weaponCaliber;
  String? weaponMake;
  String? weaponModel;
  String? weaponNo;
  String? weaponType;

  WeaponDetails(
      {this.weaponCaliber,
      this.weaponMake,
      this.weaponModel,
      this.weaponNo,
      this.weaponType});

  WeaponDetails.fromJson(Map<String, dynamic> json) {
    weaponCaliber = json['weaponCaliber'];
    weaponMake = json['weaponMake'];
    weaponModel = json['weaponModel'];
    weaponNo = json['weaponNo'];
    weaponType = json['weaponType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weaponCaliber'] = this.weaponCaliber;
    data['weaponMake'] = this.weaponMake;
    data['weaponModel'] = this.weaponModel;
    data['weaponNo'] = this.weaponNo;
    data['weaponType'] = this.weaponType;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weaponCaliber'] = this.weaponCaliber;
    data['weaponMake'] = this.weaponMake;
    data['weaponModel'] = this.weaponModel;
    data['weaponNo'] = this.weaponNo;
    data['weaponType'] = this.weaponType;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weaponFiringLocation'] = this.weaponFiringLocation;
    data['weaponFiringNotes'] = this.weaponFiringNotes;
    data['weaponFiringShotsFired'] = this.weaponFiringShotsFired;
    data['weaponfiringDate'] = this.weaponfiringDate;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weaponFiringLocation'] = this.weaponFiringLocation;
    data['weaponFiringNotes'] = this.weaponFiringNotes;
    data['weaponFiringShotsFired'] = this.weaponFiringShotsFired;
    data['weaponfiringDate'] = this.weaponfiringDate;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weaponServiceDate'] = this.weaponServiceDate;
    data['weaponServiceDoneBy'] = this.weaponServiceDoneBy;
    data['weaponServiceNotes'] = this.weaponServiceNotes;
    data['weaponServicePartsChanged'] = this.weaponServicePartsChanged;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['weaponServiceDate'] = this.weaponServiceDate;
    data['weaponServiceDoneBy'] = this.weaponServiceDoneBy;
    data['weaponServiceNotes'] = this.weaponServiceNotes;
    data['weaponServicePartsChanged'] = this.weaponServicePartsChanged;
    return data;
  }
}
