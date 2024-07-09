import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reqres/features/home/domain/entities/user.dart';
import 'package:reqres/features/home/domain/usecases/get_users.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetUsers usecase;
  late MockHomeRepository mockHomeRepository;

  setUp(() {
    mockHomeRepository = MockHomeRepository();
    usecase = GetUsers(mockHomeRepository);
  });

  const tPage = 2;
  const tUser = <User>[];

  test('should get list of user from the repository', () async {
    // arrange
    when(mockHomeRepository.getUsers(tPage))
        .thenAnswer((_) async => const Right(tUser));

    // act
    final result = await usecase(const Params(page: tPage));

    // assert
    expect(result, const Right(tUser));
  });
}
