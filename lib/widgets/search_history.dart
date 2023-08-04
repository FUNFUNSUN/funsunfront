import 'dart:collection';

final class HistoryItem extends LinkedListEntry<HistoryItem> {
  final String id;
  final String username;
  final String? image;
  HistoryItem(this.id, this.username, this.image);

  @override
  String toString() {
    return '$id : $username';
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> data = {
      'id': id,
      'username': username,
      'image': image
    };
    return data;
  }
}

void main() {
  final linkedList = LinkedList<HistoryItem>();
  linkedList.addAll([
    HistoryItem('1', 'A', 'a'),
    HistoryItem('2', 'B', 'b'),
    HistoryItem('3', 'C', 'c')
  ]);
  print(linkedList.first); // 1 : A
  print(linkedList.last); // 3 : C

  // Add new item after first item.
  linkedList.first.insertAfter(HistoryItem('15', 'E', 'e'));
  // Add new item before last item.
  linkedList.last.insertBefore(HistoryItem('10', 'D', 'e'));
  // Iterate items.
  for (var entry in linkedList) {
    print(entry.toMap());
    // 1 : A
    // 15 : E
    // 2 : B
    // 10 : D
    // 3 : C
  }

  // Remove item using index from list.
  linkedList.elementAt(2).unlink();
  print(linkedList); // (1 : A, 15 : E, 10 : D, 3 : C)
  // Remove first item.
  linkedList.first.unlink();
  print(linkedList); // (15 : E, 10 : D, 3 : C)
  // Remove last item from list.
  linkedList.remove(linkedList.last);
  print(linkedList); // (15 : E, 10 : D)
  // Remove all items.
  linkedList.clear();
  print(linkedList.length); // 0
  print(linkedList.isEmpty); // true
}
