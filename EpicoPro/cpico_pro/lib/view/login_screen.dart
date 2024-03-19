import 'package:cpico_pro/model/StoreResponse.dart';
import 'package:cpico_pro/utils/ApiHelper.dart';
import 'package:cpico_pro/utils/Utils.dart';
import 'package:cpico_pro/utils/WidgetUtils.dart';
import 'package:cpico_pro/view_model/StoreViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../utils/Status.dart';
import '../view_model/LoginViewModel.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginScreen();
  }
}

class _LoginScreen extends State<LoginScreen> {
  bool isAdmin = true;
  TextEditingController usenameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  List<Stores>? listStores = <Stores>[];
  String selected_store = "Select Store";
  String selected_store_id = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<StoreViewModel>(context, listen: false).getStoreData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Consumer<StoreViewModel>(
          builder: (context, value, child) {
            if (value.status == Status.LOADING) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                WidgetsUtils().showProgress(context);
              });
            } else if (value.status == Status.NO_INTERNET_CONNECTION) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                value.clearStatus();
                WidgetsUtils().hideProgress(context);
              });
            } else if (value.status == Status.ERROR) {
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                value.clearStatus();
                WidgetsUtils().hideProgress(context);
              });
            } else if (value.status == Status.SUCCESS) {
              listStores!.clear();
              if (value.storeModel.data!.length > 0)
                listStores!.addAll(value.storeModel.data![0].stores!);
              WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                value.clearStatus();
                WidgetsUtils().hideProgress(context);
              });
            }
            return Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              color: Colors.brown,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        decoration: TextDecoration.none),
                  ),
                  WidgetsUtils().AddVerticalSpace(30),
                  Container(
                    padding: const EdgeInsets.all(5.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isAdmin = true;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'Admin',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isAdmin ? Colors.white : Colors.black,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none),
                              ),
                              decoration: BoxDecoration(
                                color: isAdmin ? Colors.brown : Colors.white,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                        WidgetsUtils().AddHorizontalSpace(10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isAdmin = false;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.only(top: 10, bottom: 10),
                              child: Text(
                                'Salesman',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        isAdmin ? Colors.black : Colors.white,
                                    fontStyle: FontStyle.normal,
                                    decoration: TextDecoration.none),
                              ),
                              decoration: BoxDecoration(
                                color: isAdmin ? Colors.white : Colors.brown,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  WidgetsUtils().AddVerticalSpace(50),
                  TextField(
                    controller: usenameController,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    decoration: InputDecoration(
                      labelText: 'User Name',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: 'Enter Your Name',
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                  ),
                  WidgetsUtils().AddVerticalSpace(20),
                  TextField(
                    controller: passwordController,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      contentPadding: EdgeInsets.only(left: 15),
                      hintText: 'Enter Password',
                      labelStyle: TextStyle(color: Colors.white),
                      hintStyle: TextStyle(color: Colors.white),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: Colors.white),
                      ),
                    ),
                  ),
                  WidgetsUtils().AddVerticalSpace(20),
                  Visibility(
                    visible: !isAdmin,
                    child: GestureDetector(
                      onTap: () {
                        _showDialog(CupertinoPicker(
                            children: List<Widget>.generate(listStores!.length,
                                (int index) {
                              return Center(
                                child: Text(
                                  listStores![index].title.toString(),
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              );
                            }),
                            magnification: 1.22,
                            squeeze: 1.2,
                            useMagnifier: true,
                            itemExtent: 32,
                            onSelectedItemChanged: (int selectedItem) {
                              setState(() {
                                selected_store =
                                    listStores![selectedItem].title.toString();
                                selected_store_id =
                                    listStores![selectedItem].value.toString();
                              });
                            }));
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                selected_store,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                    decoration: TextDecoration.none),
                              ),
                            ),
                            Icon(Icons.arrow_drop_down_sharp,
                                color: Colors.white)
                          ],
                        ),
                      ),
                    ),
                  ),
                  WidgetsUtils().AddVerticalSpace(30),
                  Consumer<LoginViewModel>(builder: (context, value, child) {
                    if (value.login_status == Status.LOADING) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        WidgetsUtils().showProgress(context);
                      });
                    } else if (value.login_status ==
                        Status.NO_INTERNET_CONNECTION) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        value.clearStatus();
                        WidgetsUtils().hideProgress(context);
                      });
                    } else if (value.login_status == Status.ERROR) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        value.clearStatus();
                        WidgetsUtils().hideProgress(context);
                      });
                    } else if (value.login_status == Status.SUCCESS) {
                      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
                        value.clearStatus();
                        WidgetsUtils().hideProgress(context);

                        Navigator.pushReplacement(context,
                            new MaterialPageRoute(
                          builder: (context) {
                            return HomeScreen();
                          },
                        ));
                      });
                    }
                    return GestureDetector(
                      onTap: () {
                        print("----- click");
                        if (usenameController.text.isEmpty) {
                          WidgetsUtils().showToast('Enter Username');
                        } else if (passwordController.text.isEmpty) {
                          WidgetsUtils().showToast('Enter Password');
                        } else if (!isAdmin && selected_store_id.isEmpty) {
                          WidgetsUtils().showToast('Select Store');
                        } else
                          Provider.of<LoginViewModel>(context, listen: false)
                              .login(
                                  isAdmin ? "Admin" : "Salesman",
                                  "user_name",
                                  "password",
                                  isAdmin ? '' : selected_store_id);
                      },
                      child: Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(top: 15, bottom: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                        child: Center(
                          child: Text(
                            'Submit',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: Colors.black,
                                decoration: TextDecoration.none),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
        context: context,
        builder: (BuildContext context) => Container(
              height: 216,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              color: CupertinoColors.systemBackground.resolveFrom(context),
              child: SafeArea(
                top: false,
                child: child,
              ),
            ));
  }
}
