import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jsonfetchdata/state_controller.dart';
import 'package:provider/provider.dart';

import 'my_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controllerVariables = Provider.of<StateController>(context);
    var controllerMethods = Provider.of<StateController>(context,listen: false);
    final words = nouns.take(5).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite App'),
      ),

      body: Column(
        children: [
          Expanded(
            child: ValueListenableBuilder(
                valueListenable: Hive.box('favourite').listenable(),
                builder: (context, box, child) {
                  return ListView.builder(
                      itemCount: words.length,
                      itemBuilder: (context, index) {
                        final word = words[index];
                        final isFavourite = box.get(index)!=null;
                        return ListTile(
                          title: Text(word),
                          trailing: IconButton(
                            onPressed: () async{
                              ScaffoldMessenger.of(context).clearSnackBars();
                              if(isFavourite) {
                                await box.delete(index);
                                const snackBar = SnackBar(content: Text('Removed Succesfully',),backgroundColor: Colors.redAccent,);ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              }
                              else{

                                await box.put(index,word);
                                controllerMethods.someFunc(index);
                                const snackBar = SnackBar(content: Text('Added Succesfully'),backgroundColor: Colors.green,);
                                

                                ScaffoldMessenger.of(context).showSnackBar(snackBar);


                              }



                            },
                            icon: Icon(
                              isFavourite ? Icons.favorite : Icons.favorite_border,
                              color: Colors.red,
                            ),
                          ),
                        );
                      });
                }),
          ),
          RawMaterialButton(
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder: (BuildContext context) => MyPage()));

            },


            shape:CircleBorder(),
            child: Container(child: Text("Another Page"),color: Colors.green,),

          )

        ],
      ),
    );
  }
}
