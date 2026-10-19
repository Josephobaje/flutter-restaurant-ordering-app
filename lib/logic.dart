class MenuItem {
  final String name;
  final String category;
  final int price;
  const MenuItem(this.name, this.category, this.price);
}

const menu = [
  MenuItem('Jollof Rice and Chicken', 'Mains', 4500),
  MenuItem('Fried Rice and Turkey', 'Mains', 5000),
  MenuItem('Egusi Soup and Poundo', 'Mains', 5500),
  MenuItem('Pepper Soup', 'Starters', 2500),
  MenuItem('Spring Rolls', 'Starters', 2000),
  MenuItem('Chapman', 'Drinks', 1500),
  MenuItem('Fresh Orange Juice', 'Drinks', 1800),
  MenuItem('Chocolate Cake Slice', 'Desserts', 2200),
];
List<String> get categories => menu.map((m) => m.category).toSet().toList();
List<MenuItem> byCategory(String c) =>
    menu.where((m) => m.category == c).toList();

class Cart {
  final Map<MenuItem, int> items = {};
  void add(MenuItem m) => items[m] = (items[m] ?? 0) + 1;
  int get total => items.entries.fold(0, (a, e) => a + e.key.price * e.value);
  int get count => items.values.fold(0, (a, b) => a + b);
}

class KitchenOrder {
  final String table;
  final String status;
  final int total;
  const KitchenOrder(this.table, this.status, this.total);
}

const board = [
  KitchenOrder('Table 4', 'Preparing', 9500),
  KitchenOrder('Table 7', 'Ready', 6800),
  KitchenOrder('QR Takeaway 12', 'Received', 4500),
];
