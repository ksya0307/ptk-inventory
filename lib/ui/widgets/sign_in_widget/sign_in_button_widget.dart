// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../authentication/login/sign_in_bloc.dart';
// import '../../authentication/login/sign_in_state.dart';
//
// class SignInButton extends StatelessWidget {
//   const SignInButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return
//       BlocBuilder<LoginBloc, LoginState>(
//         builder: (context, state) { return
//       ConstrainedBox(
//         constraints: BoxConstraints(
//           minWidth: MediaQuery.of(context).size.width,
//         ),
//         child: ElevatedButton(
//             child: Padding(
//                 padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
//                 child: const Text("Sign In",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                         fontSize: 22,
//                         fontFamily: 'PT Sans',
//                         fontWeight: FontWeight.w700))),
//             style: ButtonStyle(
//                 shape: MaterialStateProperty.all(RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(7.0))),
//                 elevation: MaterialStateProperty.all(0),
//                 foregroundColor: MaterialStateProperty.resolveWith((states) {
//                   if (states.contains(MaterialState.disabled)) {
//                     return Color.fromRGBO(255, 255, 255, 0.65);
//                   }
//                   return Colors.white;
//                 }),
//                 backgroundColor: MaterialStateProperty.resolveWith((states) {
//                   if (states.contains(MaterialState.disabled)) {
//                     return Color.fromRGBO(0, 47, 167, 0.65);
//                   }
//                   return Color.fromRGBO(0, 47, 167, 1.0);
//                 })),
//             onPressed:() {}));
//   });
// }
// }
