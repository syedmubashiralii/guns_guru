class AppConstants {
  static String Name = 'fullname';
  static String CNIC = 'cnic';
  static String DOB = 'dob';
  static String Address = 'address';
  static String City = 'city';
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
  static String licenseCalibre= 'licenseCalibre';
  static String licenseIssuingAuthority='licenseIssuingAuthority';
  static String licenseJurisdiction='licenseJurisdiction';
  static String licenseIssuaingQuota='licenseIssuaingQuota';
  static String licensePicture='licensePicture';
  static String licenseValidated='licenseValidated';
  static String ammunitionDetail='ammunitionDetail';
  static String weaponDetails='weaponDetails';
  static String weaponCaliber='weaponCaliber';
  static String weaponType='weaponType';
  static String weaponNo='weaponNo';
  static String weaponMake='weaponMake';
  static String weaponModel='weaponModel';
  static const String ammunitionPurchaseDate = 'ammunitionPurchaseDate';
  static const String ammunitionPurchasedFrom = 'ammunitionPurchasedFrom';
  static const String ammunitionBrand = 'ammunitionBrand';
  static const String ammunitionCaliber = 'ammunitionCaliber';
  static const String ammunitionQuantityPurchased = 'ammunitionQuantityPurchased';


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

  static List<String> issuingQuota = ["Federal Interior Minister","CM","⁠Home Secretary","⁠Home Minister","DC"];

  static List<String> caliber = [
    "9mm",
    ".45 ACP",
    ".40 S&W",
    ".380 ACP",
    ".308 Winchester",
    ".223 Remington",
    "7.62x39mm",
    "12 Gauge",
    "10mm Auto",
    ".50 BMG"
  ];

  static List<String> serviceType=['Full Service','Partial Service'];

  static List<String> make = [
  "Glock",
  "Colt",
  "Kalashnikov Concern",
  "ArmaLite",
  "Remington",
  "Beretta",
  "Smith & Wesson",
  "Sig Sauer",
  "Heckler & Koch",
  "Winchester",
  "Ruger",
  "Mossberg",
  "FN Herstal",
  "Springfield Armory",
  "Magnum Research",
  "CZ (Czech armory)",
  "Benelli",
  "Walther",
  "Taurus",
  "Browning"
];


  static List<String> model = [
  "Glock 17",
  "Colt M1911",
  "AK-47",
  "AR-15",
  "Remington 870",
  "Beretta 92",
  "Smith & Wesson M&P",
  "Sig Sauer P226",
  "Heckler & Koch MP5",
  "Winchester Model 70",
  "Ruger 10/22",
  "Mossberg 500",
  "FN SCAR",
  "Springfield XD",
  "Desert Eagle",
  "CZ 75",
  "Benelli M4",
  "Walther PPK",
  "Taurus PT92",
  "Browning Hi-Power"
];

}
