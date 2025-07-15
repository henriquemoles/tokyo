import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tokyo/features/home/controller/home_controller.dart';
import 'package:get_it/get_it.dart';
import 'package:tokyo/features/theme/theme_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final controller = HomeController();
  final themeController = GetIt.I.get<ThemeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: SvgPicture.asset(
            color: Colors.white,
            'assets/logo-tokiomarine.svg',
            height: 32, // ajuste conforme necessário
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Notificações',
            icon: const Icon(Icons.notifications),
            onPressed: () {},
          ),
          SizedBox(width: 8),
          IconButton(
            tooltip: 'Alternar tema',
            icon: Icon(
              themeController.themeMode.value == ThemeMode.dark
                  ? Icons.wb_sunny
                  : Icons.nightlight_round,
            ),
            onPressed: () {
              themeController.toggleTheme();
            },
          ),
          SizedBox(width: 16),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: drawerList(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 32),
                Text(
                  'Bem-vindo, ${controller.userName}!',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Cotar e Contratar',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 12),
                LayoutBuilder(
                  builder: (context, constraints) {
                    int crossAxisCount = constraints.maxWidth < 600 ? 2 : 4;
                    return GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 2,
                      children: [
                        _buildCotacaoCard(
                          icon: Icons.directions_car,
                          label: 'Automóvel',
                          onPressed: () => controller.abrirAutomovel(context),
                        ),
                        _buildCotacaoCard(
                          icon: Icons.house,
                          label: 'Residência',
                          onPressed: () => controller.abrirResidencia(context),
                        ),
                        _buildCotacaoCard(
                          icon: Icons.favorite,
                          label: 'Vida',
                          onPressed: () {},
                        ),
                        _buildCotacaoCard(
                          icon: Icons.health_and_safety,
                          label: 'Acidentes Pessoais',
                          onPressed: () {},
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 32),

                /// Minha Família
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Minha Família',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    IconButton(
                      tooltip: 'Adicionar membro',
                      icon: const Icon(Icons.person_add),
                      onPressed: () {},
                    ),
                  ],
                ),
                Card(
                  child: SizedBox(
                    height: 80,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsetsGeometry.fromLTRB(32, 0, 32, 0),
                        child: Text(
                          'Adicione aqui membros da sua familia e compartilhe os seguros com eles',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                /// Contratados
                Text(
                  'Contratados',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Card(
                  child: SizedBox(
                    height: 80,
                    child: Center(
                      child: Text(
                        'Nenhum seguro contratado',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCotacaoCard({
    required IconData icon,
    required String label,
    required VoidCallback? onPressed,
  }) {
    return SizedBox(
      width: 140,
      height: 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(8.0),
        ),
        onPressed: onPressed,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: Colors.white),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  // Seu drawerList e buildDrawerItem ficam como já estavam
  List<Widget> drawerList(BuildContext context) {
    return [
      buildDrawerHeader(),
      buildDrawerItem(
        context,
        icon: Icons.home,
        text: 'Home/Seguros',
        onTap: () {
          Navigator.pop(context);
        },
      ),
      buildDrawerItem(
        context,
        icon: Icons.assignment,
        text: 'Minhas Contratações',
        onTap: () {},
      ),
      buildDrawerItem(
        context,
        icon: Icons.warning,
        text: 'Meus Sinistros',
        onTap: () {},
      ),
      buildDrawerItem(
        context,
        icon: Icons.group,
        text: 'Minha Família',
        onTap: () {},
      ),
      buildDrawerItem(
        context,
        icon: Icons.home_work,
        text: 'Meus Bens',
        onTap: () {},
      ),
      buildDrawerItem(
        context,
        icon: Icons.payment,
        text: 'Pagamentos',
        onTap: () {},
      ),
      buildDrawerItem(
        context,
        icon: Icons.shield,
        text: 'Coberturas',
        onTap: () {},
      ),
      buildDrawerItem(
        context,
        icon: Icons.qr_code,
        text: 'Validar Boleto',
        onTap: () {},
      ),
      buildDrawerItem(
        context,
        icon: Icons.phone,
        text: 'Telefones Importantes',
        onTap: () {},
      ),
      buildDrawerItem(
        context,
        icon: Icons.settings,
        text: 'Configurações',
        onTap: () {},
      ),
    ];
  }

  Widget buildDrawerHeader() {
    return UserAccountsDrawerHeader(
      accountName: Text(controller.userName),
      accountEmail: null,
      currentAccountPicture: CircleAvatar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        child: const Icon(Icons.person, size: 48, color: Colors.white),
      ),
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary),
    );
  }

  Widget buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
      title: Text(text),
      onTap: onTap,
    );
  }
}
