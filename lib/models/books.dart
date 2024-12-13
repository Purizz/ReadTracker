class Book {
  final String title;
  final String author;
  final int totalPages;
  int pagesRead;
  bool isFinished;

  Book({
    required this.title,
    required this.author,
    required this.totalPages,
    this.pagesRead = 0,
    this.isFinished = false, required String id,
  });

  // Fungsi untuk memperbarui jumlah halaman yang dibaca
  void updatePagesRead(int pages) {
    if (pages <= totalPages) {
      pagesRead = pages;
    } else {
      throw Exception("Pages read cannot exceed total pages.");
    }
  }
}
