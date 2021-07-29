class PaliBook {
  final int id;
  final String pHTM;

//Select id, P_HTM from pali
  PaliBook({
    this.id = 0,
    this.pHTM = 'no_text',
  });

  factory PaliBook.fromJson(Map<dynamic, dynamic> json) {
    return PaliBook(id: json['id'], pHTM: json['P_HTM']);
  }
}
