import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:tokyo/features/home/controller/home_controller.dart';

import 'home_controller_test.mocks.dart'; // arquivo gerado

@GenerateMocks([BuildContext])
void main() {
  late HomeController controller;
  late MockBuildContext context;
  var canLaunchCalled = false;
  var launchUrlCalled = false;

  setUp(() {
    canLaunchCalled = false;
    launchUrlCalled = false;

    controller = HomeController(
      isWeb: true,
      canLaunchUrlFunc: (uri) async {
        canLaunchCalled = true;
        return true;
      },
      launchUrlFunc: (uri, {required mode}) async {
        launchUrlCalled = true;
        return true;
      },
    );
    context = MockBuildContext();
  });

  test(
    'abrirAutomovel chama launchUrl no web quando pode lançar URL',
    () async {
      await controller.abrirAutomovel(context);

      expect(canLaunchCalled, isTrue);
      expect(launchUrlCalled, isTrue);
    },
  );
}
