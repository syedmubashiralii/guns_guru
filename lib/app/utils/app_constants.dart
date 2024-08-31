import 'package:guns_guru/app/modules/home/models/model_make_model.dart';

class AppConstants {
  static String FirstName = 'firstname';
  static String LastName = 'lastname';
  static String CNIC = 'cnic';
  static String DOB = 'dob';
  static String PhoneNo = 'phoneno';
  static String Address = 'address';
  static String City = 'city';
  static String CountryCode = 'countrycode';
  static String Country = 'country';
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
  static String DocumentType = 'documenttype';
  static String ammunitionDetail = 'ammunitionDetail';
  static String weaponDetails = 'weaponDetails';
  static String weaponCaliber = 'weaponCaliber';
  static String weaponType = 'weaponType';
  static String weaponAuthorizeDealerName = 'weaponauthorizedealername';
  static String weaponAuthorizeDealerAddress = 'weaponauthorizedealeraddress';
  static String weaponAuthorizeDealerPhoneNumber =
      'weaponauthorizedealerphonenumber';
  static String weaponNo = 'weaponNo';
  static String weaponPurchaseRecipt = 'weaponpurchaserecipt';
  static String weaponPurchaseDate = 'weaponpurchasedate';
  static String weaponMake = 'weaponMake';
  static String weaponModel = 'weaponModel';
  static const String ammunitionPurchaseDate = 'ammunitionPurchaseDate';
  static const String ammunitionPurchasedFrom = 'ammunitionPurchasedFrom';
  static const String ammunitionBrand = 'ammunitionBrand';
  static const String typeOfRound = 'typeOfRound';
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

   // Static shooterlogbook  identifiers
  static const String fireArmMake = 'fireArmMake';
  static const String fireArmModel = 'fireArmModel';
  static const String caliber = 'caliber';
  static const String serialNumber = 'serialNumber';
  static const String opticsSights = 'opticsSights';
  static const String accessories = 'accessories';
  static const String bulletWeight = 'bulletWeight';
  static const String bulletType = 'bulletType';
  static const String muzzleVelocity = 'muzzleVelocity';
  static const String lotBoxNumber = 'lotBoxNumber';
  static const String notes = 'notes';
  static const String rangeNameLocation = 'rangeNameLocation';
  static const String date = 'date';
  static const String time = 'time';
  static const String weatherConditions = 'weatherConditions';
  static const String windDirection = 'windDirection';
  static const String windSpeed = 'windSpeed';
  static const String temperature = 'temperature';
  static const String selectedTempuratureUnit = 'selectedTemperatureUnit';
  static const String humidity = 'humidity';
  static const String altitude = 'altitude';
  static const String terrain = 'terrain';
  static const String brightness = 'brightness';
  static const String shootingDistance = 'shootingDistance';
  static const String selectedShootingDistanceUnit = 'selectedShootingDistanceUnit';
  static const String targetType = 'targetType';
  static const String shootingPosition = 'shootingPosition';
  static const String roundsFired = 'roundsFired';
  static const String malfunctions = 'malfunctions';
  static const String shootingDrills = 'shootingDrills';
  static const String accuracyGrouping = 'accuracyGrouping';
  static const String sightAdjustment = 'sightAdjustment';
  static const String performanceObservations = 'performanceObservations';
  static const String lessonsLearned = 'lessonsLearned';
  static const String additionalNotes = 'additionalNotes';
  static const String selectedWindSpeedUnit='selectedWindSpeedUnit';

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

  static List<String> weaponTypeList = [
    'PISTOL',
    'RIFLE',
    'SHOTGUN',
    'REVOLVER'
  ];

  static List<String> ammoBrand = [];
  static List<String> typeofRounds = [];

  static List<String> caliberList = [];

  static List<String> serviceType = ['Full Service', 'Partial Service'];

  static List<String> make = [];

  static List<Model> model = [];

  static List<String> opticsorSights = [
    "Iron Sights",
    "Red Dot Sights",
    "Holographic Sights",
    "Telescopic Sights (Scopes)",
    "Night Sights",
    "Laser Sights",
    "Peep Sights",
    "Fiber Optic Sights"
  ];

  static List<String> brightnessLevel = [
    "Dawn",
    "Midday",
    "Dusk",
    "Sunset",
    "Night"
  ];
  static List<String> terrains = [
    "Desert",
    "Mountains",
    "Shooting Range",
    "Forest",
    "Urban"
  ];

  static List<String> targetTypes = [
    "Bullseye Target",
    "Silhouette Target",
    "Grid Target",
    "Animal Silhouette Target",
    "Zombies or Novelty Target",
    "Gong Target",
    "Dueling Trees",
    "Pepper Poppers",
    "Plate Racks",
    "Reactive Steel Target",
    "Standard Clay Pigeon (Disc)",
    "Midi Clays",
    "Mini Clay",
    "Battue Clays",
    "Rabbit Clays",
    "Flash Target",
    "Patterning Board",
    "Exploding Targets",
    "Laser Targets",
    "Electronic Scoring",
    "Self-Healing",
    "Foam Animal",
    "Human 3D Target",
    "Running Target",
    "Pop-up",
    "Bottle",
    "Can"
  ];

  static List<String> shootingPositions = [
    "Standing Position",
    "Kneeling Position",
    "Sitting Position",
    "Prone Position",
    "Benchrest Position",
    "Squatting Position",
    "Offhand Position",
    "Cross-Legged Sitting Position",
    "Firing from Cover",
    "Unsupported Standing"
  ];

    static const Map<String, String> ALL_COUNTRIES_ALPHA_2 = {
    "Afghanistan": "AF",
    "Albania": "AL",
    "Algeria": "DZ",
    "American Samoa": "AS",
    "Andorra": "AD",
    "Angola": "AO",
    "Anguilla": "AI",
    "Antigua and Barbuda": "AG",
    "Argentina": "AR",
    "Armenia": "AM",
    "Aruba": "AW",
    "Australia": "AU",
    "Austria": "AT",
    "Azerbaijan": "AZ",
    "Bahamas": "BS",
    "Bahrain": "BH",
    "Bangladesh": "BD",
    "Barbados": "BB",
    "Belarus": "BY",
    "Belgium": "BE",
    "Belize": "BZ",
    "Benin": "BJ",
    "Bermuda": "BM",
    "Bhutan": "BT",
    "Bolivia": "BO",
    "Bosnia and Herzegovina": "BA",
    "Botswana": "BW",
    "Brazil": "BR",
    "British Virgin Islands": "VG",
    "Brunei Darussalam": "BN",
    "Bulgaria": "BG",
    "Burkina Faso": "BF",
    "Burundi": "BI",
    "Cambodia": "KH",
    "Cameroon": "CM",
    "Canada": "CA",
    "Cape Verde": "CV",
    "Central African Republic": "CF",
    "Chad": "TD",
    "Chile": "CL",
    "China": "CN",
    "Hong Kong": "HK",
    "Macao": "MO",
    "Colombia": "CO",
    "Comoros": "KM",
    "Congo": "CG",
    "Costa Rica": "CR",
    "C\u00f4te d'Ivoire": "CI",
    "Croatia": "HR",
    "Cuba": "CU",
    "Cyprus": "CY",
    "Czech Republic": "CZ",
    "Denmark": "DK",
    "Djibouti": "DJ",
    "Dominica": "DM",
    "Dominican Republic": "DO",
    "Ecuador": "EC",
    "Egypt": "EG",
    "El Salvador": "SV",
    "Equatorial Guinea": "GQ",
    "Eritrea": "ER",
    "Estonia": "EE",
    "Ethiopia": "ET",
    "European Union": "EU",
    "Faroe Islands": "FO",
    "Fiji": "FJ",
    "Finland": "FI",
    "France": "FR",
    "French Guiana": "GF",
    "French Polynesia": "PF",
    "Gabon": "GA",
    "Gambia": "GM",
    "Georgia": "GE",
    "Germany": "DE",
    "Ghana": "GH",
    "Greece": "GR",
    "Greenland": "GL",
    "Grenada": "GD",
    "Guadeloupe": "GP",
    "Guam": "GU",
    "Guatemala": "GT",
    "Guinea-Bissau": "GW",
    "Haiti": "HT",
    "Honduras": "HN",
    "Hungary": "HU",
    "Iceland": "IS",
    "India": "IN",
    "Indonesia": "ID",
    "Iran (Islamic Republic of)": "IR",
    "Iraq": "IQ",
    "Ireland": "IE",
    "Israel": "IL",
    "Italy": "IT",
    "Japan": "JP",
    "Jordan": "JO",
    "Kazakhstan": "KZ",
    "Kenya": "KE",
    "Kiribati": "KI",
    "Korea": "KR",
    "Kuwait": "KW",
    "Kyrgyzstan": "KG",
    "Lao PDR": "LA",
    "Latvia": "LV",
    "Lebanon": "LB",
    "Lesotho": "LS",
    "Liberia": "LR",
    "Libya": "LY",
    "Liechtenstein": "LI",
    "Lithuania": "LT",
    "Luxembourg": "LU",
    "Madagascar": "MG",
    "Malawi": "MW",
    "Malaysia": "MY",
    "Maldives": "MV",
    "Mali": "ML",
    "Malta": "MT",
    "Marshall Islands": "MH",
    "Martinique": "MQ",
    "Mauritania": "MR",
    "Mauritius": "MU",
    "Mexico": "MX",
    "Micronesia, Federated States of": "FM",
    "Moldova": "MD",
    "Monaco": "MC",
    "Mongolia": "MN",
    "Montenegro": "ME",
    "Montserrat": "MS",
    "Morocco": "MA",
    "Mozambique": "MZ",
    "Myanmar": "MM",
    "Namibia": "NA",
    "Nauru": "NR",
    "Nepal": "NP",
    "Netherlands": "NL",
    "Netherlands Antilles": "AN",
    "New Caledonia": "NC",
    "New Zealand": "NZ",
    "Nicaragua": "NI",
    "Niger": "NE",
    "Nigeria": "NG",
    "Northern Mariana Islands": "MP",
    "Norway": "NO",
    "Oman": "OM",
    // "Pakistan": "PK",
    "Palau": "PW",
    "Palestinian Territory": "PS",
    "Panama": "PA",
    "Papua New Guinea": "PG",
    "Paraguay": "PY",
    "Peru": "PE",
    "Philippines": "PH",
    "Pitcairn": "PN",
    "Poland": "PL",
    "Portugal": "PT",
    "Puerto Rico": "PR",
    "Qatar": "QA",
    "R\u00e9union": "RE",
    "Romania": "RO",
    "Russian Federation": "RU",
    "Rwanda": "RW",
    "Saint Kitts and Nevis": "KN",
    "Saint Lucia": "LC",
    "Saint Vincent and Grenadines": "VC",
    "Samoa": "WS",
    "San Marino": "SM",
    "Sao Tome and Principe": "ST",
    "Saudi Arabia": "SA",
    "Senegal": "SN",
    "Serbia": "RS",
    "Seychelles": "SC",
    "Sierra Leone": "SL",
    "Singapore": "SG",
    "Slovakia": "SK",
    "Slovenia": "SI",
    "Solomon Islands": "SB",
    "Somalia": "SO",
    "South Africa": "ZA",
    "Spain": "ES",
    "Sri Lanka": "LK",
    "Sudan": "SD",
    "Suriname": "SR",
    "Swaziland": "SZ",
    "Sweden": "SE",
    "Switzerland": "CH",
    "Syrian Arab Republic": "SY",
    "Taiwan (Province of China)": "TW",
    "Tajikistan": "TJ",
    "Tanzania": "TZ",
    "Thailand": "TH",
    "Timor-Leste": "TL",
    "Togo": "TG",
    "Tonga": "TO",
    "Trinidad and Tobago": "TT",
    "Tunisia": "TN",
    "Turkey": "TR",
    "Turkmenistan": "TM",
    "Tuvalu": "TV",
    "Uganda": "UG",
    "Ukraine": "UA",
    "United Arab Emirates": "AE",
    "United Kingdom": "GB",
    "United States of America": "US",
    "Uruguay": "UY",
    "Uzbekistan": "UZ",
    "Vanuatu": "VU",
    "Venezuela": "VE",
    "Viet Nam": "VN",
    "Virgin Islands, US": "VI",
    "Yemen": "YE",
    "Zambia": "ZM",
    "Zimbabwe": "ZW"
  };


  final List<String> weatherConditionsList = [
    'Cloudy',
    'Partly Cloudy',
    'Sunny',
    'Thunderstorm',
    'Rainy'
  ];

}
