import 'dart:io';
import 'dart:ui';
import 'package:beyond_wallet/api_services/skip_upload_docs_api.dart';
import 'package:beyond_wallet/api_services/upload_docs_hash_api.dart';
import 'package:beyond_wallet/api_services/upload_files_api.dart';
import 'package:beyond_wallet/constants/constants.dart';
import 'package:beyond_wallet/localization/localization.dart';
import 'package:beyond_wallet/models/skip_upload_docs_model.dart';
import 'package:beyond_wallet/models/upload_document_hash_model.dart';
import 'package:beyond_wallet/models/upload_documents_model.dart';
import 'package:beyond_wallet/screens/home/verification_static.dart';
import 'package:beyond_wallet/services/shared_prefs.dart';
import 'package:beyond_wallet/widgets/Loader.dart';
import 'package:beyond_wallet/widgets/appBar.dart';
import 'package:beyond_wallet/widgets/button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
class UploadDocuments extends StatefulWidget {
  @override
  _UploadDocumentsState createState() => _UploadDocumentsState();
}

class _UploadDocumentsState extends State<UploadDocuments> {
  var localData;
  File document;
  bool isApiCallProgress = false;
  bool isDocsUploadProgress = false;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    localData = Provider.of<LocalData>(context,listen: false);
  }
  @override
  Widget build(BuildContext context) {
    var translate = DemoLocalization.of(context);
    var height = MediaQuery.of(context).size.height;
    return isApiCallProgress?Loader():Scaffold(
      appBar: appBar(translate.getTranslatedValue('Upload Documents'), context,true),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please upload the following documents:',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold
              )
            ),
            SizedBox(height: 20.0,),
            Text(
              '1. National Id\n'
                  '2. Passport\n'
                  '3. Driving Lisence',
              style: TextStyle(
                  fontSize: 17.0,
                  fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 20.0,),
            DottedBorder(
                color: Colors.black,
                strokeWidth: 1,
                child: InkWell(
                  onTap: () async {
                    File tempFile = await FilePicker.getFile(
                        type:FileType.custom, allowedExtensions: ['jpg', 'pdf', 'doc','png']);
                    var size = await tempFile.length();
                    if(size > 4242880){
                      Fluttertoast.showToast(msg: 'File size more than 5mb');
                      print('File size more than 5mb');
                      print(size);
                    }else{
                      setState(() {
                        document = tempFile;
                      });
                    }
                  },
                  child: Container(
                      height: height*0.3,
                      child: document!=null&&!document.path.endsWith('pdf')?Image.file(document,fit: BoxFit.fill,):
                      document!=null && document.path.endsWith('pdf')?
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Center(
                          child: Text(
                            document.path.split('/').last,
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 20.0
                            ),
                          ),
                        ),
                      ): Container(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_upload,
                                  size: 40.0,
                                  color: primaryColor,
                                ),
                                SizedBox(height: 20.0,),
                                Text(
                                  'Click Here to Upload Documents',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                      )
                  ),
                )
              ),
            SizedBox(height: 20.0,),
            isDocsUploadProgress?Center(
              child: CircularProgressIndicator(),
            ):GreenButton(
              text: translate.getTranslatedValue('Upload'),
              onClicked: () async {
                  if(document!=null){
                    setState(() {
                      isDocsUploadProgress = true;
                    });
                    UploadDocsResponseModel response = await UploadDocumentsApi().uploadDocuments(document);
                    if(response!=null){
                      Fluttertoast.showToast(msg: response.message);
                      if(response.status==1){
                        UploadDocsHashRequestModel requestModel = new UploadDocsHashRequestModel();
                        Hashes hsh = new Hashes();
                        hsh.name = document.path.split("/").last;
                        hsh.hash = response.hash;
                        hsh.type = document.path.split(".").last;
                        List<Hashes> hashes = [hsh];
                        requestModel.hashes=hashes;
                        UploadDocsHashResponseModel uploadDocsHashResponse =await UploadDocsHashApi().uploadDocsHash(requestModel, localData.token);
                        setState(() {
                          isDocsUploadProgress = false;
                        });
                        if(uploadDocsHashResponse!=null){
                          Fluttertoast.showToast(msg: uploadDocsHashResponse.message);
                          if(uploadDocsHashResponse.status==1){
                            Get.offAll(()=>VerificationStatic(
                              text:'Pending approval from cashier',
                            ));
                          }
                        }else{
                          Fluttertoast.showToast(msg: 'Something went wrong');
                        }

                      }else{
                        setState(() {
                          isDocsUploadProgress = false;
                        });
                      }
                    }else{
                      setState(() {
                        isDocsUploadProgress = false;
                      });
                      Fluttertoast.showToast(msg: 'Something went wrong');
                    }
                  }else{
                    Fluttertoast.showToast(msg: 'Please Select Document First');
                  }
              },
            ),
            SizedBox(height: 30.0,),
            // InkWell(
            //   onTap: () async {
            //     setState(() {
            //       isApiCallProgress= true;
            //     });
            //     SkipUploadDocsResponseModel response =await SkipUploadDocsApi().skipUploadDocs(localData.token);
            //     if(response!=null){
            //       Fluttertoast.showToast(msg: response.message);
            //       if(response.status==1){
            //         Get.to(()=>VerificationStatic());
            //       }else{
            //         setState(() {
            //           isApiCallProgress= false;
            //         });
            //       }
            //     }else{
            //       setState(() {
            //         isApiCallProgress= false;
            //       });
            //       Fluttertoast.showToast(msg: 'Something went wrong');
            //     }
            //
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         'Skip',
            //         style: TextStyle(
            //           fontSize: 25.0,
            //           color: primaryColor
            //         ),
            //       ),
            //       SizedBox(width: 10.0,),
            //       Icon(
            //         Icons.arrow_forward_ios,
            //         color: primaryColor,
            //       )
            //     ],
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
