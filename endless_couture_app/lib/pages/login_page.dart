import 'package:endless_couture_app/pages/home_page2.dart';
import 'package:endless_couture_app/pages/info_page.dart';
import 'package:endless_couture_app/widgets/my_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:animate_gradient/animate_gradient.dart';


class LogingPage extends StatelessWidget {
  const LogingPage({super.key});

  Future<void> main() async {}
  

  @override
  Widget build(BuildContext context) {
    final double aspectRatio = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    
    return  Material(
      child:
      Builder(
        builder: (context) {
          
          return AnimateGradient(
            
            primaryBeginGeometry:  const AlignmentDirectional(0, 1),
            primaryEndGeometry: const AlignmentDirectional(0, 2),
            secondaryBeginGeometry: const AlignmentDirectional(2, 0),
            secondaryEndGeometry: const AlignmentDirectional(0, -0.8),
            primaryColors: const
            [
              Color.fromRGBO(224, 94, 113, 1),
              Color.fromRGBO(224, 134, 94, 1),
              Color.fromRGBO(224, 111, 94, 1),
            ],
            secondaryColors: const
            [
              Color.fromRGBO(224, 94, 191, 1),
              Color.fromRGBO(224, 157, 94, 1),
              Color.fromRGBO(224, 176, 169,1),
            ],
            
            child:   Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
               const Hero(
                tag: "titulo",
                 child: Text(
                   "Endless Couture",
                    style: TextStyle(
                     decoration: TextDecoration.none,
                     color: Colors.black,
                     fontSize: 40,
                     fontFamily: "Custom",
                     fontWeight: FontWeight.w500
                     ),
                   ),
               ),
                 const Padding(
                   padding: EdgeInsets.fromLTRB(50,5,50,5),
                   child: TextField(
                    decoration: InputDecoration(
                      labelText: "Usuario",
                      labelStyle: TextStyle(color: Colors.deepPurple,fontFamily: "Ubuntu")
                    ),
                   ),
                 ),
                 const SizedBox(width: 10,),
                 const Padding(padding: EdgeInsets.fromLTRB(50,5,50,5),
                 child:  TextField(
                  decoration: InputDecoration(
                    
                    labelText: "Password",
                    labelStyle: TextStyle(color: Colors.deepPurple,fontFamily: "Ubuntu")
                  ),
                 obscureText: true,
                  ),
                 ),
                 const SizedBox(height: 20,),
                 MyElevatedButton(
                  gradiente: LinearGradient(colors: [
                    Colors.purple.shade700,
                    Colors.pink.shade800
                  ]),
                  width: (aspectRatio * 0.65),
                  borderRadius: BorderRadius.circular(30),
                  onPressed: ()
                  {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const HomePage()));
                  },
                  child: const Text("login", style: TextStyle(color: Colors.white,fontFamily: "Ubuntu", fontSize: 20),)),
                  SizedBox(height: screenHeight - 285 ),
                  ElevatedButton.icon(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const InfoPage()));
                  }, icon: const Icon(Icons.info_outline), label: const Text('Pruebas'))
                ]
             ),
          );
        }
      ),
    );
  }
}