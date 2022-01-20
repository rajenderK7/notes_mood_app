// import 'package:flutter/material.dart';

// class NewScreen extends StatefulWidget {
//   NewScreen({Key? key}) : super(key: key);

//   @override
//   State<NewScreen> createState() => _NewScreenState();
// }

// class _NewScreenState extends State<NewScreen> {
//   double _width = 200;
//   double _opacity = 1;
//   double _margin = 0;
//   Color _color = Colors.white;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           colors: [Colors.orange, Colors.pink],
//           begin: Alignment.bottomLeft,
//           end: Alignment.topRight,
//         ),
//       ),
//       child: Column(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: AnimatedContainer(
//                 duration: const Duration(milliseconds: 900),
//                 margin: EdgeInsets.all(_margin),
//                 width: _width,
//                 height: 200,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20), color: _color),
//               ),
//             ),
//           ),
//           AnimatedOpacity(
//             duration: const Duration(seconds: 2),
//             opacity: _opacity,
//             child: const Text(
//               "Rajender",
//               style: TextStyle(
//                 fontSize: 30,
//               ),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.all(20),
//             // transform: Matrix4.columns(),
//             child: TextButton(
//               child: const Text(
//                 "Animate",
//                 style: TextStyle(fontSize: 20),
//               ),
//               onPressed: () {
//                 setState(() {
//                   _width = 400;
//                   _color = Colors.yellow;
//                   _margin = 40.0;
//                 });
//               },
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//           ),
//           Container(
//             margin: const EdgeInsets.all(20),
//             child: TextButton(
//               child: const Text(
//                 "Animate",
//                 style: TextStyle(fontSize: 20),
//               ),
//               onPressed: () {
//                 setState(() {
//                   _opacity = 0;
//                 });
//               },
//             ),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(10.0),
//             ),
//           ),
//           AnimatedOpacity(
//             opacity: _opacity,
//             duration: const Duration(seconds: 2),
//             child: Container(
//               width: 150,
//               height: 20,
//               color: Colors.white,
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               setState(() {
//                 _opacity = 0;
//               });
//             },
//             child: const Text("Animate Container"),
//           ),
//         ],
//       ),
//     );
//   }
// }
