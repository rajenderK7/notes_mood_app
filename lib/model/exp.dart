class Quote {
  final String quote;
  final String author;

  Quote({required this.quote, required this.author});

  static Quote fromJson(Map<String, dynamic> json) {
    return Quote(quote: json['quote'] ?? "", author: json['author'] ?? "");
  }

  factory Quote.fromRTDB(Map<String, dynamic> data) {
    return Quote(quote: data['customer'] ?? "", author: data['id']);
  }

  Map<String, dynamic> toJson() {
    return {
      'quote': quote,
      'author': author,
    };
  }
}
