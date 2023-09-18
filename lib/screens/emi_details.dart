import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmiDetails extends StatefulWidget {
  @override
  _EmiDetailsState createState() => _EmiDetailsState();
}

class _EmiDetailsState extends State<EmiDetails> {
  final _razorPay = Razorpay();
  int userId;
  bool isLoading = true;
  List dataFinal;
  int emiId;

  void updateEmiData() async {
    var endpointUrl = "https://fcclub.co.in/api/api/UserEmi/EmiPay";
    Map<String, String> queryParameter = {"Id": emiId.toString()};
    String queryString = Uri(queryParameters: queryParameter).query;
    var requestUrl = endpointUrl + "?" + queryString;
    http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      Map responseBody = json.decode(response.body);
      if (responseBody['Status'] == 1) {
        showToast("EMI updated successfully");
        getEmiDetails();
      }
    } else {
      showToast("Can't update Emi Data");
    }
  }

  void getEmiDetails() async {
    var endPointUrl = "https://fcclub.co.in/api/UserEmi/EmiDetails";
    Map<String, String> queryParameters = {"Id": userId.toString()};
    String queryString = Uri(queryParameters: queryParameters).query;
    var requestUrl = endPointUrl + "?" + queryString;
    http.Response response = await http.get(requestUrl);
    if (response.statusCode == 200) {
      Map responseBody = json.decode(response.body);
      if (responseBody['Status'] == 1) {
        setState(() {
          dataFinal = responseBody['Data'];
        });
      } else {
        showToast("No data available");
      }
    } else {
      showToast("No data found");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'EMI Details',
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      body: dataFinal == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              width: double.infinity,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Text(
                              'Amount',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            )),
                        Expanded(
                            flex: 1,
                            child: Text('Due Date',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                        Expanded(
                            flex: 1,
                            child: Text('Status',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15))),
                        Expanded(flex: 1, child: Text(''))
                      ],
                    ),
                  ),
                  ListView.builder(
                      shrinkWrap: true,
                      itemCount: dataFinal.length,
                      itemBuilder: (context, index) {
                        return (Card(
                          child: Container(
                            height: 80,
                            width: double.infinity,
                            margin: EdgeInsets.all(5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Expanded(
                                    child: Text(
                                  dataFinal[index]['InstallmentAmount']
                                          .toString() +
                                      " ₹",
                                  style: TextStyle(fontSize: 12),
                                )),
                                Expanded(
                                  child: Text(
                                      dataFinal[index]['InstallmentDate']
                                          .toString(),
                                      style: TextStyle(fontSize: 12)),
                                ),
                                Expanded(
                                  child: dataFinal[index]['IsPaid']
                                      ? Text(
                                          'Paid',
                                          style: TextStyle(fontSize: 12),
                                        )
                                      : Text('Pending',
                                          style: TextStyle(fontSize: 12)),
                                ),
                                Expanded(
                                    child: Visibility(
                                  visible: !dataFinal[index]['IsPaid'],
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        emiId = dataFinal[index]['Id'];
                                      });
                                      startPayment(double.parse(
                                          (dataFinal[index]
                                                  ['InstallmentAmount'])
                                              .toString()));
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            color: primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Text(
                                          'Pay Now',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white),
                                        )),
                                  ),
                                )),
                              ],
                            ),
                          ),
                        ));
                      })
                ],
              ),
            ),
    );
  }

  void getUserId() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userId = sharedPreferences.getInt("userId");
    });

    getEmiDetails();
  }

  void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    _razorPay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    //print('Success');
    showToast("Payment Successful");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.code.toString());
    //print('errrada');
    showToast("Payment failed");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response.walletName);
  }

  startPayment(double amount) {
    print(amount);
    var options = {
      'key': 'rzp_live_eiaOxQ8zHwxdX4',
      'amount': (amount * 100).toInt(),
      'name': 'Future Choice CLub',
      'description': 'Payment to FutureChoiceCLub',
      'prefill': {'contact': '', 'email': ''}
    };

    try {
      _razorPay.open(options);
    } catch (e) {
      print('error is $e');
    }
  }
}
