import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:units_converter/units_converter.dart';

void main() {
  runApp(Application());
}

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  _ApplicationState createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  int Current_Height = 160;
  int Current_Weight = 80;

  int Current_Index = 0;

  String? Final_Result;
  String? Final_BMI_Result;
  Color Final_BMI_Result_Color = Colors.green;

  @override
  Widget build(BuildContext context) {
    Calculate_BMI();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.black,
          title: Text(
            "BMI Calculator",
          ),
          elevation: 1,
          shadowColor: Colors.blue,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Radio_Button("Man", Colors.blue, 0),
                      Radio_Button("Woman", Colors.pink, 1)
                    ],
                  ),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Your Height (cm)",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                            NumberPicker(
                              minValue: 30,
                              maxValue: 600,
                              value: Current_Height,
                              onChanged: (int Value) {
                                setState(() {
                                  Current_Height = Value;
                                });
                                Calculate_BMI();
                                Check_BMI();
                              },
                              textStyle: TextStyle(color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              "Your Weight (kg)",
                              style:
                                  TextStyle(color: Colors.blue, fontSize: 18),
                            ),
                            NumberPicker(
                              minValue: 30,
                              maxValue: 200,
                              value: Current_Weight,
                              textStyle: TextStyle(color: Colors.red),
                              onChanged: (int Value) {
                                setState(() {
                                  Current_Weight = Value;
                                });
                                Calculate_BMI();
                                Check_BMI();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Your BMI Is : $Final_Result",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Final_BMI_Result_Color),
                    ),
                  ),
                  SizedBox(height: 50),
                  Container(
                    width: double.infinity,
                    child: Text(
                      "Your BMI Res Is : $Final_BMI_Result",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Final_BMI_Result_Color,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 46,
                  ),
                  Center(
                    child: Text(
                      "Created By Aryan Shaw",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        foreground: Paint()
                          ..shader = LinearGradient(
                            colors: <Color>[
                              Colors.pinkAccent,
                              Colors.deepPurpleAccent,
                              Colors.red,
                              Colors.blue,
                              Colors.amber,
                            ],
                          ).createShader(
                            Rect.fromLTWH(
                              0.0,
                              0.0,
                              366.0,
                              100.0,
                            ),
                          ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void Calculate_BMI() {
    double Double_Height_Data = double.parse(Current_Height.toString());
    var Simple_Height = Length()
      ..convert(LENGTH.centimeters, Double_Height_Data);
    var Height_Meter = Simple_Height.meters;
    double Double_Height = double.parse(Height_Meter.value.toString());
    double Result = Current_Weight / (Double_Height * Double_Height);

    if (Current_Index == 0) {
      Result += 0.78;
    }

    String BMI = Result.toStringAsFixed(2);
    setState(() {
      Final_Result = BMI;
    });
  }

  void Check_BMI() {
    double BMI_Double = double.parse(Final_Result.toString());
    if (BMI_Double < 18.5) {
      setState(() {
        Final_BMI_Result = "Underweight";
        Final_BMI_Result_Color = Colors.blue;
      });
    } else if (BMI_Double >= 18.5 && BMI_Double <= 24.9) {
      setState(() {
        Final_BMI_Result = "Proper weight";
        Final_BMI_Result_Color = Colors.green;
      });
    } else if (BMI_Double >= 25 && BMI_Double <= 29.9) {
      setState(() {
        Final_BMI_Result = "Overweight";
        Final_BMI_Result_Color = Colors.red;
      });
    } else {
      setState(() {
        Final_BMI_Result = "Obesity";
        Final_BMI_Result_Color = Colors.red;
      });
    }
  }

  void Change_Index(int Index) {
    setState(() {
      Current_Index = Index;
    });
  }

  Widget Radio_Button(String value, Color color, int index) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 12.0),
        height: 80,
        child: FlatButton(
          color: Current_Index == index ? color : Colors.grey[200],
          child: Text(
            value,
            style: TextStyle(
              color: Current_Index == index ? Colors.white : color,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          onPressed: () {
            Change_Index(index);
            Check_BMI();
            Calculate_BMI();
          },
        ),
      ),
    );
  }
}
