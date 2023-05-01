import 'package:google_ml_kit/google_ml_kit.dart';

class RecognizedTextt {
  String? block;
  List<TextLine>? lines;

  RecognizedTextt({required this.lines, this.block});
}
