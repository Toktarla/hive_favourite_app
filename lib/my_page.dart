import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jsonfetchdata/state_controller.dart';
import 'package:provider/provider.dart';

class MyPage extends StatelessWidget {
  const MyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controllerVariables = Provider.of<StateController>(context);
    var controllerMethods = Provider.of<StateController>(context,listen: false);
    final isValid = Hive.box('favourite').get(controllerVariables.indexOfNoun)!=null;



    return SafeArea(
      child: Scaffold(
        body: Center(child: Text(
          isValid ? Hive.box('favourite').get(controllerVariables.indexOfNoun) : 'It is not favourite',






        ),
      ),
    ));
  }
}
