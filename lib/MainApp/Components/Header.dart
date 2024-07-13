import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobility/Auth/FireBaseUtils.dart';
import 'package:mobility/Landing/MainScreen.dart';

class Header extends StatefulWidget {
  const Header({super.key});

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late User? _user;
  bool isLoading=true;
  getUser()async{
    _user= await FireBaseUtils.verifyAuth();
    print(_user!.uid);
    setState(() {
      isLoading=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
  @override
  Widget build(BuildContext context) {
    return isLoading ? const Text("loading") :  Container(
      height: 100,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Welcome back",
                style: TextStyle(color: CupertinoColors.white),
              ),
               Text(
                "${_user!.displayName}",
                style: TextStyle(
                    color: CupertinoColors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 7,
              ),
              Row(
                children: const [
                  Icon(
                    Icons.workspace_premium,
                    color: CupertinoColors.white,
                    size: 12,
                  ),
                  Text(
                    "Premium",
                    style:
                        TextStyle(color: CupertinoColors.white, fontSize: 12),
                  ),
                ],
              )
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: ()async{
                  await FireBaseUtils.logout();
                  if(mounted){
                    Navigator.pushReplacementNamed(context, MainScreen.id);
                  }
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.red,
                  backgroundImage: NetworkImage(_user!.photoURL.toString()),

                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
