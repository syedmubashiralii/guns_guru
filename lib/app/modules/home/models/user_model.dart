import 'package:guns_guru/app/utils/app_constants.dart';

class UserModel {
  String? address;
  String? city;
  String? cnic;
  String? email;
  String? country;
  String? state;
  String? documentIssuanceDate;
  String? documentExpiryDate;
  String? dob;
  String? gender;
  String? firstname;
  String? phoneno;
  String? lastname;
  String? countrycode;
  List<License>? license;
  String? uid;

  UserModel(
      {this.address,
      this.city,
      this.cnic,
      this.country,
      this.state,
      this.email,
      this.documentIssuanceDate,
      this.documentExpiryDate,
      this.dob,
      this.gender,
      this.firstname,
      this.phoneno,
      this.lastname,
      this.countrycode,
      this.license,
      this.uid});

  UserModel.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    city = json['city'];
    cnic = json['cnic'];
    documentIssuanceDate = json['documentIssuanceDate'];
    documentExpiryDate = json['documentExpiryDate'];
    dob = json['dob'];
    country = json['country'];
    state = json['state'];
    email = json['email'];
    gender = json['gender'];
    firstname = json['firstname'];
    phoneno = json['phoneno'];
    lastname = json['lastname'];
    countrycode = json['countrycode'];
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
    data['country'] = country;
    data['state'] = state;
    data['documentIssuanceDate'] = documentIssuanceDate;
    data['documentExpiryDate'] = documentExpiryDate;
    data['email'] = email;
    data['dob'] = dob;
    data['gender'] = gender;
    data['firstname'] = firstname;
    data['phoneno'] = phoneno;
    data['lastname'] = lastname;
    data['countrycode'] = countrycode;
    if (license != null) {
      data['license'] = license!.map((v) => v.toJson()).toList();
    }
    data['uid'] = uid;
    return data;
  }
}

class License {
  String? uid;
  List<AmmunitionDetail>? ammunitionDetail;
  String? licenseAmmunitionLimit;
  String? licenseCalibre;
  String? licenseDateOfIssuance;
  String? licenseIssuaingQuota;
  String? licenseIssuingAuthority;
  String? licenseJurisdiction;
  String? licenseNumber;
  String? licenseweaponType;
  List<String>? licensePicture;
  String? licenseTrackingNumber;
  String? licenseValidTill;
  bool? licenseValidated;
  String? documenttype;
  String? country;
  String? weaponNo;
  String? weaponUid;
  WeaponDetails? weaponDetails;
  List<WeaponFiringRecord>? weaponFiringRecord;
  // List<WeaponServiceRecord>? weaponServiceRecord;

  License({
    this.ammunitionDetail,
    this.uid,
    this.licenseAmmunitionLimit,
    this.licenseCalibre,
    this.licenseDateOfIssuance,
    this.licenseIssuaingQuota,
    this.licenseIssuingAuthority,
    this.licenseJurisdiction,
    this.documenttype,
    this.licenseNumber,
    this.weaponNo,
    this.licenseweaponType,
    this.licensePicture,
    this.country,
    this.weaponUid,
    this.licenseTrackingNumber,
    this.licenseValidated,
    this.licenseValidTill,
    this.weaponDetails,
    this.weaponFiringRecord,
    // this.weaponServiceRecord
  });

  License.fromJson(Map<String, dynamic> json) {
    if (json['ammunitionDetail'] != null) {
      ammunitionDetail = <AmmunitionDetail>[];
      json['ammunitionDetail'].forEach((v) {
        ammunitionDetail!.add(AmmunitionDetail.fromJson(v));
      });
    }
    licenseAmmunitionLimit = json['licenseAmmunitionLimit'];
    uid = json['uid'];
    weaponUid = json['weaponUid'];
    documenttype = json['documenttype'];
    licenseCalibre = json['licenseCalibre'];
    licenseDateOfIssuance = json['licenseDateOfIssuance'];
    licenseIssuaingQuota = json['licenseIssuaingQuota'];
    country = json['country'];
    licenseIssuingAuthority = json['licenseIssuingAuthority'];
    licenseJurisdiction = json['licenseJurisdiction'];
    licenseNumber = json['licenseNumber'];
    licenseweaponType = json['weaponType'];
    weaponNo = json['weaponNo'];
    licensePicture = (json['licensePicture'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    licenseTrackingNumber = json['licenseTrackingNumber'];
    licenseValidTill = json['licenseValidTill'];
    licenseValidated = json['licenseValidated'];
    weaponDetails = json['weaponDetails'] != null
        ? WeaponDetails.fromJson(json['weaponDetails'])
        : null;
    // if (json['weaponFiringRecord'] != null) {
    //   weaponFiringRecord = <WeaponFiringRecord>[];
    //   json['weaponFiringRecord'].forEach((v) {
    //     weaponFiringRecord!.add(WeaponFiringRecord.fromJson(v));
    //   });
    // }
    // if (json['weaponServiceRecord'] != null) {
    //   weaponServiceRecord = <WeaponServiceRecord>[];
    //   json['weaponServiceRecord'].forEach((v) {
    //     weaponServiceRecord!.add(WeaponServiceRecord.fromJson(v));
    //   });
    // }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ammunitionDetail != null) {
      data['ammunitionDetail'] =
          ammunitionDetail!.map((v) => v.toJson()).toList();
    }
    data['licenseAmmunitionLimit'] = licenseAmmunitionLimit;
    data['uid'] = uid;
    data['weaponUid'] = weaponUid;
    data['documenttype'] = documenttype;
    data['country'] = country;
    data['weaponNo'] = weaponNo;
    data['weaponType'] = licenseweaponType;
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
    // if (weaponFiringRecord != null) {
    //   data['weaponFiringRecord'] =
    //       weaponFiringRecord!.map((v) => v.toJson()).toList();
    // }
    // if (weaponServiceRecord != null) {
    //   data['weaponServiceRecord'] =
    //       weaponServiceRecord!.map((v) => v.toJson()).toList();
    // }
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (ammunitionDetail != null) {
      data['ammunitionDetail'] =
          ammunitionDetail!.map((v) => v.toMap()).toList();
    }
    data['licenseAmmunitionLimit'] = licenseAmmunitionLimit;
    data['uid'] = uid;
    data['weaponUid'] = weaponUid;
    data['documenttype'] = documenttype;
    data['licenseCalibre'] = licenseCalibre;
    data['country'] = country;
    data['weaponType'] = licenseweaponType;
    data['licenseDateOfIssuance'] = licenseDateOfIssuance;
    data['licenseIssuaingQuota'] = licenseIssuaingQuota;
    data['licenseIssuingAuthority'] = licenseIssuingAuthority;
    data['licenseJurisdiction'] = licenseJurisdiction;
    data['licenseNumber'] = licenseNumber;
    data['weaponNo'] = weaponNo;
    data['licensePicture'] = licensePicture;
    data['licenseTrackingNumber'] = licenseTrackingNumber;
    data['licenseValidTill'] = licenseValidTill;
    data['licenseValidated'] = licenseValidated;
    if (weaponDetails != null) {
      data['weaponDetails'] = weaponDetails!.toMap();
    }
    // if (weaponFiringRecord != null) {
    //   data['weaponFiringRecord'] =
    //       weaponFiringRecord!.map((v) => v.toMap()).toList();
    // }
    // if (weaponServiceRecord != null) {
    //   data['weaponServiceRecord'] =
    //       weaponServiceRecord!.map((v) => v.toMap()).toList();
    // }
    return data;
  }
}

class AmmunitionDetail {
  String? uid;
  String? ammunitionBrand;
  String? ammunitionCaliber;
  String? ammunitionPurchaseDate;
  String? ammunitionPurchasedFrom;
  String? ammunitionQuantityPurchased;
  String? typeOfRound;
  String? retailerName;
  String? retailerPhoneNo;
  String? licenseNo;
  String? licenseUid;
  String? weaponNo;
  String? weaponUid;

  AmmunitionDetail(
      {this.uid,
      this.ammunitionBrand,
      this.ammunitionCaliber,
      this.ammunitionPurchaseDate,
      this.ammunitionPurchasedFrom,
      this.typeOfRound,
      this.retailerPhoneNo,
      this.licenseNo,
      this.licenseUid,
      this.weaponNo,
      this.weaponUid,
      this.retailerName,
      this.ammunitionQuantityPurchased});

  AmmunitionDetail.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    ammunitionBrand = json['ammunitionBrand'];
    typeOfRound = json['typeOfRound'];
    retailerPhoneNo = json['retailerPhoneNo'];
    retailerName = json['retailerName'];
    ammunitionCaliber = json['ammunitionCaliber'];
    ammunitionPurchaseDate = json['ammunitionPurchaseDate'];
    ammunitionPurchasedFrom = json['ammunitionPurchasedFrom'];
    ammunitionQuantityPurchased = json['ammunitionQuantityPurchased'];
    licenseNo = json['licenseNo'];
    licenseUid = json['licenseUid'];
    weaponNo = json['weaponNo'];
    weaponUid = json['weaponUid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['ammunitionBrand'] = ammunitionBrand;
    data['retailerPhoneNo'] = retailerPhoneNo;
    data['typeOfRound'] = typeOfRound;
    data['retailerName'] = retailerName;
    data['ammunitionCaliber'] = ammunitionCaliber;
    data['ammunitionPurchaseDate'] = ammunitionPurchaseDate;
    data['ammunitionPurchasedFrom'] = ammunitionPurchasedFrom;
    data['ammunitionQuantityPurchased'] = ammunitionQuantityPurchased;
    data['licenseNo'] = licenseNo;
    data['licenseUid'] = licenseUid;
    data['weaponNo'] = weaponNo;
    data['weaponUid'] = weaponUid;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['ammunitionBrand'] = ammunitionBrand;
    data['ammunitionCaliber'] = ammunitionCaliber;
    data['retailerPhoneNo'] = retailerPhoneNo;
    data['typeOfRound'] = typeOfRound;
    data['retailerName'] = retailerName;
    data['ammunitionPurchaseDate'] = ammunitionPurchaseDate;
    data['ammunitionPurchasedFrom'] = ammunitionPurchasedFrom;
    data['ammunitionQuantityPurchased'] = ammunitionQuantityPurchased;
    data['licenseNo'] = licenseNo;
    data['licenseUid'] = licenseUid;
    data['weaponNo'] = weaponNo;
    data['weaponUid'] = weaponUid;
    return data;
  }
}

class WeaponDetails {
  String? uid;
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
  String? licenseNo; // Optional field
  String? documentIdNo;
  String? emailId;
  String? documentIssuingDate;
  String? documentExpiryDate;

  WeaponDetails({
    this.uid,
    this.weaponCaliber,
    this.weaponMake,
    this.weaponModel,
    this.weaponNo,
    this.weaponType,
    this.documentIdNo,
    this.documentExpiryDate,
    this.emailId,
    this.documentIssuingDate,
    this.weaponauthorizedealername,
    this.weaponauthorizedealeraddress,
    this.weaponauthorizedealerphonenumber,
    this.weaponpurchaserecipt,
    this.weaponpurchasedate,
    this.licenseNo, // Optional field
  });

  WeaponDetails.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    weaponCaliber = json['weaponCaliber'];
    documentIdNo = json['documentIdNo'];
    weaponMake = json['weaponMake'];
    weaponModel = json['weaponModel'];
    emailId = json['emailId'];
    documentIssuingDate = json['documentIssuingDate'];
    weaponNo = json['weaponNo'];
    weaponType = json['weaponType'];
    weaponauthorizedealername = json['weaponauthorizedealername'];
    weaponauthorizedealeraddress = json['weaponauthorizedealeraddress'];
    weaponauthorizedealerphonenumber = json['weaponauthorizedealerphonenumber'];
    weaponpurchaserecipt = json['weaponpurchaserecipt'];
    weaponpurchasedate = json['weaponpurchasedate'];
    licenseNo = json['licenseNo']; // New field
    documentExpiryDate = json['documentExpiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['weaponCaliber'] = weaponCaliber;
    data['documentIssuingDate'] = documentIssuingDate;
    data['weaponMake'] = weaponMake;
    data['weaponModel'] = weaponModel;
    data['documentIdNo'] = documentIdNo;
    data['emailId'] = emailId;
    data['documentExpiryDate'] = documentExpiryDate;
    data['weaponNo'] = weaponNo;
    data['weaponType'] = weaponType;
    data['weaponauthorizedealername'] = weaponauthorizedealername;
    data['weaponauthorizedealeraddress'] = weaponauthorizedealeraddress;
    data['weaponauthorizedealerphonenumber'] = weaponauthorizedealerphonenumber;
    data['weaponpurchaserecipt'] = weaponpurchaserecipt;
    data['weaponpurchasedate'] = weaponpurchasedate;
    data['licenseNo'] = licenseNo; // New field
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['weaponCaliber'] = weaponCaliber;
    data['weaponMake'] = weaponMake;
    data['weaponModel'] = weaponModel;
    data['documentIdNo'] = documentIdNo;
    data['documentExpiryDate'] = documentExpiryDate;
    data['emailId'] = emailId;
    data['documentIssuingDate'] = documentIssuingDate;
    data['weaponNo'] = weaponNo;
    data['weaponType'] = weaponType;
    data['weaponauthorizedealername'] = weaponauthorizedealername;
    data['weaponauthorizedealeraddress'] = weaponauthorizedealeraddress;
    data['weaponauthorizedealerphonenumber'] = weaponauthorizedealerphonenumber;
    data['weaponpurchaserecipt'] = weaponpurchaserecipt;
    data['weaponpurchasedate'] = weaponpurchasedate;
    data['licenseNo'] = licenseNo; // New field
    return data;
  }
}

class WeaponFiringRecord {
  String? fireArmMake;
  String? fireArmModel;
  String? caliber;
  String? weaponNumber;
  String? opticsSights;
  String? accessories;
  String? ammunitionBrand;
  String? bulletWeight;
  String? bulletType;
  String? muzzleVelocity;
  String? lotBoxNumber;
  String? notes;
  String? rangeNameLocation;
  String? date;
  String? time;
  String? weatherConditions;
  String? windDirection;
  String? windSpeed;
  String? temperature;
  String? selectedTemperatureUnit;
  String? humidity;
  String? altitude;
  String? terrain;
  String? brightness;
  String? shootingDistance;
  String? selectedWindSpeedUnit;
  String? selectedShootingDistanceUnit;
  String? targetType;
  String? shootingPosition;
  String? roundsFired;
  String? malfunctions;
  String? shootingDrills;
  String? accuracyGrouping;
  String? sightAdjustment;
  String? performanceObservations;
  String? lessonsLearned;
  String? additionalNotes;
  String? uid;
  List<String>? shootingpositionpicture;
  String? ammobrand;
  String? weaponno;
  String? weaponuid;
  String? licenseno;
  String? licenseuid;
  String? typeofround;

  WeaponFiringRecord({
    this.shootingpositionpicture,
    this.uid,
    this.fireArmMake,
    this.fireArmModel,
    this.caliber,
    this.weaponNumber,
    this.opticsSights,
    this.accessories,
    this.ammunitionBrand,
    this.bulletWeight,
    this.bulletType,
    this.selectedWindSpeedUnit,
    this.muzzleVelocity,
    this.lotBoxNumber,
    this.notes,
    this.rangeNameLocation,
    this.date,
    this.time,
    this.weatherConditions,
    this.windDirection,
    this.windSpeed,
    this.temperature,
    this.selectedTemperatureUnit,
    this.humidity,
    this.altitude,
    this.terrain,
    this.brightness,
    this.shootingDistance,
    this.selectedShootingDistanceUnit,
    this.targetType,
    this.shootingPosition,
    this.roundsFired,
    this.malfunctions,
    this.shootingDrills,
    this.accuracyGrouping,
    this.sightAdjustment,
    this.performanceObservations,
    this.lessonsLearned,
    this.additionalNotes,
    this.ammobrand,
    this.weaponno,
    this.weaponuid,
    this.licenseno,
    this.licenseuid,
    this.typeofround
  });

  WeaponFiringRecord.fromJson(Map<String, dynamic> json) {
    shootingpositionpicture = (json['shootingpositionpicture'] as List<dynamic>)
        .map((e) => e.toString())
        .toList();
    selectedWindSpeedUnit = json['selectedWindSpeedUnit'];
    uid = json['uid'];
    fireArmMake = json['fireArmMake'];
    fireArmModel = json['fireArmModel'];
    caliber = json['caliber'];
    weaponNumber = json['weaponNumber'];
    opticsSights = json['opticsSights'];
    accessories = json['accessories'];
    ammunitionBrand = json['ammunitionBrand'];
    bulletWeight = json['bulletWeight'];
    bulletType = json['bulletType'];
    muzzleVelocity = json['muzzleVelocity'];
    lotBoxNumber = json['lotBoxNumber'];
    notes = json['notes'];
    rangeNameLocation = json['rangeNameLocation'];
    date = json['date'];
    time = json['time'];
    weatherConditions = json['weatherConditions'];
    windDirection = json['windDirection'];
    windSpeed = json['windSpeed'];
    temperature = json['temperature'];
    selectedTemperatureUnit = json['selectedTemperatureUnit'];
    humidity = json['humidity'];
    altitude = json['altitude'];
    terrain = json['terrain'];
    brightness = json['brightness'];
    shootingDistance = json['shootingDistance'];
    selectedShootingDistanceUnit = json['selectedShootingDistanceUnit'];
    targetType = json['targetType'];
    shootingPosition = json['shootingPosition'];
    roundsFired = json['roundsFired'];
    malfunctions = json['malfunctions'];
    shootingDrills = json['shootingDrills'];
    accuracyGrouping = json['accuracyGrouping'];
    sightAdjustment = json['sightAdjustment'];
    performanceObservations = json['performanceObservations'];
    lessonsLearned = json['lessonsLearned'];
    additionalNotes = json['additionalNotes'];
    ammobrand = json['ammobrand'];
    weaponno = json['weaponno'];
    weaponuid = json['weaponuid'];
    licenseno = json['licenseno'];
    licenseuid = json['licenseuid'];
    typeofround = json['typeofround'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shootingpositionpicture'] = shootingpositionpicture;
    data['selectedWindSpeedUnit'] = selectedWindSpeedUnit;
    data['uid'] = uid;
    data['fireArmMake'] = fireArmMake;
    data['fireArmModel'] = fireArmModel;
    data['caliber'] = caliber;
    data['weaponNumber'] = weaponNumber;
    data['opticsSights'] = opticsSights;
    data['accessories'] = accessories;
    data['ammunitionBrand'] = ammunitionBrand;
    data['bulletWeight'] = bulletWeight;
    data['bulletType'] = bulletType;
    data['muzzleVelocity'] = muzzleVelocity;
    data['lotBoxNumber'] = lotBoxNumber;
    data['notes'] = notes;
    data['rangeNameLocation'] = rangeNameLocation;
    data['date'] = date;
    data['time'] = time;
    data['weatherConditions'] = weatherConditions;
    data['windDirection'] = windDirection;
    data['windSpeed'] = windSpeed;
    data['temperature'] = temperature;
    data['selectedTemperatureUnit'] = selectedTemperatureUnit;
    data['humidity'] = humidity;
    data['altitude'] = altitude;
    data['terrain'] = terrain;
    data['brightness'] = brightness;
    data['shootingDistance'] = shootingDistance;
    data['selectedShootingDistanceUnit'] = selectedShootingDistanceUnit;
    data['targetType'] = targetType;
    data['shootingPosition'] = shootingPosition;
    data['roundsFired'] = roundsFired;
    data['malfunctions'] = malfunctions;
    data['shootingDrills'] = shootingDrills;
    data['accuracyGrouping'] = accuracyGrouping;
    data['sightAdjustment'] = sightAdjustment;
    data['performanceObservations'] = performanceObservations;
    data['lessonsLearned'] = lessonsLearned;
    data['additionalNotes'] = additionalNotes;
    data['ammobrand'] = ammobrand;
    data['weaponno'] = weaponno;
    data['weaponuid'] = weaponuid;
    data['licenseno'] = licenseno;
    data['licenseuid'] = licenseuid;
    data['typeofround'] = typeofround;
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['shootingpositionpicture'] = shootingpositionpicture;
    data['selectedWindSpeedUnit'] = selectedWindSpeedUnit;
    data['uid'] = uid;
    data['fireArmMake'] = fireArmMake;
    data['fireArmModel'] = fireArmModel;
    data['caliber'] = caliber;
    data['weaponNumber'] = weaponNumber;
    data['opticsSights'] = opticsSights;
    data['accessories'] = accessories;
    data['ammunitionBrand'] = ammunitionBrand;
    data['bulletWeight'] = bulletWeight;
    data['bulletType'] = bulletType;
    data['muzzleVelocity'] = muzzleVelocity;
    data['lotBoxNumber'] = lotBoxNumber;
    data['notes'] = notes;
    data['rangeNameLocation'] = rangeNameLocation;
    data['date'] = date;
    data['time'] = time;
    data['weatherConditions'] = weatherConditions;
    data['windDirection'] = windDirection;
    data['windSpeed'] = windSpeed;
    data['temperature'] = temperature;
    data['selectedTemperatureUnit'] = selectedTemperatureUnit;
    data['humidity'] = humidity;
    data['altitude'] = altitude;
    data['terrain'] = terrain;
    data['brightness'] = brightness;
    data['shootingDistance'] = shootingDistance;
    data['selectedShootingDistanceUnit'] = selectedShootingDistanceUnit;
    data['targetType'] = targetType;
    data['shootingPosition'] = shootingPosition;
    data['roundsFired'] = roundsFired;
    data['malfunctions'] = malfunctions;
    data['shootingDrills'] = shootingDrills;
    data['accuracyGrouping'] = accuracyGrouping;
    data['sightAdjustment'] = sightAdjustment;
    data['performanceObservations'] = performanceObservations;
    data['lessonsLearned'] = lessonsLearned;
    data['additionalNotes'] = additionalNotes;
    data['ammobrand'] = ammobrand;
    data['weaponno'] = weaponno;
    data['weaponuid'] = weaponuid;
    data['licenseno'] = licenseno;
    data['licenseuid'] = licenseuid;
    data['typeofround'] = typeofround;
    return data;
  }
}

class ServiceRecord {
  String? serviceDate;
  List? partsChanged;
  String? serviceType; // e.g., Basic Service, Detailed Service
  String? selfOrArmorService; // e.g., Self Service, Armor Service
  String? armorName;
  String? armorAddress;
  String? armorphoneno;
  String? notes;
  String? weaponno;
  String? weaponuid;
  String? licenseno;
  String? licenseuid;

  ServiceRecord(
      {this.serviceDate,
      this.partsChanged,
      this.armorphoneno,
      this.serviceType,
      this.selfOrArmorService,
      this.armorName,
      this.armorAddress,
      this.notes,
      this.licenseno,
      this.licenseuid,
      this.weaponno,
      this.weaponuid});

  Map<String, dynamic> toMap() {
    return {
      'licenseno': licenseno,
      'licenseuid': licenseuid,
      'weaponno': weaponno,
      'armorphoneno': armorphoneno,
      'weaponuid': weaponuid,
      'serviceDate': serviceDate,
      'partsChanged': partsChanged,
      'serviceType': serviceType,
      'selfOrArmorService': selfOrArmorService,
      'armorName': armorName,
      'armorAddress': armorAddress,
      'notes': notes,
    };
  }

  ServiceRecord.fromMap(Map<String, dynamic> map) {
    licenseno = map['licenseno'];
    licenseuid = map['licenseuid'];
    weaponno = map['weaponno'];
    weaponuid = map['weaponuid'];
    armorphoneno = map['armorphoneno'];
    serviceDate = map['serviceDate'];
    partsChanged = List<String>.from(map['partsChanged'] ?? []);
    serviceType = map['serviceType'];
    selfOrArmorService = map['selfOrArmorService'];
    armorName = map['armorName'];
    armorAddress = map['armorAddress'];
    notes = map['notes'];
  }
}
