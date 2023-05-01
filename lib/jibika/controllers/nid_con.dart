import 'dart:developer';

import 'package:get/get.dart';
// import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';

import '../models/text_model.dart';

class NidController extends GetxController {
  var isLoading = false.obs;
  get getIsloading => isLoading.value;
  set setIsLoading(bool val) => isLoading.value = val;

  //filter variable
  var name = "".obs;
  var dob = "".obs;
  var nid = "".obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changeLoading(bool val) {
    isLoading.value = val;
    update();
  }

  //Get image path from gallery
  final ImagePicker _imagePicker = ImagePicker();
  RxString image = "".obs;
  get getImage => image.value;
  set setImage(String val) => image.value = val;
  // String? image;
  Future<void> pickImageFromGallery() async {
    try {
      changeLoading(true);
      final _image = await _imagePicker.pickImage(source: ImageSource.gallery);
      // image.value = _image!.path;
      setImage = _image!.path;
      log("Image path: $image");
      changeLoading(false);
    } catch (e) {
      log("Error in get image: $e");
      changeLoading(false);
    }
  }

  List<RecognizedText2> recognizedList = [];
  Future<List<RecognizedText2>> getText() async {
    try {
      recognizedList.clear();
      changeLoading(true);
      final inputImage = InputImage.fromFilePath(getImage);
      // final textDetector = GoogleMlKit.vision.textDetector();
      final textDetector = TextRecognizer();
      final RecognizedText recognisedText =
          await textDetector.processImage(inputImage);

      for (TextBlock block in recognisedText.blocks) {
        recognizedList.add(
          RecognizedText2(lines: block.lines, block: block.text.toLowerCase()),
        );
      }
      changeLoading(false);
      return recognizedList;
    } catch (e) {
      log("Error in get text: $e");
      changeLoading(false);
      return [];
    }
  }
}
