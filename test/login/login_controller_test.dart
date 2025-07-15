import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tokyo/features/auth/controller/login_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_controller_test.mocks.dart';

@GenerateMocks([
  FirebaseAuth,
  FirebaseFirestore,
  CollectionReference<Map<String, dynamic>>,
  Query<Map<String, dynamic>>,
  QuerySnapshot<Map<String, dynamic>>,
  QueryDocumentSnapshot<Map<String, dynamic>>,
  UserCredential,
  User,
])
void main() {
  late LoginController controller;
  late MockFirebaseAuth mockAuth;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference<Map<String, dynamic>> mockCollection;
  late MockQuery<Map<String, dynamic>> mockQuery;
  late MockQuerySnapshot<Map<String, dynamic>> mockQuerySnapshot;
  late MockQueryDocumentSnapshot<Map<String, dynamic>> mockDocument;
  late MockUserCredential mockUserCredential;
  late MockUser mockUser;

  setUp(() {
    mockAuth = MockFirebaseAuth();
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockQuery = MockQuery();
    mockQuerySnapshot = MockQuerySnapshot();
    mockDocument = MockQueryDocumentSnapshot();
    mockUserCredential = MockUserCredential();
    mockUser = MockUser();

    controller = LoginController(auth: mockAuth, firestore: mockFirestore);
  });

  test('toggleRememberMe alterna corretamente', () {
    expect(controller.rememberMe, false);

    controller.toggleRememberMe();
    expect(controller.rememberMe, true);

    controller.toggleRememberMe();
    expect(controller.rememberMe, false);
  });

  test('loginWithCpfAndPassword retorna user quando existe usuário', () async {
    // Arrange
    when(mockFirestore.collection('users')).thenReturn(mockCollection);
    when(
      mockCollection.where('cpf', isEqualTo: '123.456.789-00'),
    ).thenReturn(mockQuery);
    when(mockQuery.limit(1)).thenReturn(mockQuery);
    when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
    when(mockQuerySnapshot.docs).thenReturn([mockDocument]);
    when(mockDocument.data()).thenReturn({'email': 'test@example.com'});

    when(
      mockAuth.signInWithEmailAndPassword(
        email: 'test@example.com',
        password: '12345678',
      ),
    ).thenAnswer((_) async => mockUserCredential);
    when(mockUserCredential.user).thenReturn(mockUser);

    // Act
    final user = await controller.loginWithCpfAndPassword(
      '123.456.789-00',
      '12345678',
    );

    // Assert
    expect(user, mockUser);
  });

  test(
    'loginWithCpfAndPassword lança exceção quando CPF não encontrado',
    () async {
      // Arrange
      when(mockFirestore.collection('users')).thenReturn(mockCollection);
      when(
        mockCollection.where('cpf', isEqualTo: '000.000.000-00'),
      ).thenReturn(mockQuery);
      when(mockQuery.limit(1)).thenReturn(mockQuery);
      when(mockQuery.get()).thenAnswer((_) async => mockQuerySnapshot);
      when(mockQuerySnapshot.docs).thenReturn([]);

      // Act & Assert
      expect(
        () => controller.loginWithCpfAndPassword('000.000.000-00', '12345678'),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('CPF não encontrado'),
          ),
        ),
      );
    },
  );
}
