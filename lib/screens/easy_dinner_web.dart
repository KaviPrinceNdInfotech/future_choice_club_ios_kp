import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:future_choice_test_flutter/utils/datasource.dart';

//import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class WebViewEasydinner extends StatefulWidget {
  const WebViewEasydinner({Key key}) : super(key: key);

  @override
  State<WebViewEasydinner> createState() => _WebViewEasydinnerState();
}

class _WebViewEasydinnerState extends State<WebViewEasydinner> {
  double _progress = 0;
  InAppWebViewController inAppWebViewController;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var isLastPage = await inAppWebViewController.canGoBack();
        if (isLastPage) {
          inAppWebViewController.goBack();
          return false;
        }

        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(Icons.arrow_back_ios_outlined)),
          elevation: 0,
          automaticallyImplyLeading: false,
          title: const Text('FCH Easy Diner'),
          backgroundColor: primaryColor,
          centerTitle: true,
        ),
        body: Stack(
          children: [
            InAppWebView(
              initialUrlRequest: URLRequest(
                  url: Uri.parse("https://1m6m.app.link/j7j8oLQD6Cb/")),
              initialUserScripts: UnmodifiableListView([
                UserScript(source: """
              window.addEventListener('DOMContentLoaded', function(event) {
                var header = document.querySelector('.elementor-location-header'); // use here the correct CSS selector for your use case
                if (header != null) {
                  header.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use header.style.display = 'none';
                }
                var footer = document.querySelector('.elementor-location-footer'); // use here the correct CSS selector for your use case
                if (footer != null) {
                  footer.remove(); // remove the HTML element. Instead, to simply hide the HTML element, use footer.style.display = 'none';
                }
              });
              """, injectionTime: UserScriptInjectionTime.AT_DOCUMENT_START)
              ]),
              onWebViewCreated: (InAppWebViewController controller) {
                inAppWebViewController = controller;
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  _progress = progress / 100;
                });
              },
            ),
            _progress < 1
                ? Container(
                    child: LinearProgressIndicator(
                      value: _progress,
                    ),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
