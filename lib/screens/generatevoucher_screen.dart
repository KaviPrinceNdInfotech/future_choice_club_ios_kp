import 'dart:io';

import 'package:esys_flutter_share_plus/esys_flutter_share_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:future_choice_test_flutter/models/VoucherData.dart';
//import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:future_choice_test_flutter/screens/voucher_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

class GenerateVoucherPage extends StatefulWidget {
  final Voucher voucher;
  GenerateVoucherPage({Key key, @required this.voucher}) : super(key: key);

  //static GlobalKey previewContainer = new GlobalKey();

  @override
  GenerateVoucherPageState createState() => GenerateVoucherPageState();
}

class GenerateVoucherPageState extends State<GenerateVoucherPage> {
  File _imageFile;
  static final _controller = ScreenshotController();

  @override
  void initState() {
    super.initState();

    ///from here we have orientation the page..............
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Screenshot(
            controller: _controller,
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                              alignment: Alignment.topLeft,
                              width: 200,
                              child: Image.asset('images/ribbon.png')),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Align(
                                  child: Container(
                                    //width: 100,
                                    margin: EdgeInsets.only(left: 5, top: 10),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Gift Voucher',
                                      style: GoogleFonts.arizonia(
                                          letterSpacing: 3.0,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                                Align(
                                  child: Container(
                                    //width: 100,
                                    margin: EdgeInsets.only(left: 5, top: 10),
                                    alignment: Alignment.center,
                                    child: Text(
                                      'This gift voucher entitle you for 3 Nights 4 days accommodation only for 2 adults and 2 children(below 5 years) at Holiday destination detailed and offered in this Voucher',
                                      style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                          fontStyle: FontStyle.italic),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            child: Column(
                              children: [
                                Align(
                                  child: Container(
                                      margin:
                                          EdgeInsets.only(top: 20, right: 0),
                                      alignment: Alignment.topCenter,
                                      height: 90,
                                      width: 200,
                                      child: Image.asset(
                                        'images/logoheader.jpeg',
                                        fit: BoxFit.fill,
                                      )),
                                ),
                                Align(
                                  child: Container(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      'Voucher No - ' +
                                          ' ' +
                                          widget.voucher.sequenceNo,
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Name: ' + '  ' + widget.voucher.name,
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Phone/Mobile: ' + '  ' + widget.voucher.mobile,
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Email: ' + '  ' + widget.voucher.emailId,
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 50),
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Align(
                                //alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    'Choice of Location : ',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 40,
                              ),
                              Align(
                                //alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    '1:' + ' ' + widget.voucher.choiceDate1,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Align(
                                //alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    '2:' + ' ' + widget.voucher.choiceDate2,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 100,
                              ),
                              Align(
                                //alignment: Alignment.centerLeft,
                                child: Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Text(
                                    '3:' + ' ' + widget.voucher.choiceDate3,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Issued By: ' + '  ' + widget.voucher.issuedBy,
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text(
                              'Date of issue:' +
                                  '  ' +
                                  widget.voucher.issueDate,
                              style: TextStyle(
                                  fontSize: 14, fontStyle: FontStyle.italic),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'See details',
                        style: TextStyle(
                            fontSize: 13,
                            color: Colors.orange,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 20, top: 20, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              '1. Voucher is for accommodation only for 3 Nights/ 4 days for 2 adults and 2 children(below 5 years )only and valid for 12 months from the date of issue.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              '2. The gift voucher is valid for one time use and at one location only . Resort listed in this voucher may change without any prior information.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              '3. One month advance notice is required to avail this voucher . Fill in three choices of your Vacation and mail this voucher to voucher@futurechoiceclub.com',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              '4. Once the holiday has been confirmed, the booking can\'t be cancelled or modified',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              '5. Utility charges 4999/- applicable will be paid by the voucher registration at the time of reservation.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: Text(
                              '6. This voucher cannot be used during the Christmas, New Year , Black-out dates and peak season.',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 20),
                            child: Text(
                              '7. This voucher cannot be clubbed with any other offer and Voucher bearer can redeem only one voucher at a time .',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton:
          Column(mainAxisAlignment: MainAxisAlignment.end, children: [
        // floatingActionButton: FloatingActionButton.extended(
        //   onPressed: () {
        //     _takeScreenshotandShare();
        //     // Add your onPressed code here!
        //   },
        //   label: const Text('Share'),
        //   icon: const Icon(Icons.share,color: Colors.white,size: 25,),
        //   backgroundColor: Colors.orange,
        // ),
        FloatingActionButton.extended(
          onPressed: () {
            _controller
                .capture(delay: Duration(milliseconds: 10))
                .then((capturedImage) async {
              ShowCapturedWidget(context, capturedImage);
            }).catchError((onError) {
              print(onError);
            });
            _takeScreenshotandShare1();
          },
          label: const Text('Share'),
          icon: const Icon(
            Icons.share,
            color: Colors.white,
            size: 25,
          ),
          backgroundColor: Colors.orange,
          // child:
          //     Icon(
          //       Icons.share,
          //       color: Colors.white,
          //       size: 25,
          //     ),
          //
          // backgroundColor: Colors.orange,
          // elevation: 5,
        ),
        SizedBox(
          height: 10,
        ),
        if (widget.voucher.isChecked)
          SizedBox(
            height: 30,
            width: 200,
            child: FloatingActionButton(
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.zero),
              onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      VoucherLoginPage(voucher: widget.voucher))),
              child: Text(
                '',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.orange,
                    fontWeight: FontWeight.bold),
              ),
              backgroundColor: Colors.white,
              elevation: 5,
            ),
          ),
      ]),
    );
  }

  // Future setPortrait() async => await SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.portraitUp,
  //       DeviceOrientation.portraitDown,
  //     ]);
  //
  // Future setLandscape() async => await SystemChrome.setPreferredOrientations([
  //       DeviceOrientation.landscapeLeft,
  //       DeviceOrientation.landscapeRight,
  //     ]);

  ///TODO: corrected by Kumar prince. abhshek bro.......

  _takeScreenshotandShare1() async {
    _imageFile = null;
    _controller
        .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
        .then((Uint8List image) async {
      setState(() {
        _imageFile = File.fromRawPath(image);
      });
      final directory = (await getApplicationDocumentsDirectory()).path;
      Uint8List pngBytes = _imageFile.readAsBytesSync();
      File imgFile = new File('$directory/screenshot.png');
      imgFile.writeAsBytes(pngBytes);
      print("File Saved to Gallery");
      await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
    }).catchError((onError) {
      print(onError);
    });
  }

  ///TODO: easy share flutter  code.................

  // _takeScreenshotandShare() async {
  //   _imageFile = null;
  //   _controller
  //       .capture(delay: Duration(milliseconds: 10), pixelRatio: 2.0)
  //       .then((File image) async {
  //     setState(() {
  //       _imageFile = image;
  //     });
  //     final directory = (await getApplicationDocumentsDirectory()).path;
  //     Uint8List pngBytes = _imageFile.readAsBytesSync();
  //     File imgFile = new File('$directory/screenshot.png');
  //     imgFile.writeAsBytes(pngBytes);
  //     print("File Saved to Gallery");
  //     await Share.file('Anupam', 'screenshot.png', pngBytes, 'image/png');
  //   }).catchError((onError) {
  //     print(onError);
  //   });
  // }
  ///
  ///
  ///
  ///

  // Future<void> shareScreenshot() async {
  //   Directory directory;
  //   if (Platform.isAndroid) {
  //     directory = await getExternalStorageDirectory();
  //   } else {
  //     directory = await getApplicationDocumentsDirectory();
  //   }
  //   final String localPath =
  //       '${directory.path}/${DateTime.now().toIso8601String()}.png';

  //   await _controller.captureAndSave(localPath);

  //   await Future.delayed(Duration(seconds: 1));

  //   await FlutterShare.shareFile(
  //       title: 'Compartilhar comprovante',
  //       filePath: localPath,
  //       fileType: 'image/png');
  // }

  // Future getPdf(Uint8List screenShot) async {
  //   pw.Document pdf = pw.Document();
  //   pdf.addPage(
  //     pw.Page(
  //       pageFormat: PdfPageFormat.a4,
  //       build: (context) {
  //         return pw.Expanded(
  //             child: pw.Image(PdfImage.file(pdf.document, bytes: screenShot),
  //                 fit: pw.BoxFit.contain));
  //       },
  //     ),
  //   );
  //   File pdfFile = File('Your path + File name');
  //   pdfFile.writeAsBytesSync(pdf.save());
  // }

  Future<dynamic> ShowCapturedWidget(
      BuildContext context, Uint8List capturedImage) {
    return showDialog(
      useSafeArea: false,
      context: context,
      builder: (context) => Scaffold(
        appBar: AppBar(
          title: Text("Captured widget screenshot"),
        ),
        body: Center(
            child: capturedImage != null
                ? Image.memory(capturedImage)
                : Container()),
      ),
    );
  }
}
