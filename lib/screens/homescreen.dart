import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class HomeScreen extends StatefulWidget {
 // const HomeScreen({ Key? key }) : super(key: key);
  int q,h;
  HomeScreen(this.q, this.h);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
      int _quantity = 0;
    int _hrs = 0;
   
  // Future<void> getData() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   _quantity = (prefs.getInt('quantity') ?? 0);
  //   _hrs = (prefs.getInt('hours') ?? 0);
  //   print(_hrs.toString()+ " " + _quantity.toString());
    
  // }

  void initState(){
  //  getData();
  _quantity = widget.q;
  _hrs = widget.h;
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  
  @override
  
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height/100;

   double width = MediaQuery.of(context).size.width/100;
   
   
   // print(SizeConfig().blockSizeHorizontal);
    //  double height = SizeConfig().blockSizeVertical;
    //  double width = SizeConfig().blockSizeHorizontal;
    print(height.toString() +" "+ width.toString());
    return SafeArea(
          child: Scaffold(
        body: Container(
          alignment: Alignment(0.0, -0.56),
          height: height * 100,
          width: width * 100,
          decoration: BoxDecoration(
            
            gradient: LinearGradient(colors: [
             const Color(0xFFD9EBEB),
              const Color(0xFFC0C9CD),
              const Color(0xFF09A4EB)
            ],
            begin: Alignment(0.79, 0.48),
            end: Alignment(-1.0, -0.68),
            stops: [0.0, 0.067, 1.0],),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 10,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Color.fromRGBO(217, 235, 235, 1),
                ),
                height: height *36.5,
                width: width * 85,
                
                child: Form(
                  key: _formKey,
                  child: Padding(
                  padding: EdgeInsets.all(height * 2.5),
                  child: Column(
                   crossAxisAlignment: CrossAxisAlignment.start,
                  
                    children: [
                        Text(
                    'Time Interval',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: height * 2.8,
                      color: const Color(0xFF707070),
                    ),),
                    SizedBox(height: height * 1,),
                    TextFormField(
                      initialValue: _hrs.toString(),
                       keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        
                        suffix: Text("hrs"),
                      ),
                      validator: (quantity){
                        if(quantity == null){
                          return "This field can not be empty";
                        }
                      },
                      onSaved: (quantity){
                        _hrs = int.parse(quantity!);
                      },
                    ),
                    SizedBox(height: height ,),
                    Text(
                    'Quantity',
                    style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: height * 2.8,
                      color: const Color(0xFF707070),
                    ),),
                    SizedBox(height: height * 1,),
                     TextFormField(
                       initialValue: _quantity.toString(),
                       keyboardType: TextInputType.numberWithOptions(signed: false, decimal: false),
                      decoration: InputDecoration(
                        hintText: "Enter the quantity u will drink everyday.",
                        suffix: Text("l/day"),
                        border: OutlineInputBorder(),
                      ),
                      validator: (quantity){
                        if(quantity == null){
                          return "This field can not be empty";
                        }
                      },
                      onSaved: (quantity){
                        _quantity = int.parse(quantity!);
                      },
                    ),
                     SizedBox(height: height  * 1.3),
                    Center(
                      child: ElevatedButton(onPressed: () async {
                         if(_formKey.currentState!.validate()){
                            _formKey.currentState!.save();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            await prefs.setInt('quantity', _quantity);
                            await prefs.setInt('hours', _hrs);
                            print("Notification after" + (_quantity/(24/_hrs)).toStringAsPrecision(2) + "hrs");
                         }

                      }, 
                      child: Text("Set Goal"),),
                    )
                    ],
                  ),
                )),
              ),
              SizedBox(height:height * 4),
              
              
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Color.fromRGBO(217, 235, 235, 1),
                ),
                height: height * 20,
                width: width * 85,
                child: Padding(
                  padding: EdgeInsets.all(height * 2.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text(
                      'Stats',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: height * 3.5,
                        color: const Color(0xFF707070),
                      ),),

                      SizedBox(height: height * 2,),
                            Text(
                      'Water Drunk: 23.46L',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: height * 2.3,
                        color: const Color(0xFF707070),
                      ),),

                      SizedBox(height: height * 1,),

      Text(
                      'Drinking Rate: 1.78L/DAY',
                      style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: height * 2.3,
                        color: const Color(0xFF707070),
                      ),),

                      




                  ],),
                ),),

                SizedBox(height: height * 3,),

                Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    color: Color.fromRGBO(217, 235, 235, 1),
                ),
                height: height * 3,
                width: width * 85,
                child: Text("  Next time to drink: 11:23 pm", 
                 style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize: height * 2.3,
                      color: Colors.red,
                    ),),),

                SizedBox(height: height * 3,),

                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Colors.redAccent
                  ),
                  height: height * 8.5,
                  width: width * 70,
                  child: Center(child: Text("RESET DATA", style: TextStyle(
                        fontFamily: 'Segoe UI',
                        fontSize: height * 4,
                        color: const Color(0xFFFFFFFF),
                      )),
                  ),),
                ),
                

            ],
          ),
        )
        
      ),
    );
  }
}