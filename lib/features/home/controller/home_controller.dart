import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

typedef CanLaunchUrl = Future<bool> Function(Uri uri);
typedef LaunchUrl = Future<bool> Function(Uri uri, {required LaunchMode mode});

class HomeController {
  final String userName = 'Henrique Moles';

  final CanLaunchUrl canLaunchUrlFunc;
  final LaunchUrl launchUrlFunc;
  final bool isWeb;

  HomeController({
    CanLaunchUrl? canLaunchUrlFunc,
    LaunchUrl? launchUrlFunc,
    bool? isWeb,
  }) : canLaunchUrlFunc = canLaunchUrlFunc ?? canLaunchUrl,
       launchUrlFunc = launchUrlFunc ?? launchUrl,
       isWeb = isWeb ?? kIsWeb;

  Future<void> abrirAutomovel(BuildContext context) async {
    final url = 'https://jsonplaceholder.typicode.com/';
    final title = 'Automóvel';

    if (isWeb) {
      final uri = Uri.parse(url);
      if (await canLaunchUrlFunc(uri)) {
        await launchUrlFunc(uri, mode: LaunchMode.externalApplication);
      } else {
        _showError(context, 'Não foi possível abrir o link');
      }
    } else {
      if (context.mounted) {
        context.pushNamed(
          'webview',
          queryParameters: {'url': url, 'title': title},
        );
      }
    }
  }

  Future<void> abrirResidencia(BuildContext context) async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/');
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      _showError(context, 'Não foi possível abrir o link');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
