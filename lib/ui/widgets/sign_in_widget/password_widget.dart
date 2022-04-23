// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ptk_inventory/ui/authentication/login/sign_in_event.dart';
//
// import '../../authentication/login/sign_in_bloc.dart';
// import '../../authentication/login/sign_in_state.dart';
//
// class PasswordTextField extends StatefulWidget {
//   const PasswordTextField({Key? key}) : super(key: key);
//
//   @override
//   State<PasswordTextField> createState() => _PasswordTextFieldState();
// }
//
// class _PasswordTextFieldState extends State<PasswordTextField> {
//   bool _obscureText = true;
//   void _passwordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<LoginBloc, LoginState>(
//         builder: (context, state) { return
//       TextFormField(
//         //передает value, которое введено в поле, каждый символ
//         //передает либо String, либо null, что оно inValid
//         validator: (value) => state.isValidPassword ? null: 'Password = null',
//         onChanged: (value) => context.read<LoginBloc>().add(LoginPasswordChanged(password: value)),
//         cursorColor: Theme.of(context).primaryColor,
//         maxLines: 1,
//         minLines: 1,
//         obscureText: _obscureText,
//         style: TextStyle(
//             fontFamily: 'PT Sans Caption',
//             fontSize: 18,
//             color: Color.fromRGBO(68, 68, 68, 1.0)),
//         decoration: InputDecoration(
//           suffixIcon: IconButton(
//             color: Color.fromRGBO(156, 156, 156, 1.0),
//             onPressed: _passwordVisibility,
//             icon: Icon(
//                 _obscureText ? Icons.visibility_rounded : Icons.visibility_off),
//           ),
//           //errorText: snapshot.error?.toString(),
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//           hintText: 'Password',
//           hintStyle: const TextStyle(
//               fontFamily: 'PT Sans Caption',
//               fontSize: 18,
//               color: Color.fromRGBO(150, 150, 150, 1.0)),
//           border: const OutlineInputBorder(),
//           focusedBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                   color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
//               borderRadius: BorderRadius.circular(7.0)),
//           enabledBorder: OutlineInputBorder(
//               borderSide: const BorderSide(
//                   color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
//               borderRadius: BorderRadius.circular(7.0)),
//           // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
//         ));
//   });}
// }
