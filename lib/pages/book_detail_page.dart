import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../model/book.dart';
import '../widgets/book_detail_view.dart';

class BookDetailPage extends StatelessWidget {
  final Book? book;
  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
        title: const Text('Book'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle_outlined),
            onPressed: () => context.goNamed('profile'),
          ),
        ],
      ),
      body: book == null
          ? const Center(child: Text('Book not found'))
          : BookDetailView(book: book!),
    );
  }
}