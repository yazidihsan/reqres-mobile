import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reqres/core/exception/exception.dart';
import 'package:reqres/core/failure/failure.dart';
import 'package:reqres/features/home/data/models/user_model.dart';
import 'package:reqres/features/home/data/repositories/home_repository_impl.dart';

import '../../../../fixtures/fixture_reader.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late HomeRepositoryImpl repository;
  late MockHomeRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockHomeRemoteDataSource();
    repository = HomeRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('Get User', () {
    final jsonMap = json.decode(fixture('response_get_user.json'));
    final tUserModel =
        List.from(jsonMap['data']).map((e) => UserModel.fromJson(e)).toList();

    const tPage = 2;

    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getUsers(tPage))
          .thenAnswer((_) async => tUserModel);

      // act
      final result = await repository.getUsers(tPage);

      // assert
      verify(mockRemoteDataSource.getUsers(tPage));
      final resultList = result.getOrElse(() => []);

      expect(resultList, tUserModel);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getUser(tPage)).thenThrow(ServerException());

      // act
      final result = await repository.getUser(tPage);

      // assert
      verify(mockRemoteDataSource.getUser(tPage));
      expect(result, equals(Left(ServerFailure('${ServerException()}'))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getUser(tPage))
          .thenThrow(const SocketException(''));

      // act
      final result = await repository.getUser(tPage);

      // assert
      verify(mockRemoteDataSource.getUser(tPage));
      expect(result, equals(const Left(ConnectionFailure(''))));
    });

    test('should return tls failure when certificate not match', () async {
      // arrange
      when(mockRemoteDataSource.getUser(tPage))
          .thenThrow(const TlsException(''));

      // act
      final result = await repository.getUser(tPage);

      // assert
      verify(mockRemoteDataSource.getUser(tPage));
      expect(result, equals(const Left(TlsFailure(''))));
    });

    test('should return common failure when exception not catch', () async {
      // arrange
      when(mockRemoteDataSource.getUser(tPage)).thenThrow(Exception(''));

      // act
      final result = await repository.getUser(tPage);

      // assert
      verify(mockRemoteDataSource.getUser(tPage));
      expect(result, equals(Left(CommonFailure('${Exception('')}'))));
    });
  });
}
