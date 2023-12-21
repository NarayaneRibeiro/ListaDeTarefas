class Item {
  String titulo;
  bool concluido;

  Item({
    required this.titulo,
    required this.concluido,
  });

  Item.fromJson(Map<String, dynamic> json)
      : titulo = json['titulo'] ?? '',
        concluido = json['concluido'] ?? false;

  Map<String, dynamic> toJson() {
    return {
      'titulo': titulo,
      'concluido': concluido,
    };
  }
}
