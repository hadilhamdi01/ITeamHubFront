import 'package:flutter/material.dart';

class CommunityCard extends StatelessWidget {
  final Community community;

  const CommunityCard({Key? key, required this.community}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nom de la communauté
            Text(
              community.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Nombre de publications
            Text(
              "${community.posts.length} posts",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 12),

            // Aperçu du premier post
            if (community.posts.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Latest Post:",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    community.posts.first.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    community.posts.first.content,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                    ),
                  ),
                ],
              )
            else
              const Text(
                "No posts yet",
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
class Community {
  final String name;
  final List<Post> posts;

  Community({required this.name, required this.posts});

  // Méthode pour convertir un JSON en une instance de Community
  factory Community.fromJson(Map<String, dynamic> json) {
    var postList = json['posts'] as List<dynamic>? ?? [];
    return Community(
      name: json['name'] ?? 'Unknown',
      posts: postList.map((post) => Post.fromJson(post)).toList(),
    );
  }
}

class Post {
  final String title;
  final String content;

  Post({required this.title, required this.content});

  // Méthode pour convertir un JSON en une instance de Post
  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      title: json['title'] ?? 'Untitled',
      content: json['content'] ?? 'No content',
    );
  }
}
