import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:khial/constant/style.dart';
import 'package:khial/widgets/DefaultTextStyle/defaultextstyle.dart';
import 'package:khial/widgets/defaultbuttomn/defaultbuttomn.dart';
import 'package:khial/widgets/mytextfromfield/my_textfrom_field.dart';
import 'package:khial/widgets/mytoast/mytoast.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  TextEditingController productname = TextEditingController();
  bool mokataa = true;

  List<String> mokataa_text = [
    "يجب مقاطعته",
    "لا يجب مقاطعته",
  ];
  String mokataa_state = "اختر حالة المنتج";

  DatabaseReference databaseReference = FirebaseDatabase.instance.ref();

  void addProduct(String productName, bool mokataa) {
    Map<String, dynamic> mokataaMap = {
      'productname': productName,
      'state': mokataa
    };

    databaseReference.child("products").child(productName).set(mokataaMap);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: maincolor,
        centerTitle: true,
        title: MyDefaultTextStyle(
            text: "اضافة منتجات المفاطعة", height: height * 0.022, bold: true),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: height * 0.2),
                  alignment: Alignment.center,
                  child: MyTextForm(
                    controller: productname,
                    hinttext: "اضف اسم المنتج",
                    height: height * 0.1,
                    width: width * 0.8,
                  ),
                ),
                Container(
                  width: width * 0.9,
                  color: white,
                  margin:
                      EdgeInsets.only(right: width * 0.1, left: width * 0.1),
                  alignment: Alignment.centerRight,
                  child: DropdownButton(
                      dropdownColor: white,
                      alignment: Alignment.centerRight,
                      elevation: 100,
                      focusColor: white,
                      itemHeight: null,
                      isExpanded: true,
                      borderRadius: BorderRadius.circular(10),
                      hint: MyDefaultTextStyle(
                          text: mokataa_state,
                          height: height * 0.018,
                          color: black),
                      items: mokataa_text
                          .map((e) => DropdownMenuItem(
                              value: e,
                              child: MyDefaultTextStyle(
                                  text: e,
                                  height: height * 0.018,
                                  color: black)))
                          .toList(),
                      onChanged: (value) {
                        if (value.toString() == "يجب مقاطعته") {
                          setState(() {
                            mokataa = true;
                            mokataa_state = value.toString();
                            print(mokataa);
                          });
                        } else {
                          setState(() {
                            mokataa = false;
                            mokataa_state = value.toString();
                            print(mokataa);
                          });
                        }
                      }),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Defaultbutton(
                    functon: () {
                      showDialog(
                          context: context,
                          builder: (ctx) {
                            return Dialog(
                              backgroundColor: white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                height: height * 0.25,
                                decoration: BoxDecoration(
                                    color: white,
                                    borderRadius: BorderRadius.circular(15)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: MyDefaultTextStyle(
                                          text: "هل انت متاكد من صحة المعلومات",
                                          height: height * 0.018,
                                          color: black,
                                          bold: true),
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Defaultbutton(
                                            functon: () {
                                              Navigator.pop(context);
                                            },
                                            text: "لا",
                                            height: height * 0.06,
                                            width: width * 0.3,
                                            color: Colors.red,
                                            fontsize: height * 0.018),
                                        SizedBox(
                                          width: width * 0.05,
                                        ),
                                        Defaultbutton(
                                            functon: () {
                                              addProduct(
                                                  productname.text, mokataa);
                                              print(productname.text);
                                              Navigator.pop(context);

                                              showtoast("تم اضافة منتج بنجاح");
                                            },
                                            text: "نعم",
                                            height: height * 0.06,
                                            width: width * 0.3,
                                            color: Colors.green,
                                            fontsize: height * 0.018),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    text: "اضف المنتج",
                    height: height * 0.07,
                    border: 1,
                    width: width * 0.8,
                    color: maincolor)
              ]),
        ),
      ),
    );
  }
}
