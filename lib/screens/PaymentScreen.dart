import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:flutter/material.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';
class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  final _razorpay=Razorpay();
  GlobalKey<FormState> formKey=GlobalKey<FormState>();
  TextEditingController amountController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Options',style: TextStyle(color: Colors.white,fontSize: 16),),
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                        showPaymentDialog();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(
                            color:tempColor
                          )
                        ),
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Image.asset('images/exchange.gif',height: 150,width: 150,fit: BoxFit.contain,),
                            SizedBox(height: 10,),
                            Text('Exchange',style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold
                            ),),
                            Text('Choose amount'),
                            SizedBox(height: 10,),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: GestureDetector(
                      onTap: (){
                          startPayment(10618*100.toDouble());
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5)
                              ,border:Border.all(
                          color: tempColor
                        )
                        ),
                        margin: EdgeInsets.all(15),
                        child: Column(
                          children: [
                            Image.asset('images/amc.jpeg',height: 150,width: 150,fit: BoxFit.contain,),
                            SizedBox(height: 10,),
                            Text('Amc',style: TextStyle(
                              fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                            Text('8999 Rs + Gst'),
                            SizedBox(height: 10,)
                          ],

                        ),
                      ),
                    ),
                  )
                ],

              ),
              GestureDetector(
                onTap: (){
                  showPaymentDialog();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5)
                      ,border:Border.all(
                      color: tempColor
                  )
                  ),
                  margin: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Image.asset('images/other.png',height: 150,width: 150,fit: BoxFit.contain,),
                      SizedBox(height: 10,),
                      Text('Other',style: TextStyle(
                          fontSize: 13,fontWeight: FontWeight.bold
                      ),),
                      Text('Choose amount'),
                      SizedBox(height: 10,)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print('Success');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print(response.code.toString());
    print('errrada');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
    print(response.walletName);
  }

  startPayment(double amount){
    var options = {
      'key': 'rzp_live_eiaOxQ8zHwxdX4',
      'amount': amount,
      'name': 'Future Choice CLub',
      'description': 'Payment to FutureChoiceCLub',
      'prefill': {
        'contact': '',
        'email': ''
      }
    };

      try{
        _razorpay.open(options);
      }catch(e){
      print('error is $e');
      }

    }

    void showPaymentDialog(){
      showDialog<void>(
      context: context,
      barrierDismissible: true,
      // false = user must tap button, true = tap outside dialog
      builder: (BuildContext dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4)
          ),
          child: Container(
            padding: EdgeInsets.all(10),
            height: 220,
            child: Form(
              key: formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10,bottom: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Provide amount')),
                  ),
                  TextFormField(
                    validator: (value){
                      if(value.isEmpty){
                        return 'required';
                      }else{
                        return null;
                      }
                    },
                    controller: amountController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Amount',
                        labelStyle: TextStyle(color: primaryColor),
                        enabledBorder:OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1,color: primaryColor)
                        ),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(width: 1,color: primaryColor)
                        ),
                      border: OutlineInputBorder()
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      if(formKey.currentState.validate()){
                        startPayment(double.parse(amountController.text.toString())*100);
                        Navigator.pop(dialogContext);
                      }
                    },
                    child: Container(
                      width: 160,
                      padding: EdgeInsets.all(10),
                      margin: EdgeInsets.only(top: 20),
                      color: primaryColor,
                      child: Text('Pay Now',style: TextStyle(color: Colors.white),textAlign: TextAlign.center,),

                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  }


