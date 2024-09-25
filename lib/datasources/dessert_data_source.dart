import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:myapp/models/dessert.dart';
import 'package:myapp/pages/datatable.dart';

class DessertDataSource extends DataTableSource {
  // Constructor for DessertDataSource class, takes a BuildContext argument
  DessertDataSource(this.context) {
    // Initialize the list of desserts
    desserts = <Dessert>[
      Dessert(
        'laptop Lenovo',
        10000000,
        15,
        15,
        
      ),

      Dessert(
        'Ponsel Pintar Iphone 13',
        12500000,
        20,
        15,

      ),
      Dessert(
        'TV Pintar LG 55 Inci',
        8000000,
        15,
        15,

      ),
      Dessert(
        'Kamera DSLR Canon 700D',
        65000000,
        18,
        15,

      ),
      Dessert(
        'Printer Canon Pixma',
        2750000,
        10,
        15,

      ),

     
       ];
  }

  // The BuildContext passed to the constructor
  final BuildContext context;

  // List of desserts
  late List<Dessert> desserts;

  // Number of selected desserts
  int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    // Number formatter for percentages
   
    // Make sure index is valid
    assert(index >= 0);
    if (index >= desserts.length) return null;

    // logging flutter
    var logger = Logger();
    logger.i(desserts.length);

    final dessert = desserts[index];

    // Create the DataRow with cells for each dessert property
    return DataRow.byIndex(
      index: index,
      selected: dessert.selected,
      onSelectChanged: (value) {
        // Update the selected count and dessert selection
        if (dessert.selected != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          dessert.selected = value;
          notifyListeners();
        }
      },
      cells: [
        DataCell(Text(dessert.name)),
        DataCell(Text('${dessert.calories}')),
        DataCell(Text(dessert.fat.toStringAsFixed(1))),
        DataCell(Text('${dessert.carbs}')),
        ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => desserts.length;

  @override
  int get selectedRowCount => _selectedCount;

  // Select or deselect all rows
  void selectAll(bool? checked) {
    for (final dessert in desserts) {
      dessert.selected = checked ?? false;
    }
    _selectedCount = checked! ? desserts.length : 0;
    notifyListeners();
  }

  // Sort the desserts by a given field
  void sort<T>(Comparable<T> Function(Dessert d) getField, bool ascending) {
    desserts.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending
          ? Comparable.compare(aValue, bValue)
          : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  // Update the selected desserts
  void updateSelectedDesserts(RestorableDessertSelections selectedRows) {
    _selectedCount = 0;
    for (var i = 0; i < desserts.length; i += 1) {
      var dessert = desserts[i];
      if (selectedRows.isSelected(i)) {
        dessert.selected = true;
        _selectedCount += 1;
      } else {
        dessert.selected = false;
      }
    }
    notifyListeners();
  }
}
