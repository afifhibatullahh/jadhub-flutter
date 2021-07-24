import 'package:flutter/material.dart';
import 'package:jadhub_flutter/model/menu_item.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemEdit,
    itemDelete,
    itemShare
  ];
  static const itemDelete = MenuItem(text: 'Hapus', icon: Icons.delete);
  static const itemEdit = MenuItem(text: 'Ubah', icon: Icons.edit_sharp);
  static const itemShare = MenuItem(text: 'Bagikan', icon: Icons.share);
}
