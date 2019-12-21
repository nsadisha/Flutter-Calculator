import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import "package:math_expressions/math_expressions.dart";

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark
      )
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Calculator",
        theme: ThemeData(
            splashColor: Color.fromRGBO(51, 173, 255, 0.3),
            highlightColor: Color.fromRGBO(51, 173, 255, 0.1),
        ),
    home: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: _cal()
    )
    );
  }
}

class _cal extends StatefulWidget {
  @override
  __calState createState() => __calState();
}

class __calState extends State<_cal> {
  ScrollController sc = ScrollController();
  String inText = "";
  String disText = "";
  String answer = "";
  

  void _backSpace(){
    setState(() {
      bool br = false;
      if(inText.length ==1){
        disText = "";
        inText = "";
        answer = "";
      }else {

        inText = inText.substring(0, inText.length - 1);
        disText = disText.substring(0, disText.length - 1);

        if(inText.endsWith(")")){
          br = true;
        }else if(inText.endsWith("(")){
          br = false;
        }
        if(!(inText.endsWith("+") || inText.endsWith("-") || inText.endsWith("*") || inText.endsWith("/")) && br!=true) {
            _calculate();
//          else if((inText.endsWith("1") || inText.endsWith("2") || inText.endsWith("3") || inText.endsWith("4") || inText.endsWith("5") ||
//              inText.endsWith("6") || inText.endsWith("7") || inText.endsWith("8") || inText.endsWith("9") || inText.endsWith("0"))&& br==true){
//            _calculate();
//          }
        }
      }
    });
  }

   _calculate(){
      ContextModel xx = ContextModel();
      Parser p = Parser();
      Expression exp = p.parse(inText);
      exp.simplify();
      double x = exp.evaluate(EvaluationType.REAL,xx);
      if(x.toString().endsWith("0")){
        answer = x.toInt().toString();
      }else{
        answer = num.parse(x.toStringAsFixed(10)).toString();
      }
  }

  void _printCharactor(String charactor){
    setState(() {
      if(charactor =="("){
        if(inText.endsWith("+") || inText.endsWith("-") || inText.endsWith("*") || inText.endsWith("(") || inText == ""){
          inText+= charactor;
          disText+= charactor;
        }else{
          inText= inText+"*"+ charactor;
          disText = disText+ "×" + charactor;
        }

      }
      else if(charactor =="+"){
        if(!inText.endsWith("+") && inText !="" && inText != "-"){
          if(inText.endsWith("-") || inText.endsWith("*") || inText.endsWith("/")){
            inText = inText.substring(0, inText.length - 1);
            disText = disText.substring(0, disText.length - 1);
          }
          if(inText.endsWith(".")){
            inText +="0";
            disText +="0";
          }
          disText+=charactor;
          inText+=charactor;
        }
      }else if(charactor =="/"){
        if(!inText.endsWith("/") && inText !="" && inText != "-"){
          if(inText.endsWith("-") || inText.endsWith("*") || inText.endsWith("+")){
            inText = inText.substring(0, inText.length - 1);
            disText = disText.substring(0, disText.length - 1);
          }
          if(inText.endsWith(".")){
            inText +="0";
            disText +="0";
          }
          inText+=charactor;
          disText = disText + "÷";
        }
      }else if(charactor =="*"){
        if(!inText.endsWith("*") && inText !="" && inText != "-"){
          if(inText.endsWith("-") || inText.endsWith("+") || inText.endsWith("/")){
            inText = inText.substring(0, inText.length - 1);
            disText = disText.substring(0, disText.length - 1);
          }
          if(inText.endsWith(".")){
            inText +="0";
            disText +="0";
          }
          inText+=charactor;
          disText+="×";
        }
      }else if(charactor =="-"){
        if(!inText.endsWith("-")){
          if(inText.endsWith("+") || inText.endsWith("*") || inText.endsWith("/")){
            inText = inText.substring(0, inText.length - 1);
            disText = disText.substring(0, disText.length - 1);
          }
          if(inText.endsWith(".")){
            inText +="0";
            disText +="0";
          }
          inText+=charactor;
          disText+=charactor;
        }
      }else if(charactor == "1"||charactor == "2"||charactor == "3"||charactor == "4"||charactor == "5"||charactor == "6"||
               charactor == "7"||charactor == "8"||charactor == "9"||charactor == "0"||charactor =="00"||charactor == "."){
        if(charactor =="0"||charactor=="00"){
          if(charactor=="0"){
            if(inText !="0") {
              inText += charactor;
              disText+=charactor;
            }
          }else if(charactor =="00"){
            if(inText =="0") {

            }else if(inText == ""){
              inText +="0";
              disText +="0";
            }else{
              inText += charactor;
              disText += charactor;
            }
          }
        }else if(charactor =="."){
        if((charactor =="." && inText =="")||inText.endsWith("+")||inText.endsWith("-")||inText.endsWith("*")||inText.endsWith("/")){
          inText = inText+"0"+charactor;
          disText = disText+"0"+charactor;
        }
        else if(!inText.endsWith(".")){
          inText += charactor;
          disText += charactor;
        }
        }else{
          if(inText.endsWith(")")){
            inText += "*"+charactor;
            disText += "×"+charactor;
          }else{
            inText += charactor;
            disText += charactor;
          }
        }
//        if(!(inText.endsWith("+") || inText.endsWith("-") || inText.endsWith("*") ||
//            inText.endsWith("/") || inText.endsWith("(") || inText.endsWith(")"))) {
//          _calculate();
//        }
      }else if(charactor ==")" && inText !="") {
        inText += charactor;
        disText += charactor;

//        if (!(inText.endsWith("+") || inText.endsWith("-") ||
//            inText.endsWith("*") || inText.endsWith("/"))) {
//          _calculate();
//        }
      }
    });
    _calculate();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double fontSize = width*0.12;
    var fontWeight = FontWeight.w300;
    var font = "";
    var fontColor = Color.fromRGBO(0, 0, 0, 0.6);
    var borderColor = Color.fromRGBO(0, 0, 0, 0.3);
    double conHeight = height*0.55;

    return Column(
        children: <Widget>[
          Container(
              width: width,
              height: height*0.06,
              color: Colors.white),
          Container(
            //text
              width: width,
              height: height*0.2,
              color:Colors.white,
              child: ListView(
                controller: sc,
                physics: ScrollPhysics(),
                padding: EdgeInsets.all(0),
                children: <Widget>[
                  Wrap(
                    children: <Widget>[
                      Text(
                        disText,
                        textDirection: TextDirection.ltr,
                        style: TextStyle(fontFamily: font,
                          color:Colors.black,
                          fontWeight: fontWeight,
                          fontSize: fontSize+4,),
                      )
                    ],
                  )
                ],
              )
          ),
          Container(
            //answer
              padding:EdgeInsets.only(top:height*0.02),
              width: width,
              height: height*0.11,
              color:Colors.white,
              child: Text(
                  answer.toString(),
                  textDirection: TextDirection.ltr,
                  style: TextStyle(fontFamily: font,
                    color:Colors.lightBlueAccent,
                    fontWeight: fontWeight,
                    fontSize: fontSize-6,)
              )
          ),
          Container(
              width: width,
              height: height*0.08,
              padding: EdgeInsets.only(left: width*0.75),
              color:Colors.white,
              child: FlatButton(
                  child: Icon(
                      Icons.backspace,
                      color: fontColor),
                  onPressed: (){
                    _backSpace();
                  }
              )
          ),
          Container(
            width: width,
            height: conHeight,
            child: Column(
              children: <Widget>[

                Row(
                  children: <Widget>[
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0.5,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "C",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:Colors.redAccent,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              setState(() {
                                inText = "";
                                answer = "";
                                disText = "";
                              });
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0.5,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "(",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:Colors.blueAccent,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("(");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0.5,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                ")",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:Colors.blueAccent,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor(")");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0.5,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "÷",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:Colors.blueAccent,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("/");
                            }
                        )
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "7",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("7");
                            },
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "8",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("8");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "9",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("9");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "×",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:Colors.blueAccent,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("*");
                            }
                        )
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "4",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("4");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "5",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("5");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "6",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("6");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "-",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:Colors.blueAccent,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("-");
                            }
                        )
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "1",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("1");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "2",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("2");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "3",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("3");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "+",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:Colors.blueAccent,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("+");
                            }
                        )
                    ),
                  ],
                ),

                Row(
                  children: <Widget>[
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "00",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("00");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "0",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor("0");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0.5,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                ".",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:fontColor,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              _printCharactor(".");
                            }
                        )
                    ),
                    Container(
                        width: width*0.25,
                        height:conHeight*0.2,
                        //color: Colors.white,
                        decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            border: Border(
                              top: BorderSide(width: 0,color: borderColor),
                              bottom: BorderSide(width: 0.5,color: borderColor),
                              left: BorderSide(width: 0,color: borderColor),
                              right: BorderSide(width: 0,color: borderColor),
                            )
                        ),
                        child: FlatButton(
                            child: Text(
                                "=",
                                style: TextStyle(
                                  fontSize: fontSize,
                                  fontWeight: fontWeight,
                                  color:Colors.white,
                                  fontFamily: font,
                                )
                            ),
                            onPressed: (){
                              setState(() {
                                disText = answer;
                                inText = answer;
                                answer = "";
                              });
                            }
                        )
                    ),
                  ],
                ),


              ],
            ),
          ),
        ]
    );
  }
}