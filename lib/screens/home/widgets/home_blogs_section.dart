// Social-style community posts with media and engagement actions.
import 'package:flutter/material.dart';
import 'package:booking_appointment_app/data/home_data.dart';

// Displays posts with local like state, share feedback, and view counts.
class HomeBlogsSection extends StatefulWidget {
  const HomeBlogsSection({super.key});

  @override
  State<HomeBlogsSection> createState() => _HomeBlogsSectionState();
}

class _HomeBlogsSectionState extends State<HomeBlogsSection> {
  // Stores only local like changes until a backend is connected.
  final Set<int> _likedPosts = <int>{};

  @override
  Widget build(BuildContext context) {
    // Render the section heading followed by the configured post feed.
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Blogs',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 16),
          ..._buildPosts(),
        ],
      ),
    );
  }

  List<Widget> _buildPosts() {
    // Add spacing between posts without leaving trailing empty space.
    return [
      for (var index = 0; index < HomeData.posts.length; index++) ...[
        _buildPost(HomeData.posts[index]),
        if (index < HomeData.posts.length - 1) const SizedBox(height: 16),
      ],
    ];
  }

  Widget _buildPost(HomePost post) {
    // Derive the displayed like state from the local interaction set.
    final isLiked = _likedPosts.contains(post.id);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post author and timestamp row.
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            child: Row(
              children: [
                const CircleAvatar(
                  backgroundColor: Color(0xFFE7F5F3),
                  child: Icon(Icons.local_hospital, color: Color(0xFF0D9488)),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.author,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        post.authorSubtitle,
                        style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
          ),
          // Post poster image with a fallback for unavailable media.
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Image.network(
              post.imageUrl,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFFE7F5F3),
                  child: const Center(
                    child: Icon(
                      Icons.health_and_safety,
                      color: Color(0xFF0D9488),
                      size: 64,
                    ),
                  ),
                );
              },
            ),
          ),
          // Post description supplied by the data layer.
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
            child: Text(
              post.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.black87,
                height: 1.45,
              ),
            ),
          ),
          // Like, share, and view actions for the post.
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
            child: Row(
              children: [
                // The entire like action, including its count, is clickable.
                Expanded(
                  child: _buildPostAction(
                    icon: isLiked ? Icons.favorite : Icons.favorite_border,
                    label: '${post.likes + (isLiked ? 1 : 0)}',
                    iconColor: isLiked ? Colors.redAccent : Colors.grey.shade700,
                    tooltip: isLiked ? 'Unlike' : 'Like',
                    onTap: () {
                      // Toggle the local like state for this post.
                      setState(() {
                        if (isLiked) {
                          _likedPosts.remove(post.id);
                        } else {
                          _likedPosts.add(post.id);
                        }
                      });
                    },
                  ),
                ),
                // The entire share action, including its label, is clickable.
                Expanded(
                  child: _buildPostAction(
                    icon: Icons.share_outlined,
                    label: 'Share',
                    tooltip: 'Share post',
                    onTap: () {
                      // Temporary feedback until a real share service is added.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Share link copied')),
                      );
                    },
                  ),
                ),
                // Keep views in the same clickable container as its count.
                Expanded(
                  child: _buildPostAction(
                    icon: Icons.visibility_outlined,
                    label: _formatCount(post.views),
                    tooltip: 'Views',
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatCount(int count) {
    // Keep large view totals compact in the narrow action row.
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  // Builds one shared hit area for an action icon and its text.
  Widget _buildPostAction({
    required IconData icon,
    required String label,
    required String tooltip,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Tooltip(
      message: tooltip,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: iconColor ?? Colors.grey.shade700, size: 21),
                const SizedBox(width: 6),
                Flexible(child: Text(label, style: _statStyle)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static const _statStyle = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: Colors.grey,
  );
}