import 'package:equatable/equatable.dart';

class PostEntity extends Equatable {
  final String? title;
  final String? content;
  final String? imageUrl;
  final DateTime? createdDate;
  final String? createdUser;
  final String? createdUserId;

  const PostEntity({
    this.title,
    this.content,
    this.imageUrl,
    this.createdDate,
    this.createdUser,
    this.createdUserId,
  });

  @override
  List<Object?> get props =>
      [title, content, imageUrl, createdDate, createdUser, createdUserId];
}
