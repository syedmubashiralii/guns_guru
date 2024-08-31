import 'package:guns_guru/app/utils/app_constants.dart';

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
  String? countrycode;
  List<License>? license;
  String? uid;

  UserModel(
      {this.address,
      this.city,
      this.cnic,
      this.countrycode,
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
    countrycode = json['countrycode'];
    // cnicBackSide = json['cnic_back_side'];
    // cnicFrontSide = json['cnic_front_side'];
    dob = json['dob'];
    phoneno = json['phoneno'];
    gender = json['gender'];
    firstname = json['firstname'];
    lastname = json['lastname'];
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
    data['countrycode'] = countrycode;
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
    data['countrycode'] = countrycode;
    // data['cnic_back_side'] = this.cnicBackSide;
    // data['cnic_front_side'] = this.cnicFrontSide;
    data['dob'] = dob;
    data['gender'] = gender;
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
  List<String>? licensePicture;
  String? licenseTrackingNumber;
  String? licenseValidTill;
  bool? licenseValidated;
  String? documenttype;
  String? country;
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
      this.documenttype,
      this.licenseNumber,
      this.licenseweaponType,
      this.licensePicture,
      this.country,
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
    documenttype = json['documenttype'];
    licenseCalibre = json['licenseCalibre'];
    licenseDateOfIssuance = json['licenseDateOfIssuance'];
    licenseIssuaingQuota = json['licenseIssuaingQuota'];
    country = json['country'];
    licenseIssuingAuthority = json['licenseIssuingAuthority'];
    licenseJurisdiction = json['licenseJurisdiction'];
    licenseNumber = json['licenseNumber'];
    licenseweaponType = json['weaponType'];
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
    data['documenttype'] = documenttype;
    data['country'] = country;
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
    data['documenttype'] = documenttype;
    data['licenseCalibre'] = licenseCalibre;
    data['country'] = country;
    data['weaponType'] = licenseweaponType;
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
    // if (weaponFiringRecord != null) {
    //   data['weaponFiringRecord'] =
    //       weaponFiringRecord!.map((v) => v.toMap()).toList();
    // }
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
    typeOfRound = json['typeOfRound'];
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
  String? fireArmMake;
  String? fireArmModel;
  String? caliber;
  String? serialNumber;
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
  double? windSpeed;
  String? temperature;
  String? selectedTemperatureUnit;
  String? humidity;
  String? altitude;
  String? terrain;
  String? selectedWindSpeedUnit;
  String? brightness;
  double? shootingDistance;
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

  WeaponFiringRecord({
    this.uid,
    this.fireArmMake,
    this.fireArmModel,
    this.caliber,
    this.serialNumber,
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
  });

  WeaponFiringRecord.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    fireArmMake = json['fireArmMake'];
    fireArmModel = json['fireArmModel'];
    selectedWindSpeedUnit = json['selectedWindSpeedUnit'];
    caliber = json['caliber'];
    serialNumber = json['serialNumber'];
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['fireArmMake'] = fireArmMake;
    data['fireArmModel'] = fireArmModel;
    data['caliber'] = caliber;
    data['serialNumber'] = serialNumber;
    data['opticsSights'] = opticsSights;
    data['accessories'] = accessories;
    data['selectedWindSpeedUnit'] = selectedWindSpeedUnit;
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
    return data;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['fireArmMake'] = fireArmMake;
    data['fireArmModel'] = fireArmModel;
    data['selectedWindSpeedUnit'] = selectedWindSpeedUnit;
    data['caliber'] = caliber;
    data['serialNumber'] = serialNumber;
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
