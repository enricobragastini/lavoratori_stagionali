import 'package:lavoratori_stagionali/gallery/bloc/gallery_bloc.dart';
import 'package:test/test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:workers_repository/workers_repository.dart';

class MockWorkersRepository extends Mock implements WorkersRepository {}

class FakeWorker extends Fake implements Worker {}

void main() {
  final List<Worker> mockWorkers = [
    Worker(
      firstname: "Mario",
      lastname: "Rossi",
      email: "mariorossi@gmail.com",
      phone: "1234567890",
      birthday: DateTime(1990),
      address: "Via Roma, 1",
      birthplace: "Verona",
      nationality: "Italiana",
      emergencyContacts: [],
      languages: [],
      licenses: [],
      locations: [],
      periods: [],
      workExperiences: [],
      withOwnCar: true,
    ),
    Worker(
      firstname: "Paolo",
      lastname: "Bianchi",
      email: "paolobianchi@gmail.com",
      phone: "1234567890",
      birthday: DateTime(1990),
      address: "Via Roma, 1",
      birthplace: "Verona",
      nationality: "Italiana",
      emergencyContacts: [],
      languages: [],
      licenses: [],
      locations: [],
      periods: [],
      workExperiences: [],
      withOwnCar: true,
    ),
    Worker(
      firstname: "Gino",
      lastname: "Verdi",
      email: "ginoverdi@gmail.com",
      phone: "1234567890",
      birthday: DateTime(1990),
      address: "Via Roma, 1",
      birthplace: "Verona",
      nationality: "Italiana",
      emergencyContacts: [],
      languages: [],
      licenses: [],
      locations: [],
      periods: [],
      workExperiences: [],
      withOwnCar: true,
    ),
  ];

  group('GalleryBloc', () {
    late MockWorkersRepository mockWorkersRepository;
    late GalleryBloc bloc;

    setUp(() {
      mockWorkersRepository = MockWorkersRepository();
      bloc = GalleryBloc(workersRepository: mockWorkersRepository);

      when(
        () => mockWorkersRepository.workersList,
      ).thenAnswer((_) => Future.delayed(
            Duration.zero,
            () => mockWorkers,
          ));

      when(() => mockWorkersRepository.workersStream)
          .thenAnswer((_) => const Stream.empty());
    });

    setUpAll(() {
      registerFallbackValue(FakeWorker());
    });

    GalleryBloc buildBloc() => bloc;

    group('Constructor', () {
      //test('works properly', () => expect(bloc, returnsNormally));

      test('has correct initial state', () {
        expect(
          bloc.state,
          equals(const GalleryState()),
        );
      });
    });

    group('WorkersSubscriptionRequested', () {
      blocTest<GalleryBloc, GalleryState>(
        'starts listening to repository Workers stream',
        build: buildBloc,
        act: (bloc) => bloc.add(const WorkersSubscriptionRequested()),
        verify: (_) {
          verify(() => mockWorkersRepository.workersList).called(
              1); // Verifica che la funzione workersList venga chiamata una sola volta
        },
        expect: () => [
          const GalleryState(
            status: GalleryStatus.loading,
          ),
          GalleryState(
            status: GalleryStatus.success,
            workers: mockWorkers,
          ),
        ],
      );
    });

    group('GalleryWorkerDeleted', () {
      blocTest<GalleryBloc, GalleryState>('deletes worker using repository',
          setUp: () {
            when(
              () => mockWorkersRepository.deleteWorker(any()),
            ).thenAnswer((_) async => true);
          },
          build: buildBloc,
          seed: () => GalleryState(workers: mockWorkers),
          act: (bloc) =>
              bloc.add(WorkerDeleteRequested(worker: mockWorkers[0])),
          verify: (_) {
            verify(
              () => mockWorkersRepository.deleteWorker(mockWorkers[0]),
            ).called(1);
          },
          expect: () => [
                GalleryState(
                    status: GalleryStatus.loading, workers: mockWorkers),
                GalleryState(
                  status: GalleryStatus.success,
                  workers: mockWorkers,
                ),
              ]);
    });
  });
}
