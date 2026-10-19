import 'package:flutter/material.dart';

import 'logic.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext c) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'DineOrder NG',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xFF0B2A4A),
        secondary: const Color(0xFF00BCD4),
      ),
      useMaterial3: true,
    ),
    home: const Home(),
  );
}

String naira(num v) =>
    '₦${v.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\B)(?=(\d{3})+(?!\d))'), (m) => ',')}';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _S();
}

class _S extends State<Home> {
  int tab = 0;
  String cat = 'Mains';
  final cart = Cart();
  @override
  Widget build(BuildContext c) => Scaffold(
    appBar: AppBar(title: const Text('DineOrder NG')),
    body: [_menu(), _cart(), _board()][tab],
    bottomNavigationBar: NavigationBar(
      selectedIndex: tab,
      onDestinationSelected: (i) => setState(() => tab = i),
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.restaurant_menu),
          label: 'Menu',
        ),
        NavigationDestination(
          icon: Badge(
            label: Text('${cart.count}'),
            child: const Icon(Icons.shopping_cart),
          ),
          label: 'Cart',
        ),
        const NavigationDestination(
          icon: Icon(Icons.soup_kitchen),
          label: 'Kitchen',
        ),
      ],
    ),
  );
  Widget _menu() => Column(
    children: [
      Wrap(
        spacing: 8,
        children: categories
            .map(
              (x) => ChoiceChip(
                label: Text(x),
                selected: cat == x,
                onSelected: (_) => setState(() => cat = x),
              ),
            )
            .toList(),
      ),
      Expanded(
        child: ListView(
          children: byCategory(cat)
              .map(
                (m) => ListTile(
                  title: Text(m.name),
                  subtitle: Text(naira(m.price)),
                  trailing: IconButton(
                    icon: const Icon(Icons.add_circle),
                    onPressed: () => setState(() => cart.add(m)),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    ],
  );
  Widget _cart() => Padding(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Table 4 / QR order'),
        ...cart.items.entries.map((e) => Text('${e.key.name} x${e.value}')),
        Text(
          'Total: ${naira(cart.total)}',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const Text('Payment placeholder - pay at counter or test checkout.'),
        ElevatedButton(
          onPressed: cart.total == 0 ? null : () {},
          child: const Text('Send to kitchen'),
        ),
      ],
    ),
  );
  Widget _board() => ListView(
    children: board
        .map(
          (o) => ListTile(
            title: Text(o.table),
            subtitle: Text(naira(o.total)),
            trailing: Chip(label: Text(o.status)),
          ),
        )
        .toList(),
  );
}
