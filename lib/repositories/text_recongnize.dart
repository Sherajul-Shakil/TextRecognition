import 'package:google_ml_kit/google_ml_kit.dart';

import '../model/text_model.dart';

class MlService {
  Future<List<RecognizedTextt>> getText(String path) async {
    final inputImage = InputImage.fromFilePath(path);
    final textDetector = GoogleMlKit.vision.textRecognizer();
    final RecognizedText recognisedText =
        await textDetector.processImage(inputImage);

    List<RecognizedTextt> recognizedList = [];

    for (TextBlock block in recognisedText.blocks) {
      recognizedList.add(
        RecognizedTextt(lines: block.lines, block: block.text.toLowerCase()),
      );
    }

    return recognizedList;
  }
}
