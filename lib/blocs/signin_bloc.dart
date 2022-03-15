import 'dart:async';
import 'package:rxdart/rxdart.dart';

class SignInBloc {
  final  _username = BehaviorSubject<String>(); //дает последнее значение
  final  _password = BehaviorSubject<String>();


  //Get
  //public методы, с помощью которых мы можем получить логин и пароль
  //output
  //выходной поток
  Stream<String> get username => _username.stream.transform(validateUsername);
  Stream<String> get password => _password.stream.transform(validatePassword);

  //combineLatest2 - так как у нас два текстовых поля
  //это возьмет два потока и объекдинит в один поток
  //если у нас есть два потока то форма валидна -true, если нет - false - не прошла трансформеры
  //если у нас есть username & password то это вернет true
  Stream<bool> get formValid => Rx.combineLatest2(username, password, (username, password) => true);


  //Set
  //когда печатаем что-то в текстовые поля мы будем вызывать эту функцию
  //input
  //sink - место, где отправляем инфу в поток, входой поток
  //дальше это пойти в трансформеры на валидацию
  Function(String) get changeUsername => _username.sink.add;
  Function(String) get changePassword => _password.sink.add;

  // StreamSink<String> get changeUsername => _username.sink;

  //когда открываем поток, его надо закрыть
  dispose() {
    _username.close();
    _password.close();
  }
  //Transformers
  final validateUsername = StreamTransformer<String, String>.fromHandlers(
      handleData: (username, sink) {
    //тут пишет что хотим, любую логику
    if (username.isNotEmpty) {
      print('юзер ${username}');
      sink.add(username);
    } else {
      sink.addError('Must not be empty');
    }
  });

  final validatePassword = StreamTransformer<String, String>.fromHandlers(
      //2<String, этот тип тот тип данных который у нас, e.g для денежного double >
      handleData: (password, sink) {
    if (password.trim().isNotEmpty) {
      sink.add(password);
      print('пароль ${password}');
    } else {
      sink.addError('Must not be empty');
    }
  });

  signIn() {
    print('Signed In Successfully ${_username} & ${_password}');
  }

}


