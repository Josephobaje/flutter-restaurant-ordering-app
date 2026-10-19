import 'package:dineorder/logic.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('categories and filter', () {
    expect(categories, containsAll(['Mains', 'Drinks']));
    expect(byCategory('Drinks').length, 2);
  });
  test('cart total', () {
    final c = Cart();
    c.add(menu[0]);
    c.add(menu[5]);
    c.add(menu[5]);
    expect(c.total, 7500);
    expect(c.count, 3);
  });
  test('kitchen board', () {
    expect(board.length, 3);
    expect(board[1].status, 'Ready');
  });
}
