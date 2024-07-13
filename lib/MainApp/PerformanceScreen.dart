import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mobility/Components/Buttons/PrimaryButton.dart';
import 'package:mobility/Components/Buttons/RoundedRadioButton.dart';
import 'package:mobility/Components/Cards/PerformanceCard.dart';
import 'package:mobility/Components/Loading/CustomLoader.dart';
import 'package:mobility/NodeApi/NodeApi.dart';
import 'package:mobility/constants/constants.dart';
import 'package:shimmer/shimmer.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {

  bool _isLoading=true;
  late Map<String,dynamic> data={};
  double kms=0;
  double points=0;

  setData()async{
    data=await NodeApi.getUserData(FirebaseAuth.instance.currentUser!.uid);
    if(data["travels"]!=null){
      data["travels"].forEach((d) {
        setState(() {
          kms+=int.parse(d["km"]);
          points+=int.parse(d["points"]);
        });
      });
    }


    setState(() {
      _isLoading=false;
    });
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }
  @override
  Widget build(BuildContext context) {
    return _isLoading? SizedBox(
      width: 200.0,
      height: 100.0,
      child: CustomLoader()
    ): Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.redAccent, borderRadius: BorderRadius.circular(14)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Text(
                    points.toStringAsFixed(0),
                    style:
                        TextStyle(color: CupertinoColors.white, fontSize: 32),
                  ),
                  const Text(
                    "Points",
                    style:
                        TextStyle(color: CupertinoColors.white, fontSize: 13),
                  )
                ],
              ),
              const Icon(
                CupertinoIcons.cursor_rays,
                color: CupertinoColors.white,
                size: 30,
              )
            ],
          ),
        ),
        const SizedBox(height: 20,),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: CupertinoColors.inactiveGray, borderRadius: BorderRadius.circular(14)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Icon(Icons.query_stats,color: CupertinoColors.white,size: 30,),
                    const  SizedBox(height: 5,),
                    const  Text(
                      "The Distance You Traveled",
                      style:
                      TextStyle(color: CupertinoColors.white, fontSize: 13),
                    ),
                    const SizedBox(height: 5,),

                    Text(
                      "${kms.toStringAsFixed(0)} KM",
                      style:
                      const TextStyle(color: CupertinoColors.white, fontSize: 25),
                    ),

                  ],
                )
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 40,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children:   [
            const   Text(
              "Performance by Mean of Transport",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            PerformanceCard(mean: 1,icon: CupertinoIcons.car_detailed,travels: data["travels"] ?? []),
            PerformanceCard(mean: 2,icon: FontAwesomeIcons.bicycle,travels: data["travels"] ?? []),
            PerformanceCard(mean: 3,icon: Icons.directions_walk,travels: data["travels"] ?? []),
            PerformanceCard(mean: 4,icon: CupertinoIcons.bus,travels: data["travels"] ?? []),
          ],
        ),

      ],
    );
  }
}
