import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:text_recognition/providers/text_provider.dart';

import '../controllers/nid_con.dart';

class ResultPage2 extends StatelessWidget {
  const ResultPage2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result'),
        centerTitle: true,
      ),
      body: GetBuilder(
        init: NidController(),
        builder: (NidController nidCon) => nidCon.getIsloading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'Found ${nidCon.recognizedList.length} items from image',
                      ),
                    ),
                    const SizedBox(
                      height: 5.0,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemCount: nidCon.recognizedList.length,
                        padding: const EdgeInsets.all(12.0),
                        itemBuilder: (_, index) {
                          var data =
                              nidCon.recognizedList[index].lines![0].text;
                          if (data.toLowerCase() == "name") {
                            nidCon.name.value =
                                nidCon.recognizedList[index + 1].lines![0].text;
                            log("********************************");
                            log(nidCon.name.value);
                          } else if (data
                              .toLowerCase()
                              .contains("date of birth")) {
                            RegExp regExp = RegExp(r'\d{2}\s\w{3}\s\d{4}');
                            nidCon.dob.value = regExp.stringMatch(data)!;
                            // nidCon.dob.value = data;
                            log(nidCon.dob.value);
                          } else if (data.toLowerCase().contains("nid no")) {
                            nidCon.nid.value =
                                nidCon.recognizedList[index + 1].lines![0].text;
                            log(nidCon.nid.value);
                          } else {}

                          return Center(
                            child: ListTile(
                                title: Center(
                              child: SelectableText(
                                  '${index + 1}: ${nidCon.recognizedList[index].lines![0].text}'),
                            )),
                          );
                        },
                      ),
                    ),
                    if (nidCon.image.value != "")
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        child: Image.file(
                          File(nidCon.getImage),
                          width: Get.width - 50,
                          height: Get.width - 100,
                          fit: BoxFit.scaleDown,
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
