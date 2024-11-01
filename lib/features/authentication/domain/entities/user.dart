import 'package:equatable/equatable.dart';

class User extends Equatable{
  const User({
    required this.id,
    required this.createdAt,
    required this.name,
    required this.avatar,
  });

  const User.empty()
      : this(
    id: '1',
    createdAt: '_empty.createdAt',
    name: '_empty.name',
    avatar: '_empty.avatar',
  );

  final String id;
  final String createdAt;
  final String name;
  final String avatar;

  @override
  List<Object?> get props => [id, name, avatar];
}

// {
// "createdAt": "2023-08-04T08:50:46.501Z",
// "name": "Lucille Dooley",
// "avatar": "https://cloudflare-ipfs.com/ipfs/Qmd3W5DuhgHirLHGVixi6V76LhCkZUz6pnFt5AJBiyvHye/avatar/1203.jpg",
// "id": "1"
// }
