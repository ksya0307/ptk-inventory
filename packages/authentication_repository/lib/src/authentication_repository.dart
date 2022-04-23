//реализация
import 'dart:async';

enum AuthenticationStatus { authenticated, unauthenticated }

//работает с нашим апи (Data Provider)
//в соответствии с архетектурой BLoc
//его можно не использовать для простоты, но лучше его использовать в продакшине,
//для обновления статуса аутентификации
class AuthenticationRepository {
  //создание потока, куда мы помещаем данные, в нашем случае - AuthenticationStatus
  //в <>  тип объекта который можем отправить в поток
  final _controller = StreamController<AuthenticationStatus>();

  //.add - добавить/отправить событие в поток

  //custom getter method  для абстракционирования кода
  //позволяет инициализировать наш класс свойствами
  ///getter для статуса
  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));
    //засовываем наш статус в поток
    yield AuthenticationStatus.unauthenticated;
    //и отправляем наш поток в контроллер который им управляет
    //yield* отправялет самого себя
    yield* _controller.stream;
  }

  ///имитация аутентифицированого пользователя
  ///Generator function(формирует последовательность данных)
  //выполняется при .listen()
  //обычные функции возвращают одно значение
  //yield отправляет данные в поток но не завершает выполнение функции

  Future<void> logIn(
      {required String username, required String password}) async {
    await Future.delayed(
      const Duration(milliseconds: 300),
      //отправляет данные в поток
      () => _controller.add(AuthenticationStatus.authenticated),
    );
  }

  //выход
  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  //закрытие потока
  void dispose() => _controller.close();
}
