// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class BookModel extends Equatable {
  final String id;
  final String userId;
  final String bookName;
  final String author;
  final String bookType;
  final int totalPages;
  final Timestamp createdAt;
  final bool isReaded;

  const BookModel({
    required this.id,
    required this.userId,
    required this.bookName,
    required this.author,
    required this.bookType,
    required this.totalPages,
    required this.createdAt,
    required this.isReaded,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'user_id': userId,
      'book_name': bookName,
      'author': author,
      'book_type': bookType,
      'total_pages': totalPages,
      'created_at': createdAt,
      'is_readed': isReaded,
    };
  }

  factory BookModel.fromJson(Map<String, dynamic> json) {
    return BookModel(
      id: json['id']! as String,
      userId: json['user_id']! as String,
      bookName: json['book_name']! as String,
      author: json['author']! as String,
      bookType: json['book_type']! as String,
      totalPages: json['total_pages']! as int,
      createdAt: json['created_at']! as Timestamp,
      isReaded: json['is_readed']! as bool,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      userId,
      bookName,
      author,
      bookType,
      totalPages,
      createdAt,
      isReaded,
    ];
  }
}
