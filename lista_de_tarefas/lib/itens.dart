class Item {
  String titulo;
  bool concluido;

  Item({required this.titulo, required this.concluido});

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'concluido': concluido,
    };
  }

  factory Item.fromJson(Map<String, dynamic> json) {
    return Item(
      titulo: json['titulo'],
      concluido: json['concluido'],
    );
  }
}
