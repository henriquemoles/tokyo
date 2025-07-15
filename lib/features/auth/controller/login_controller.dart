import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginController extends ChangeNotifier {
  final cpfController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  final isLoading = ValueNotifier<bool>(false);
  final isFormValid = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showPassword = ValueNotifier<bool>(false);
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  LoginController({FirebaseAuth? auth, FirebaseFirestore? firestore})
    : _auth = auth ?? FirebaseAuth.instance,
      _firestore = firestore ?? FirebaseFirestore.instance {
    cpfController.addListener(_validateForm);
    passwordController.addListener(_validateForm);
  }

  void _validateForm() {
    final cpf = cpfController.text;
    final senha = passwordController.text;

    final isValid = _isCpfComplete(cpf) && senha.length >= 8;
    isFormValid.value = isValid;
  }

  bool _isCpfComplete(String cpf) {
    return cpf.length == 14;
  }

  void toggleRememberMe() {
    rememberMe = !rememberMe;
    notifyListeners();
  }

  Future<User?> loginWithCpfAndPassword(String cpf, String password) async {
    try {
      var snapshot =
          await _firestore
              .collection('users')
              .where('cpf', isEqualTo: cpf)
              .limit(1)
              .get();

      if (snapshot.docs.isEmpty) {
        throw Exception('CPF não encontrado');
      }

      String email = snapshot.docs.first.data()['email'];

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user != null) {
        await _secureStorage.write(key: 'cpf', value: cpf);
        await _secureStorage.write(key: 'password', value: password);
      }
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      throw Exception('Erro de autenticação: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }

  Future<void> loadSavedCredentials() async {
    final savedCpf = await _secureStorage.read(key: 'cpf');
    final savedPassword = await _secureStorage.read(key: 'password');

    if (savedCpf != null) {
      cpfController.text = savedCpf;
    }
    if (savedPassword != null) {
      passwordController.text = savedPassword;
    }
  }

  @override
  void dispose() {
    cpfController.dispose();
    passwordController.dispose();
    showPassword.dispose();
    super.dispose();
  }
}
