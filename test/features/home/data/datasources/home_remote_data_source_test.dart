import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reqres/core/exception/exception.dart';
import 'package:reqres/features/home/data/datasources/home_remote_data_source.dart';
import 'package:reqres/features/home/data/models/user_model.dart';
import 'package:http/http.dart' as http;

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();

  late HomeRemoteDataSourceImpl datasource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    datasource = HomeRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get Users', () {
    final jsonMap = json.decode(fixture('response_get_user.json'));
    final tUserModel =
        List.from(jsonMap['data']).map((e) => UserModel.fromJson(e)).toList();

    final baseUrl = dotenv.env['BASE_URL'];
    const tPage = 2;

    final tError = jsonEncode({'message': 'Not Found'});

    test('should return list of User Model when the response code is 200',
        () async {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/api/users?page=$tPage')))
          .thenAnswer((_) async =>
              http.Response(fixture('response_get_user.json'), 200));

      // act
      final result = await datasource.getUser(tPage);

      // assert
      expect(result, equals(tUserModel));
    });

    test(
        'should throw a ServerException when the response code is 404 or other',
        () {
      // arrange
      when(mockHttpClient.get(Uri.parse('$baseUrl/api/users?page=$tPage')))
          .thenAnswer((_) async => http.Response(tError, 404));

      // act
      final call = datasource.getUser(tPage);

      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
