import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:mobility/Components/Buttons/PrimaryButton.dart';
import 'package:mobility/Components/Buttons/RoundedRadioButton.dart';
import 'package:mobility/Components/Loading/LoadingSpinner.dart';
import 'package:mobility/MainApp/MainAuthScreen.dart';
import 'package:mobility/MainApp/PerformanceScreen.dart';
import 'package:mobility/NodeApi/NodeApi.dart';
import 'package:mobility/constants/constants.dart';

class CalculationScreen extends StatefulWidget {
  const CalculationScreen({super.key});

  @override
  State<CalculationScreen> createState() => _CalculationScreenState();
}

class _CalculationScreenState extends State<CalculationScreen> {
  int _selectedMean = 0;
  double _sliderValue = 0;
  double coeff = 16.67;
  bool isLoading = false;
  TextEditingController dateCtrl = TextEditingController(text: "");

  addDistance() async {
    var data = {
      "userId": FirebaseAuth.instance.currentUser!.uid,
      "travel": {
        "km": _sliderValue.toStringAsFixed(0),
        "mean": _selectedMean,
        "points": (_sliderValue * coeff).toStringAsFixed(0),
        "date": dateCtrl.text
      }
    };
    if (_sliderValue == 0 || _selectedMean == 0) {
      //return null;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "Please select the mean of transport and the distance you've travelee")));
      return;
    }
    var response = await NodeApi.addDistance(data);
    if (mounted) {

      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                shape:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                backgroundColor: kPrimaryColor.withOpacity(1),
                content: SizedBox(
                  height: 300,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You've Traveled ${_sliderValue.toStringAsFixed(0)} KM",
                        style: const TextStyle(
                            color: CupertinoColors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "You've Earned",
                        style: TextStyle(
                            color: CupertinoColors.white, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Text(
                        "${(_sliderValue * 16.67).toStringAsFixed(0)} points",
                        style: const TextStyle(
                            color: CupertinoColors.systemRed,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      PrimaryButton(
                          label: "My Performance",
                          onClick: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainAuthScreen(
                                          current: const PerformanceScreen(),
                                        )));
                          },
                          color: Colors.redAccent)
                    ],
                  ),
                ),
              ));
    }

  }

  setMean(int index) {
    setState(() {
      _selectedMean = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DateTime dateTime = DateTime.now();

    String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);
    setState(() {
      dateCtrl = TextEditingController(text: formattedDate);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Select Date: ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  if (pickedDate != null) {
                    DateTime dateTime = DateTime(
                      pickedDate.year,
                      pickedDate.month,
                      pickedDate.day,
                    );

                    String formattedDateTime =
                        DateFormat('MMM d,yyyy').format(dateTime);
                    setState(() {
                      dateCtrl = TextEditingController(text: formattedDateTime);
                    });
                    // dateCtrl.text = formattedDateTime;
                    print(dateCtrl.text);
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.white12)),
                  child: Text(
                    "${dateCtrl.text}",
                    style: TextStyle(color: Colors.white70, fontSize: 13),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Choose Your Mean of Transport: ",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RoundedRadioButton(
                      setMean: setMean,
                      icon: CupertinoIcons.car_detailed,
                      index: 1,
                      selectedMean: _selectedMean),
                  RoundedRadioButton(
                      setMean: setMean,
                      icon: FontAwesomeIcons.bicycle,
                      index: 2,
                      selectedMean: _selectedMean),
                  RoundedRadioButton(
                      setMean: setMean,
                      icon: Icons.directions_walk,
                      index: 3,
                      selectedMean: _selectedMean),
                  RoundedRadioButton(
                      setMean: setMean,
                      icon: CupertinoIcons.bus,
                      index: 4,
                      selectedMean: _selectedMean),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 35,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "How Far Did You Travel Today?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                children: [
                  Center(
                      child: Text(
                    "${_sliderValue.toStringAsFixed(0)} KM",
                    style:
                        TextStyle(fontSize: 40, color: CupertinoColors.white),
                  )),
                  Slider(
                      activeColor: Colors.redAccent,
                      overlayColor:
                          MaterialStateProperty.all(CupertinoColors.white),
                      inactiveColor: CupertinoColors.white,
                      thumbColor: CupertinoColors.white,
                      value: _sliderValue,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      label: _sliderValue.toStringAsFixed(0),
                      onChanged: (double value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      })
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Your Points:",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  isLoading
                      ? const LoadingSpinner()
                      : PrimaryButton(
                          label: "CALCULATE",
                          onClick: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await addDistance();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          color: Colors.redAccent)
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
