import 'package:flutter/material.dart';
import 'package:lista_de_tarefas/itens.dart';

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
  //HomePage({super.key});
  final List<Item> itens;

  HomePage() : itens = [];
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  var controlar = TextEditingController();
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
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                TextFormField(
                  controller: controlar,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Insira sua tarefa:'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.itens.length,
              itemBuilder: (BuildContext context, int index) {
                final item = widget.itens[index];
                return CheckboxListTile(
                  title: Text(item.titulo),
                  key: Key(item.titulo),
                  value: item.concluido,
                  onChanged: (value) {
                    setState(() {
                      item.concluido = value ?? false;
                    });
                  },
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
              widget.itens.add(
                Item(titulo: controlar.text, concluido: false),
              );
              controlar.clear();
            },
          );
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
