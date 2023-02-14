import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:workers_repository/workers_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lavoratori_stagionali/create/bloc/create_bloc.dart';

class MockWorkersRepository extends Mock implements WorkersRepository {}

void main() {
  late WorkersRepository mockWorkersRepository;
  late CreateBloc createBloc;

  setUp(() {
    mockWorkersRepository = MockWorkersRepository();
    createBloc = CreateBloc(workersRepository: mockWorkersRepository);
  });

  final tWorker = Worker(
    id: '123',
    firstname: 'John',
    lastname: 'Doe',
    birthday: DateFormat("dd/MM/yyyy").parse('23/02/1990'),
    birthplace: 'New York',
    nationality: 'American',
    email: 'johndoe@example.com',
    phone: '555-123456',
    address: '123 Main St',
    workExperiences: [
      WorkExperience(
        id: '123',
        title: "Developer",
        dailyPay: 60,
        companyName: 'ABC Inc.',
        start: DateFormat("dd/MM/yyyy").parse('01/01/2020'),
        end: DateFormat("dd/MM/yyyy").parse('01/01/2021'),
        tasks: const ["Developer", "Software Engineer"],
        workplace: "Verona",
        notes: "",
      ),
    ],
    emergencyContacts: [
      EmergencyContact(
          firstname: 'Jane',
          lastname: 'Doe',
          phone: '1112223334',
          email: 'testemail@gmail.com'),
    ],
    languages: ['English'],
    licenses: ['A'],
    locations: ['Verona'],
    periods: [
      Period(
        start: DateFormat("dd/MM/yyyy").parse('01/01/2020'),
        end: DateFormat("dd/MM/yyyy").parse('01/01/2021'),
      ),
    ],
    withOwnCar: true,
  );

  final tStateBase = CreateState(
      birthday: "23/02/1990",
      emergencyContacts: tWorker.emergencyContacts,
      languages: tWorker.languages,
      licenses: tWorker.licenses,
      locations: tWorker.locations);

  final tStateLoading = tStateBase.copyWith(status: CreateStatus.loading);
  final tStateSuccess = tStateBase.copyWith(status: CreateStatus.success);

  const tStateFailure = CreateState(
    status: CreateStatus.failure,
    errorMessage: "Compilare tutti i campi obbligatori.",
  );

  group('CreateBloc', () {
    test('initial state is CreateState', () {
      expect(createBloc.state, equals(const CreateState()));
    });

    blocTest<CreateBloc, CreateState>(
        'emits [loading, initial] when save worker is successful',
        setUp: () {
          when(() => mockWorkersRepository.saveWorker(tWorker)).thenAnswer(
            (_) async => {},
          );
          when(() => mockWorkersRepository.resetWorker(tWorker))
              .thenAnswer((_) async => true);
        },
        build: () => createBloc,
        seed: () => tStateBase,
        act: (bloc) => bloc.add(const SaveRequested()),
        expect: () => [tStateLoading, const CreateState()]);

    blocTest<CreateBloc, CreateState>(
        'emits [loading, failure] when save worker throws an exception',
        setUp: () {
          when(() => mockWorkersRepository.saveWorker(tWorker)).thenThrow(
            const WorkersException(),
          );
        },
        build: () => createBloc,
        seed: () => tStateBase,
        act: (bloc) => bloc.add(const SaveRequested()),
        expect: () => [tStateLoading, const CreateState()]);
  });
}
