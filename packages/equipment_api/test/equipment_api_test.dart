import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class MockHttpClient extends Mock implements http.Client {}
//
// class MockResponse extends Mock implements http.Response {}
//
// class FakeUri extends Fake implements Uri {}

@GenerateMocks([http.Client])
void main() {
  group('fetchEquipment', () {
    // test('return [Equipments] if the http call completes successfully', () async{
    //   final client = MockClient();
    //
    //
    //   when(
    //       client.get(Uri.parse('ktor-equipment-inventory.herokuapp.com/api/v1/classroom-equipment?classroom=109')))
    //   .thenAnswer((_) async =>
    //   http.Response('body',200));
    //   expect(await getAllEquipment(), isA<ClassroomEquipment>());
    // });
  });

  // group('EquipmentApiClient', () {
  //   late http.Client httpClient;
  //   late EquipmentApiClient equipmentApiClient;
  //
  //   setUpAll(() {
  //     registerFallbackValue(FakeUri());
  //   });
  //
  //   setUp(() {
  //     httpClient = MockHttpClient();
  //     equipmentApiClient = EquipmentApiClient(httpClient: httpClient);
  //   });
  //
  //   group('constructor', () {
  //     test('does not require an httpClient', () {
  //       expect(EquipmentApiClient(), isNotNull);
  //     });
  //   });
  //
  //   group('getAllEquipments', () {
  //
  //     const query = 'mock-query';
  //
  //     test('makes correct http request', () async {
  //       final response = MockResponse();
  //       when(() => response.statusCode).thenReturn(200);
  //       when(() => response.body).thenReturn('[]');
  //       when(() => httpClient.get(any())).thenAnswer((_) async => response);
  //       try {
  //         await equipmentApiClient.getAllEquipment();
  //       } catch (_) {}
  //       verify(
  //               () =>
  //               httpClient.get(
  //                   Uri.https('ktor-equipment-inventory.herokuapp.com'
  //                       , '/api/v1/classroom-equipment'
  //                   ),
  //               )
  //       ).called(0);
  //     });
  //
  //     test(
  //         'throws EquipmentByClassroomOrCategoryNotFoundFailure on empty response', () async {
  //       final response = MockResponse();
  //       when(() => response.statusCode).thenReturn(200);
  //       when(()=> response.body).thenReturn('[]');
  //       when(()=> httpClient.get(any())).thenAnswer((_) async=> response );
  //       await expectLater(
  //       equipmentApiClient.getEquipmentByClassroomOrCategory(query,query),
  //       throwsA(isA<EquipmentByClassroomOrCategoryNotFoundFailure>()),
  //       );
  //     });
  //   });
  // });
}
