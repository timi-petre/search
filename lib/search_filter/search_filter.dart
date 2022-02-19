import 'package:flutter/material.dart';
import 'package:search/search_filter/books.dart';

import 'book_page.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key? key}) : super(key: key);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  final TextEditingController controller = TextEditingController();
  List<Book> books = allBooks;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search & Filter'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Book Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(color: Colors.blue),
                ),
              ),
              onChanged: searchBook,
            ),
          ),
          Expanded(
              child: ListView.builder(
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              final book = books[index];

              return ListTile(
                leading: Image.network(
                  book.urlImage,
                  fit: BoxFit.cover,
                  width: 50,
                  height: 50,
                ),
                title: Text(book.title),
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) =>
                            BookPage(book: book))),
              );
            },
          ))
        ],
      ),
    );
  }

  void searchBook(String query) {
    final suggestions = allBooks.where((book) {
      final bookTitle = book.title.toLowerCase();
      final input = query.toLowerCase();

      return bookTitle.contains(input);
    }).toList();
    setState(() => books = suggestions);
  }
}
