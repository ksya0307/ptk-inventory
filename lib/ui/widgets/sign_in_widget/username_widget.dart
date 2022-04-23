// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:ptk_inventory/ui/authentication/login/sign_in_bloc.dart';
// import 'package:ptk_inventory/ui/authentication/login/sign_in_event.dart';
// import 'package:ptk_inventory/ui/authentication/login/sign_in_state.dart';
//
// class UsernameTextField extends StatefulWidget {
//   const UsernameTextField({Key? key}) : super(key: key);
//
//   @override
//   State<UsernameTextField> createState() => _UsernameTextFieldState();
// }
//
// class _UsernameTextFieldState extends State<UsernameTextField> {
//   @override
//   Widget build(BuildContext context) {
//     //bloc builder для валидации
//     return BlocBuilder<LoginBloc, LoginState>(
//       builder: (context, state) {
//         return TextFormField(
//           validator: (value) => state.isValidUsername ? null: 'Username = null',
//           onChanged: (value) => context.read<LoginBloc>().add(LoginUsernameChanged(username: value)),
//           autofocus: true,
//           //каждый раз когда мы будем что-то печатать, bloc получит это и передаст нашиму валидатору(трансформеру))
//           //onChanged: bloc.changeUsername,
//           //controller: usernameController,
//           cursorColor: Theme
//               .of(context)
//               .primaryColor,
//           maxLines: 1,
//           minLines: 1,
//           style: const TextStyle(
//               fontFamily: 'PT Sans Caption',
//               fontSize: 18,
//               color: Color.fromRGBO(68, 68, 68, 1.0)),
//           decoration: InputDecoration(
//
//             ///работает
//             //errorText: snapshot.error?.toString(),
//             suffixIcon: const Icon(
//               Icons.login_rounded,
//               color: Color.fromRGBO(156, 156, 156, 1.0),
//             ),
//             contentPadding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//             hintText: 'Username',
//             hintStyle: const TextStyle(
//                 fontFamily: 'PT Sans Caption',
//                 fontSize: 18,
//                 color: Color.fromRGBO(150, 150, 150, 1.0)),
//             border: const OutlineInputBorder(),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(
//                     color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
//                 borderRadius: BorderRadius.circular(7.0)),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: const BorderSide(
//                     color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
//                 borderRadius: BorderRadius.circular(7.0)),
//             // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
//           ),
//         );
//       });
//   }
// }
