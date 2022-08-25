
import 'package:flutter/material.dart';
import 'package:sozluk_app/model.dart';
class KelimeDetay extends StatefulWidget {

  late Kelime kelime;


  KelimeDetay({required this.kelime});

  @override
  State<KelimeDetay> createState() => _KelimeDetayState();
}

class _KelimeDetayState extends State<KelimeDetay> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detay"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text("${widget.kelime.kelime_ing}",style: TextStyle(fontSize: 22.2,color:Colors.pink,fontWeight: FontWeight.bold),),
            Text("${widget.kelime.kelime_turkce}",style: TextStyle(fontSize: 22.2,fontWeight: FontWeight.bold,color: Colors.blue),)
          ],
        ),
      ),
    );
  }
}
