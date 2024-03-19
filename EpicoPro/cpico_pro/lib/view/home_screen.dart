import 'package:cpico_pro/utils/WidgetUtils.dart';
import 'package:cpico_pro/view/login_screen.dart';
import 'package:cpico_pro/view/scan_qr_screen.dart';
import 'package:cpico_pro/view_model/ProductSearchLinkViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../utils/Status.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen> {
  var controller = WebViewController();

  @override
  void initState() {
    super.initState();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
          print('-------- progress : ' + progress.toString());
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
          if (request.url.startsWith('https://www.youtube.com/')) {
            return NavigationDecision.prevent;
          }
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductSearchLinkViewModel>(
        builder: (context, value, child) {
          if (value.login_status == Status.LOADING) {
            value.clearStatus();
          } else if (value.login_status == Status.NO_INTERNET_CONNECTION) {
            value.clearStatus();
          } else if (value.login_status == Status.ERROR) {
            value.clearStatus();
          } else if (value.login_status == Status.LOGOUT) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              value.clearStatus();
              Navigator.pushAndRemoveUntil(context, new MaterialPageRoute(
                builder: (context) {
                  return LoginScreen();
                },
              ), (route) => false);
            });
          } else if (value.login_status == Status.SUCCESS) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              value.clearStatus();
              loadUrl(value.productLink);
            });
          }
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                WidgetsUtils().AddVerticalSpace(20),
                GestureDetector(
                  onTap: () async {
                    final Permission _permission = Permission.camera;
                    final status = await _permission.status;
                    if (status.isGranted)
                      await Navigator.push(context, new MaterialPageRoute(
                        builder: (context) {
                          return ScanQrScreen();
                        },
                      )).then((value) => {
                            WidgetsBinding.instance
                                .addPostFrameCallback((timeStamp) {
                              Provider.of<ProductSearchLinkViewModel>(context,
                                      listen: false)
                                  .getProductLink(value.toString());
                            })
                          });
                    else
                      await _permission.request();
                  },
                  child: Container(
                      margin: EdgeInsets.only(left: 30, right: 30, top: 30),
                      width: double.maxFinite,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      decoration: BoxDecoration(
                          color: Colors.brown,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.qr_code,
                              color: Colors.white,
                              size: 25,
                            ),
                            WidgetsUtils().AddHorizontalSpace(10),
                            Text(
                              'Scan Product',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  color: Colors.white,
                                  decoration: TextDecoration.none),
                            )
                          ])),
                ),
                WidgetsUtils().AddVerticalSpace(10),
                Visibility(
                  visible: value.productLink.length > 0,
                  child: Expanded(
                    child: Stack(
                      children: [
                        Center(
                            child: CircularProgressIndicator(
                                strokeWidth: 2, semanticsLabel: 'Appp')),
                        WebViewWidget(controller: controller)
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  loadUrl(value) {
    print('----- value : ' + value);
    controller.loadRequest(Uri.parse(value));
  }
}
