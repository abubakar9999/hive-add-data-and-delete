import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  final appderocctory= await getApplicationSupportDirectory();
  Hive.init(appderocctory.path);
Box box=await  Hive.openBox("StudentBox");
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home:  HomePage(),
    );
  }
}
class HomePage extends StatefulWidget {
   HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Box ?box;
  @override
  void initState() { 
    box=Hive.box("StudentBox");
    super.initState();
    
  }
  getData(){
    

    box!.add(_controller.text.toString());
   
  }

 TextEditingController _controller =TextEditingController();
            int ?index;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: ListView.builder(
                itemCount: box!.keys.length,
                itemBuilder: (context,index)=>Card(child:
                 Text("${box!.getAt(index)}"),))
            ),



            TextField(
              controller: _controller,
            ),
            ElevatedButton(onPressed: (){
              setState(() {
              getData();
             
              });
         
              

            }, child: Text("submit")),
            ElevatedButton(onPressed: (){
          setState(() {
               box!.deleteAt(box!.keys.toList().length-1);
                           
                          
          });
            }, child: Text("delete"))
          ],
        ),
      ),

    );
  }
}
