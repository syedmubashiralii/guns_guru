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

  static List<String> issuingAuthorities = [
    "Islamabad Capital Territory Administration",
    "Punjab Home Department",
    "Sindh Home Department",
    "Khyber Pakhtunkhwa Home Department",
    "Balochistan Home Department",
    "Azad Jammu and Kashmir Home Department",
    "Gilgit-Baltistan Home Department"
  ];

  static List<String> jurisdictions = [
    "All Pakistan",
    "Islamabad Capital Territory",
    "Punjab",
    "Sindh",
    "Khyber Pakhtunkhwa",
    "Balochistan",
    "Azad Jammu and Kashmir",
    "Gilgit-Baltistan"
  ];

  static List<String> issuingQuota = ["CM Quota"];

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
}
