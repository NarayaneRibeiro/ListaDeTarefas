import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/itens.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lista de tarefas',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Item> itens = [];
  final controlar = TextEditingController();

  void load() async {
    final armazenar = await SharedPreferences.getInstance();
    var data = armazenar.getString('data');

    if (data != null) {
      Iterable decoded = jsonDecode(data);
      List<Item> resultado = decoded.map((e) => Item.fromJson(e)).toList();
      setState(() {
        itens = resultado;
      });
    }
  }

  void salvar() async {
    final armazenar = await SharedPreferences.getInstance();
    await armazenar.setString('data', jsonEncode(itens));
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de tarefas da Nara:',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.purple[900],
        //leading: <Widget>[Icon(Icons.density_medium_rounded)],
        //actions: <Widget>[Icon(Icons.density_medium_sharp)],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: controlar,
                  keyboardType: TextInputType.text,
                  decoration:
                      const InputDecoration(labelText: 'Insira sua tarefa:'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: itens.length,
              itemBuilder: (BuildContext context, int index) {
                final item = itens[index];
                return Dismissible(
                  key: Key(item.titulo),
                  background: const Text(
                    'Excluir',
                    textAlign: TextAlign.right,
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      setState(() {
                        itens.removeAt(index);
                        salvar();
                      });
                    }
                  },
                  child: CheckboxListTile(
                    title: Text(item.titulo),
                    value: item.concluido,
                    onChanged: (value) {
                      setState(() {
                        item.concluido = value ?? false;
                        salvar();
                      });
                    },
                  ),
                );
              },
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.purple[900],
        onPressed: () {
          setState(
            () {
              itens.add(
                Item(titulo: controlar.text, concluido: false),
              );
              salvar();
              controlar.clear();
            },
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
