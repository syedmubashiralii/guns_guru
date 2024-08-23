class AppConstants {
  static String FirstName = 'firstname';
  static String LastName = 'lastname';
  static String CNIC = 'cnic';
  static String DOB = 'dob';
  static String PhoneNo = 'phoneno';
  static String Address = 'address';
  static String City = 'city';
  static String Gender = 'gender';
  static String CNICFrontSide = 'cnic_front_side';
  static String CNICBackSide = 'cnic_back_side';
  static String UID = 'uid';
  //license
  static String license = 'license';
  static String licenseTrackingNumber = 'licenseTrackingNumber';
  static String licenseNumber = 'licenseNumber';
  static String licenseAmmunitionLimit = 'licenseAmmunitionLimit';
  static String licenseDateOfIssuance = 'licenseDateOfIssuance';
  static String licenseValidTill = 'licenseValidTill';
  static String licenseCalibre = 'licenseCalibre';
  static String licenseIssuingAuthority = 'licenseIssuingAuthority';
  static String licenseJurisdiction = 'licenseJurisdiction';
  static String licenseIssuaingQuota = 'licenseIssuaingQuota';
  static String licensePicture = 'licensePicture';
  static String licenseValidated = 'licenseValidated';
  static String ammunitionDetail = 'ammunitionDetail';
  static String weaponDetails = 'weaponDetails';
  static String weaponCaliber = 'weaponCaliber';
  static String weaponType = 'weaponType';
  static String weaponNo = 'weaponNo';
  static String weaponMake = 'weaponMake';
  static String weaponModel = 'weaponModel';
  static const String ammunitionPurchaseDate = 'ammunitionPurchaseDate';
  static const String ammunitionPurchasedFrom = 'ammunitionPurchasedFrom';
  static const String ammunitionBrand = 'ammunitionBrand';
  static const String ammunitionCaliber = 'ammunitionCaliber';
  static const String ammunitionQuantityPurchased =
      'ammunitionQuantityPurchased';

  static const String weaponFiringRecord = 'weaponFiringRecord';
  static const String weaponFiringDate = 'weaponfiringDate';
  static const String weaponFiringLocation = 'weaponFiringLocation';
  static const String weaponFiringShotsFired = 'weaponFiringShotsFired';
  static const String weaponFiringNotes = 'weaponFiringNotes';

  static const String weaponServiceRecord = 'weaponServiceRecord';
  static const String weaponServiceDate = 'weaponServiceDate';
  static const String weaponServicePartsChanged = 'weaponServicePartsChanged';
  static const String weaponServiceDoneBy = 'weaponServiceDoneBy';
  static const String weaponServiceNotes = 'weaponServiceNotes';

  static List<String> issuingAuthorities = [
    "Federal",
    "KPK",
    "Punjab",
    "Balochistan",
    "Sindh",
  ];

  static List<String> jurisdictions = [
    "All Pakistan",
    "KPK",
    "Punjab",
    "Sindh",
    "Balochistan",
  ];

  static List<String> issuingQuota = [
    "Federal Interior Minister",
    "CM",
    "⁠Home Secretary",
    "⁠Home Minister",
    "DC"
  ];

  static List<String> caliber = [
    // "9mm",
    // ".22",
    // ".22 Long Rifle (.22 LR)",
    // ".25 ACP (.25 Auto)",
    // ".32 ACP (.32 Auto)",
    // ".380 ACP (.380 Auto, 9mm Kurz)",
    // "9mm Parabellum (9mm Luger, 9x19mm)",
    // ".38 Super",
    // ".40 S&W",
    // "10mm Auto",
    // ".44",
    // ".45 ACP (.45 Auto)",
    // ".357 SIG",
    // "5.7x28mm",
    // ".50 AE (Action Express)",
    // ".22 Short",
    // ".22 Long",
    // ".22 Long Rifle (.22 LR)",
    // ".22 WMR (.22 Magnum)",
    // ".32 S&W",
    // ".32 S&W Long",
    // ".327 Federal Magnum",
    // ".38 S&W",
    // ".38 Special",
    // ".357 Magnum",
    // ".41 Magnum",
    // ".44 Special",
    // ".44 Magnum",
    // ".45 Colt (.45 Long Colt)",
    // ".454 Casull",
    // ".460 S&W Magnum",
    // ".500 S&W Magnum"
  ];

  static List<String> serviceType = ['Full Service', 'Partial Service'];

  static List<String> make = [
    // "Glock",
    // "Colt",
    // "Kalashnikov Concern",
    // "ArmaLite",
    // "Remington",
    // "Beretta",
    // "Smith & Wesson",
    // "Sig Sauer",
    // "Heckler & Koch",
    // "Winchester",
    // "Ruger",
    // "Mossberg",
    // "FN Herstal",
    // "Springfield Armory",
    // "Magnum Research",
    // "CZ (Czech armory)",
    // "Benelli",
    // "Walther",
    // "Taurus",
    // "Browning"
  ];

  static List<String> model = [
    // "Glock 17",
    // "Colt M1911",
    // "AK-47",
    // "AR-15",
    // "Remington 870",
    // "Beretta 92",
    // "Smith & Wesson M&P",
    // "Sig Sauer P226",
    // "Heckler & Koch MP5",
    // "Winchester Model 70",
    // "Ruger 10/22",
    // "Mossberg 500",
    // "FN SCAR",
    // "Springfield XD",
    // "Desert Eagle",
    // "CZ 75",
    // "Benelli M4",
    // "Walther PPK",
    // "Taurus PT92",
    // "Browning Hi-Power"
  ];
}
