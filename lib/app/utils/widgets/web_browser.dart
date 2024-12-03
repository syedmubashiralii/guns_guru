import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guns_guru/app/utils/app_colors.dart';
import 'package:guns_guru/app/utils/dialogs/loading_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebBrowser extends StatelessWidget {
  WebBrowser({super.key, required this.initialUrl});

  String initialUrl;
  WebViewController? webViewController;
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    webViewController = WebViewController();
    webViewController?.setNavigationDelegate(NavigationDelegate(
      onPageStarted: (val) => Get.dialog(const LoadingDialog()),
      onPageFinished: (val) {
        if(Get.isDialogOpen??false){
          Get.back();
        }
      },
    ));
    webViewController?.setJavaScriptMode(JavaScriptMode.unrestricted);
    webViewController?.setBackgroundColor(const Color(0x00000000));
    webViewController?.loadRequest(Uri.parse(initialUrl));
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          color: Colors.white,
          width: Get.width,
          height: Get.height,
          child: Stack(
            children: [
              WebViewWidget(
                controller: webViewController!,
              ),
              Positioned(
                top: 50,
                left: 10,
                child: Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    color: ColorHelper.primaryColor
                  ),
                  child: IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 15,),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
