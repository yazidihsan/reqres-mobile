import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:reqres/core/exception/exception.dart';
import 'package:reqres/core/failure/failure.dart';
import 'package:reqres/features/home/data/datasources/home_remote_data_source.dart';
import 'package:reqres/features/home/domain/entities/user.dart';
import 'package:reqres/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<User>>> getUsers(int page) async {
    try {
      final result = await remoteDataSource.getUsers(page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    } on TlsException catch (e) {
      return Left(TlsFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> getUser(int id) async {
    // TODO: implement getUser
    try {
      final result = await remoteDataSource.getUser(id);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    } on SocketException catch (e) {
      return Left(ConnectionFailure(e.message));
    } on TlsException catch (e) {
      return Left(TlsFailure(e.message));
    } catch (e) {
      return Left(CommonFailure(e.toString()));
    }
  }
}
