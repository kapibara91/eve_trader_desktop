import 'package:eve_trader_desktop/tool/eve_auth_tool.dart' as eve_auth;
import 'package:flutter/material.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('选择人物'),
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              width: 600,
              height: 300,
              color: Colors.black,
              padding: const EdgeInsets.all(12),
              child: GridView.count(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                crossAxisCount: 4,
                children: [
                  _getGridViewItem(),
                  _getGridViewItem(),
                  _getGridViewItem(),
                  _getGridViewItem(),
                  _getGridViewItem(),
                  _getGridViewItem(),
                ],
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              eve_auth.toAuth();
            },
            child: const Text('添加人物'),
          ),

        ],
      ),
    );
  }

  Widget _getGridViewItem() {
    return Container(
      color: Colors.red,
    );
  }
}
