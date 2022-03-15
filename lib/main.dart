import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ptk_inventory/blocs/signin_bloc.dart';

void main() {
  runApp(
    Provider(create: (_) => SignInBloc(),child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
          title: 'PTK Inventory',
          theme: ThemeData(
              //primarySwatch: Colors.indigo,
              primaryColor: const Color.fromRGBO(0, 47, 167, 1.0),
              brightness: Brightness.light,
              scaffoldBackgroundColor: Colors.white,
              textTheme: const TextTheme(
                  headline6: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'PT Sans Caption')),
              visualDensity: VisualDensity.adaptivePlatformDensity,
              textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: Color.fromRGBO(0, 47, 167, 1.0))),
          home: SignIn(),
        );
  }
}

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {



    late String _username, _password;

    void didChangeDependencies() {
    precacheImage(new AssetImage('images/logo.png'), context);
    super.didChangeDependencies();
  }

    late TextEditingController usernameController = TextEditingController();
    late TextEditingController passwordController = TextEditingController();

    @override
    void initState() {
      super.initState();
      usernameController.addListener(_onUsernameChanged);
      passwordController.addListener(_onPasswordChanged);
    }

    void _onUsernameChanged(){
      _username = usernameController.text;
    }

    void _onPasswordChanged(){
      _password = passwordController.text;
    }


    @override
  void dispose() {
    super.dispose();
    usernameController.dispose();
    passwordController.dispose();
  }
    //show password
    bool _obscureText = true;
    void _passwordVisibility() {
      setState(() {
        _obscureText = !_obscureText;
      });
    }


    @override
  Widget build(BuildContext context) {
      final bloc = Provider.of<SignInBloc>(context);


    Widget loginInputField(SignInBloc bloc) {
      //наш username типа String
      return Consumer<SignInBloc>(builder:(context, bloc, child) =>StreamBuilder<String>(
        stream: bloc.username,
        builder: (context, snapshot) {
          return TextField(
            autofocus: true,
            //каждый раз когда мы будем что-то печатать, bloc получит это и передаст нашиму валидатору(трансформеру))
            onChanged: bloc.changeUsername,
            //controller: usernameController,
            cursorColor: Theme.of(context).primaryColor,
            maxLines: 1,
            minLines: 1,
            style: const TextStyle(
                fontFamily: 'PT Sans Caption',
                fontSize: 18,
                color: Color.fromRGBO(68, 68, 68, 1.0)),
            decoration: InputDecoration(
              ///работает
              //errorText: snapshot.error?.toString(),
              suffixIcon: const Icon(
                Icons.login_rounded,
                color: Color.fromRGBO(156, 156, 156, 1.0),
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              hintText: 'Username',
              hintStyle: const TextStyle(
                  fontFamily: 'PT Sans Caption',
                  fontSize: 18,
                  color: Color.fromRGBO(150, 150, 150, 1.0)),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
            ),
          );
        },
      ));
    }

    Widget passwordInputField(SignInBloc bloc) {
      return Consumer<SignInBloc>(builder:(context, bloc, child) => StreamBuilder<String>(
          stream: bloc.password,
          builder:(context, snapshot){
            return TextField(
                onChanged: bloc.changePassword,
                //controller: passwordController,
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                minLines: 1,
                obscureText: _obscureText,
                style: TextStyle(
                    fontFamily: 'PT Sans Caption',
                    fontSize: 18,
                    color: Color.fromRGBO(68, 68, 68, 1.0)),
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    color: Color.fromRGBO(156, 156, 156, 1.0),
                    onPressed: _passwordVisibility,
                    icon:
                    Icon(_obscureText ? Icons.visibility_rounded : Icons.visibility_off),
                  ),
                  //errorText: snapshot.error?.toString(),
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  hintText: 'Password',
                  hintStyle: const TextStyle(
                      fontFamily: 'PT Sans Caption',
                      fontSize: 18,
                      color: Color.fromRGBO(150, 150, 150, 1.0)),
                  border: const OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
                      borderRadius: BorderRadius.circular(7.0)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
                      borderRadius: BorderRadius.circular(7.0)),
                  // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
                ));
          }));}

    Widget signInButton(SignInBloc bloc) {
      return  Consumer<SignInBloc>(builder:(context, bloc, child) =>StreamBuilder<bool>(
          stream: bloc.formValid,
          builder: (context, snapshot) {
            return ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: MediaQuery.of(context).size.width,
                ),
                child: ElevatedButton(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                        child: const Text("Sign In",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'PT Sans',
                                fontWeight: FontWeight.w700))),
                    style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7.0))),
                        elevation: MaterialStateProperty.all(0),
                        foregroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Color.fromRGBO(255, 255, 255, 0.65);
                          }
                          return Colors.white;
                        }),
                        backgroundColor: MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.disabled)) {
                            return Color.fromRGBO(0, 47, 167, 0.65);
                          }
                          return Color.fromRGBO(0, 47, 167, 1.0);
                        })),
                    onPressed: !snapshot.hasData ? null  :(){
                      bloc.signIn;
                      print('${snapshot.data} snapshot' );
                              }));
          }
      ));};

    Widget buildPortrait() => SafeArea(child: LayoutBuilder(
      builder: (BuildContext context, BoxConstraints view) {
        return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: view.maxHeight,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Image(
                      image: AssetImage('images/logo.png'),
                    ),
                    const SizedBox(height: 12),
                    loginInputField(bloc),
                    const SizedBox(height: 8),
                    passwordInputField(bloc),
                    const SizedBox(height: 8),
                    signInButton(bloc),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ));
      },
    ));

    Widget buildLandscape() => SafeArea(child:
    LayoutBuilder(builder: (BuildContext context, BoxConstraints view) {
      return SingleChildScrollView(
          child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: view.maxHeight,
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                            child: const Image(
                              image: AssetImage('images/logo.png'),
                            ),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 12),
                                loginInputField(bloc),
                                SizedBox(height: 8),
                                passwordInputField(bloc),
                                SizedBox(height: 8),
                                signInButton(bloc),
                                SizedBox(height: 8),
                              ],
                            ))),
                  ],
                ),
              )));
    }));

    return Scaffold(
        body: OrientationBuilder(
            builder: (context, orientation) =>
            orientation == Orientation.portrait
                ? buildPortrait()
                : buildLandscape()));
  }
}



class Home extends StatelessWidget {

  // final usernameController = TextEditingController();
  // final passwordController = TextEditingController();
  // late TextEditingController loginController;
  // late TextEditingController passwordController;


  // @override
  // void initState() {
  //   super.initState();
  //   loginController = TextEditingController();
  //   passwordController = TextEditingController();
  // }
  //

  @override
  Widget build(BuildContext context) {
    //в bloc хранится ссылка на наш созданный Bloc в signin_bloc
    //получить ссылку на Блок, в  <> указываем, что ищем в дереве виджетов
    //отправляется в дерево виджетов и находит первый экзмепляр этого типа то что мы уже создали в create в верху
    final bloc = Provider.of<SignInBloc>(context);

    Widget loginInputField(SignInBloc bloc) {
      //наш username типа String
      return StreamBuilder<String>(
        stream: bloc.username,
        builder: (context, snapshot) {
          return TextField(
            //каждый раз когда мы будем что-то печатать, bloc получит это и передаст нашиму валидатору(трансформеру))
            onChanged: bloc.changeUsername,
            //controller: loginController,
            cursorColor: Theme.of(context).primaryColor,
            maxLines: 1,
            minLines: 1,
            style: const TextStyle(
                fontFamily: 'PT Sans Caption',
                fontSize: 18,
                color: Color.fromRGBO(68, 68, 68, 1.0)),
            decoration: InputDecoration(
              ///работает
              //errorText: snapshot.error?.toString(),
              suffixIcon: const Icon(
                Icons.login_rounded,
                color: Color.fromRGBO(156, 156, 156, 1.0),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              hintText: 'Логин',
              hintStyle: const TextStyle(
                  fontFamily: 'PT Sans Caption',
                  fontSize: 18,
                  color: Color.fromRGBO(150, 150, 150, 1.0)),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
            ),
          );
        },
      );
    }

    Widget passwordInputField(SignInBloc bloc) {
      return StreamBuilder<String>(
        stream: bloc.password,
        builder:(context, snapshot){
          return TextField(
            onChanged: bloc.changePassword,
          // controller: passwordController,
            cursorColor: Theme.of(context).primaryColor,
            maxLines: 1,
            minLines: 1,
            // obscureText: _obscureText,
            style: TextStyle(
                fontFamily: 'PT Sans Caption',
                fontSize: 18,
                color: Color.fromRGBO(68, 68, 68, 1.0)),
            // decoration: InputDecoration(
            //   suffixIcon: IconButton(
            //     color: Color.fromRGBO(156, 156, 156, 1.0),
            //     onPressed: (){},
            //     _passwordVisibility,
            //     icon:
            //     Icon(_obscureText ? Icons.visibility_rounded : Icons.visibility_off),
            //   ),
            decoration: InputDecoration(
              //errorText: snapshot.error?.toString(),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
              hintText: 'Пароль',
              hintStyle: const TextStyle(
                  fontFamily: 'PT Sans Caption',
                  fontSize: 18,
                  color: Color.fromRGBO(150, 150, 150, 1.0)),
              border: const OutlineInputBorder(),
              focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                      color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
                  borderRadius: BorderRadius.circular(7.0)),
              // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
            ));
      });}

    Widget signInButton(SignInBloc bloc) {
        return  StreamBuilder<bool>(
          stream: bloc.formValid,
          builder: (context, snapshot) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width,
              ),
              child: ElevatedButton(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
                      child: const Text("Войти",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 22,
                              fontFamily: 'PT Sans',
                              fontWeight: FontWeight.w700))),
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7.0))),
                      elevation: MaterialStateProperty.all(0),
                      foregroundColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Color.fromRGBO(255, 255, 255, 0.65);
                        }
                        return Colors.white;
                      }),
                      backgroundColor: MaterialStateProperty.resolveWith((states) {
                        if (states.contains(MaterialState.disabled)) {
                          return Color.fromRGBO(0, 47, 167, 0.65);
                        }
                        return Color.fromRGBO(0, 47, 167, 1.0);
                      })),
                  onPressed: snapshot.hasData ? bloc.signIn : null));
          }
        );};

    Widget buildPortrait() => SafeArea(child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints view) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: view.maxHeight,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('images/logo.png'),
                      ),
                      const SizedBox(height: 12),
                      loginInputField(bloc),
                      const SizedBox(height: 8),
                      passwordInputField(bloc),
                      const SizedBox(height: 8),
                      signInButton(bloc),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ));
        },
      ));

    Widget buildLandscape() => SafeArea(child:
      LayoutBuilder(builder: (BuildContext context, BoxConstraints view) {
        return SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: view.maxHeight,
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
                              child: const Image(
                                image: AssetImage('images/logo.png'),
                              ),
                            )
                          ],
                        ),
                      ),
                      Expanded(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(height: 12),
                                  loginInputField(bloc),
                                  SizedBox(height: 8),
                                  passwordInputField(bloc),
                                  SizedBox(height: 8),
                                  signInButton(bloc),
                                  SizedBox(height: 8),
                                ],
                              ))),
                    ],
                  ),
                )));
      }));

      return Scaffold(
          body: OrientationBuilder(
              builder: (context, orientation) =>
              orientation == Orientation.portrait
                  ? buildPortrait()
                  : buildLandscape()));
    }
  }


//
// class _HomeState extends State<Home> {
//   //преждевременная подгрузка фотографии
//   @override
//   void didChangeDependencies() {
//     precacheImage(new AssetImage('images/logo.png'), context);
//     super.didChangeDependencies();
//   }
//
//   //форма
//   final _formKey = GlobalKey<FormState>();
//
//
//   late TextEditingController loginController;
//   late TextEditingController passwordController;
//
//   //show password
//   bool _obscureText = true;
//   void _passwordVisibility() {
//     setState(() {
//       _obscureText = !_obscureText;
//     });
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     loginController = TextEditingController();
//     passwordController = TextEditingController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     loginController.dispose();
//     passwordController.dispose();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     /////////////////////////////////////////////
//     //цвет текста ввода - 444444/68 68 68
//     //цвет placeholder - 969696/150 150 150
//     //цвет иконки - 9C9C9C/156 156 156
//     //цвет границы в фокусе - 1851E3/24 81 227/0,75
//     //цвет границы не в фокусе - 969696/150 150 150
//     //////////////////////////////////////////////
//
//     Widget loginInputField = TextFormField(
//       controller: loginController,
//       cursorColor: Theme.of(context).primaryColor,
//       maxLines: 1,
//       minLines: 1,
//       style: const TextStyle(
//           fontFamily: 'PT Sans Caption',
//           fontSize: 18,
//           color: Color.fromRGBO(68, 68, 68, 1.0)),
//       decoration: InputDecoration(
//         suffixIcon: const Icon(
//           Icons.login_rounded,
//           color: Color.fromRGBO(156, 156, 156, 1.0),
//         ),
//         contentPadding:
//             const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//         hintText: 'Логин',
//         hintStyle: const TextStyle(
//             fontFamily: 'PT Sans Caption',
//             fontSize: 18,
//             color: Color.fromRGBO(150, 150, 150, 1.0)),
//         border: const OutlineInputBorder(),
//         focusedBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//                 color: Color.fromRGBO(24, 81, 227, 0.75), width: 1.5),
//             borderRadius: BorderRadius.circular(7.0)),
//         enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(
//                 color: Color.fromRGBO(150, 150, 150, 1.0), width: 1.5),
//             borderRadius: BorderRadius.circular(7.0)),
//         // isDense: true,contentPadding: const EdgeInsets.fromLTRB(12, 15, 12, 15)
//       ),
//     );
//
//     Widget passwordInputField = TextFormField(
//         controller: passwordController,
//         cursorColor: Theme.of(context).primaryColor,
//         maxLines: 1,
//         minLines: 1,
//         obscureText: _obscureText,
//         style: const TextStyle(
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
//           contentPadding:
//               const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
//           hintText: 'Пароль',
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
//
//     Widget signInButton = ConstrainedBox(
//         constraints: BoxConstraints(
//           minWidth: MediaQuery.of(context).size.width,
//         ),
//         child: ElevatedButton(
//           child: Padding(
//               padding: EdgeInsets.fromLTRB(0, 12, 0, 12),
//               child: const Text("Войти",
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                       fontSize: 22,
//                       fontFamily: 'PT Sans',
//                       fontWeight: FontWeight.w700))),
//           style: ButtonStyle(
//             shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.0))),
//               elevation: MaterialStateProperty.all(0),
//               foregroundColor: MaterialStateProperty.resolveWith((states) {
//                 if (states.contains(MaterialState.disabled)) {
//                   return Color.fromRGBO(255, 255, 255, 0.65);
//                 }
//                 return Colors.white;
//               }),
//               backgroundColor: MaterialStateProperty.resolveWith((states) {
//                 if (states.contains(MaterialState.disabled)) {
//                   return Color.fromRGBO(0, 47, 167, 0.65);
//                 }
//                 return Color.fromRGBO(0, 47, 167, 1.0);
//               })),
//           onPressed: (){}
//         ));
//
//     Widget buildPortrait() => SafeArea(child: LayoutBuilder(
//           builder: (BuildContext context, BoxConstraints view) {
//             return SingleChildScrollView(
//                 child: ConstrainedBox(
//                     constraints: BoxConstraints(
//                       minHeight: view.maxHeight,
//                     ),
//                     child: Container(
//                       padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                       child: Form(
//                         key: _formKey,
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Image(
//                               image: AssetImage('images/logo.png'),
//                             ),
//                             const SizedBox(height: 12),
//                             loginInputField,
//                             const SizedBox(height: 8),
//                             passwordInputField,
//                             const SizedBox(height: 8),
//                             signInButton,
//                             const SizedBox(height: 8),
//                           ],
//                         ),
//                       ),
//                     )));
//           },
//         ));
//
//     Widget buildLandscape() => SafeArea(child:
//             LayoutBuilder(builder: (BuildContext context, BoxConstraints view) {
//           return SingleChildScrollView(
//               child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     minHeight: view.maxHeight,
//                   ),
//                   child: Container(
//                     padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Padding(
//                                 padding: EdgeInsets.fromLTRB(16, 0, 8, 0),
//                                 child: const Image(
//                                   image: AssetImage('images/logo.png'),
//                                 ),
//                               )
//                             ],
//                           ),
//                         ),
//                         Expanded(
//                             child: Padding(
//                                 padding: EdgeInsets.fromLTRB(8, 0, 16, 0),
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     SizedBox(height: 12),
//                                     loginInputField,
//                                     SizedBox(height: 8),
//                                     passwordInputField,
//                                     SizedBox(height: 8),
//                                     signInButton,
//                                     SizedBox(height: 8),
//                                   ],
//                                 ))),
//                       ],
//                     ),
//                   )));
//         }));
//
//     return Scaffold(
//         body: OrientationBuilder(
//             builder: (context, orientation) =>
//                 orientation == Orientation.portrait
//                     ? buildPortrait()
//                     : buildLandscape()));
//   }
// }
