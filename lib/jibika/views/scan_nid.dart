import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition/jibika/controllers/nid_con.dart';
import 'package:text_recognition/jibika/views/result_page.dart';
import 'package:text_recognition/view/custom_widgets.dart/upload_image_button.dart';

class NidScanPage extends StatefulWidget {
  NidScanPage({Key? key}) : super(key: key);

  @override
  State<NidScanPage> createState() => _NidScanPageState();
}

class _NidScanPageState extends State<NidScanPage> {
  NidController nidCon = Get.put(NidController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image recongnition'),
        centerTitle: true,
      ),
      body: Obx(
        () => nidCon.getIsloading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (nidCon.image.value != "")
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4.0),
                      child: Image.file(
                        File(nidCon.getImage),
                        width: 350,
                        height: 400,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                  const SizedBox(
                    height: 25.0,
                  ),
                  CustomButton(
                      text: 'Upload image', onTap: nidCon.pickImageFromGallery),
                  CustomButton(
                      text: 'Get Text',
                      onTap: nidCon.getImage != ""
                          ? () {
                              nidCon.getText();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => const ResultPage2()));
                            }
                          : null),
                ],
              ),
      ),
    );
  }
}
