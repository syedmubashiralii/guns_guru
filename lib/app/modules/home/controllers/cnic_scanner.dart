import 'package:flutter/foundation.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:guns_guru/app/modules/home/models/cnic_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CnicScanner {
  /// it will pick your image either form Gallery or from Camera
  final ImagePicker _picker = ImagePicker();

  /// it will check the image source
  late ImageSource source;

  /// a model class to store cnic data
  final CnicModel _cnicDetails = CnicModel();

  /// this var track record which side has been scanned
  /// and which needed to be scanned and prompt user accordingly
  bool isFrontScan = false;

  /// this method will be called when user uses this package
  Future<CnicModel> scanImage({required ImageSource imageSource}) async {
    source = imageSource;
    XFile? image = await _picker.pickImage(source: imageSource);
    if (image == null) {
      return Future.value(_cnicDetails);
    } else {
      return await scanCnic(imageToScan: InputImage.fromFilePath(image.path));
    }
  }

  /// this method will process the images and extract information from the card
  Future<CnicModel> scanCnic({required InputImage imageToScan}) async {
    List<String> cnicDates = [];
    final textDetector = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognisedText =
        await textDetector.processImage(imageToScan);
    bool isNameNext = false;
    for (TextBlock block in recognisedText.blocks) {
      for (TextLine line in block.lines) {
        if (isNameNext) {
          _cnicDetails.cnicHolderName = line.text;
          isNameNext = false;
        }
        if (line.text.toLowerCase() == "name" ||
            line.text.toLowerCase() == "nane" ||
            line.text.toLowerCase() == "nam" ||
            line.text.toLowerCase() == "ame") {
          isNameNext = true;
        }
        for (TextElement element in line.elements) {
          String selectedText = element.text;
          if (selectedText.length == 15 &&
              selectedText.contains("-", 5) &&
              selectedText.contains("-", 13)) {
            _cnicDetails.cnicNumber = selectedText;
          } else if (selectedText.length == 10 &&
              ((selectedText.contains("/", 2) &&
                      selectedText.contains("/", 5)) ||
                  (selectedText.contains(".", 2) &&
                      selectedText.contains(".", 5)))) {
            cnicDates.add(selectedText.replaceAll(".", "/"));
          }
        }
      }
    }
    if (cnicDates.isNotEmpty &&
        _cnicDetails.cnicExpiryDate.length == 10 &&
        !cnicDates.contains(_cnicDetails.cnicExpiryDate)) {
      cnicDates.add(_cnicDetails.cnicExpiryDate);
    }
    if (cnicDates.isNotEmpty &&
        _cnicDetails.cnicIssueDate.length == 10 &&
        !cnicDates.contains(_cnicDetails.cnicIssueDate)) {
      cnicDates.add(_cnicDetails.cnicIssueDate);
    }
    if (cnicDates.isNotEmpty &&
        _cnicDetails.cnicExpiryDate.length == 10 &&
        !cnicDates.contains(_cnicDetails.cnicExpiryDate)) {
      cnicDates.add(_cnicDetails.cnicExpiryDate);
    }
    if (cnicDates.length > 1) {
      cnicDates = sortDateList(dates: cnicDates);
    }
    if (cnicDates.length == 1 &&
        _cnicDetails.cnicHolderDateOfBirth.length != 10) {
      _cnicDetails.cnicHolderDateOfBirth = cnicDates[0];
      isFrontScan = true;
    } else if (cnicDates.length == 2) {
      _cnicDetails.cnicIssueDate = cnicDates[0];
      _cnicDetails.cnicExpiryDate = cnicDates[1];
    } else if (cnicDates.length == 3) {
      _cnicDetails.cnicHolderDateOfBirth = cnicDates[0].replaceAll(".", "/");
      _cnicDetails.cnicIssueDate = cnicDates[1].replaceAll(".", "/");
      _cnicDetails.cnicExpiryDate = cnicDates[2].replaceAll(".", "/");
    }
    textDetector.close();
    if (_cnicDetails.cnicNumber.isNotEmpty &&
        _cnicDetails.cnicHolderDateOfBirth.isNotEmpty &&
        _cnicDetails.cnicIssueDate.isNotEmpty &&
        _cnicDetails.cnicExpiryDate.isNotEmpty) {
      if (kDebugMode) {
        print('==================== SMART CARD DETAILS $_cnicDetails');
      }
      return Future.value(_cnicDetails);
    } else {
      if (kDebugMode) {
        print('==================== OLD CARD DETAILS $_cnicDetails');
      }
      // return await scanImage(imageSource: source);
      return Future.value(_cnicDetails);
    }
  }

  /// it will sort the dates
  static List<String> sortDateList({required List<String> dates}) {
    List<DateTime> tempList = [];
    DateFormat format = DateFormat("dd/MM/yyyy");
    for (int i = 0; i < dates.length; i++) {
      tempList.add(format.parse(dates[i]));
    }
    tempList.sort((a, b) => a.compareTo(b));
    dates.clear();
    for (int i = 0; i < tempList.length; i++) {
      dates.add(format.format(tempList[i]));
    }
    return dates;
  }
}
