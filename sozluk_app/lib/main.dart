
import 'dart:convert';
import 'dart:core';

import 'package:flutter/material.dart';
import 'package:sozluk_app/kelimeDetay.dart';
import 'package:sozluk_app/model.dart';
import 'package:http/http.dart' as http;

void main(){
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Anasayfa(),
    );
  }
}
class Anasayfa extends StatefulWidget {
  const Anasayfa({Key? key}) : super(key: key);

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {

  var tfing = TextEditingController();
  var tftr = TextEditingController();
  var tfarama= TextEditingController();
  var isSearch = false;


  Future <List<Kelime>> kelimeleriGetir() async {
    String url = "http://10.0.2.2:8000/kelime";
    var response = await http.get(Uri.parse(url));
    var decodeVeri = await jsonDecode(response.body);
    var jsonArray = await decodeVeri as List;
    List<Kelime> kelimeListesi = await jsonArray.map((jsonArray) => Kelime.fromJson(jsonArray)).toList();

    return kelimeListesi;
  }
  Future<void> kelimeEkle() async{
    String url = "http://10.0.2.2:8000/kelime";
    Map<String,String> headers = {'Content-Type':'application/json'};
    var veri = jsonEncode({"kelime_ing":tfing.text,"kelime_turkce":tftr.text});
    var response = await http.post(Uri.parse(url),headers: headers, body:veri);

  }
  Future<List<Kelime>> kelimeleriAra() async {
    String URL = "http://10.0.2.2:8000/ara";
    var veri = jsonEncode({'kelime_ing':tfarama.text});
    Map<String,String> headers = {'Content-Type':'application/json'};
    var response = await http.post(Uri.parse(URL),headers:headers, body: veri);
    print(response.headers);
    var decodeVeri = await jsonDecode(response.body);
    print(decodeVeri);
    var jsonArray = await decodeVeri as List;
    List<Kelime> kelimeListesi = await jsonArray.map((jsonArray) => Kelime.fromJson(jsonArray)).toList();
    return kelimeListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          isSearch ? IconButton(
              onPressed: (){
                setState((){
                  isSearch = false;
                });
              },
              icon: Icon(Icons.close)
          ): IconButton(
              onPressed: (){
                setState((){
                  isSearch = true;
                });
              },
              icon: Icon(Icons.search)),
        ],
        title:isSearch ? TextField(
              onChanged: (aramasonucu){
                setState((){
                  tfarama.text = aramasonucu;
                });
              },
              controller: tfarama,
            ) :Text("Sozluk"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tfing,
                decoration: InputDecoration(
                  labelText: "ingilizce",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: tftr,
                decoration: InputDecoration(
                  labelText: "Turkçe",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))
                  )
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: FutureBuilder<List<Kelime>>(
                future: isSearch ? kelimeleriAra() : kelimeleriGetir(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    var data = snapshot.data;
                    return Container(
                      height: double.maxFinite,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          physics : NeverScrollableScrollPhysics(),
                          itemCount: data!.length,
                          itemBuilder: (context,index){
                            var kelime = data[index];
                            return SizedBox(
                              height: 50,
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => KelimeDetay(kelime: kelime)));
                                },
                                child: Card(
                                  color: Colors.orange,
                                  shadowColor: Colors.pink,

                                  elevation: 10.0,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Text("${data[index].kelime_ing}",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          fontFamily: "Arial, Helvetica, sans-serif"
                                      ),),
                                      Text("${data[index].kelime_turkce}",style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                          fontFamily: "Arial, Helvetica, sans-serif",
                                          color: Colors.white
                                      ),),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                      ),
                    );

                  }else{
                    return Center();
                  }
                },
              ),
            )

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
             kelimeEkle();
            setState((){
            });
          },
        child: Icon(Icons.add),
      ),
    );
  }
}
