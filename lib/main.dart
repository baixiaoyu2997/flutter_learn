import "dart:convert";
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


main() => runApp(SampleApp());

class SampleApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      title:'Sample App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home:SampleAppPage(),
    );
  }
}
class SampleAppPage extends StatefulWidget{
  SampleAppPage({Key key}):super(key:key);
  @override
  _SampleAppPageState createState()=>_SampleAppPageState();
}
class _SampleAppPageState extends State<SampleAppPage>{
  List widgets=[];
  @override
  void initState() {
    super.initState();
    loadData();
  }
  getListView(){
    return  ListView.builder(
        itemCount:widgets.length,
        itemBuilder:(BuildContext context,int position){
          return getRow(position);
        }
      );
  }
  getProgressDialog(){
    return Center(child:CircularProgressIndicator());
  }
  getBody(){
    if(widgets.length==0){
      return getProgressDialog();
    }else {
      return getListView();
    }
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar:AppBar(
        title:Text('Sample App')
      ),
      body: getBody()
    );
  }
  Widget getRow(int i){
    return Padding(
      padding:EdgeInsets.all(10.0),
      child:Text("Row ${widgets[i]["title"]}")
    );
  }
  loadData() async{
    String dataURL="https://jsonplaceholder.typicode.com/posts";
    http.Response response=await http.get(dataURL);
    setState(() {
      widgets=json.decode(response.body);
    });
  }
}