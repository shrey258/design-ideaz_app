import 'package:flutter/material.dart';

import 'package:design_ideaz_app/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:design_ideaz_app/providers/cart_provider.dart';
import 'package:design_ideaz_app/screens/cart_screen.dart';

class Course {
  final String title;
  final String duration;
  final int lessonCount;
  final double rating;
  final String imageUrl;
  final List<Lesson> lessons;
  final double price;

  Course({
    required this.title,
    required this.duration,
    required this.lessonCount,
    required this.rating,
    required this.imageUrl,
    required this.lessons,
    required this.price,
  });
}

class Lesson {
  final String title;
  final String duration;

  Lesson({required this.title, required this.duration});
}

class CourseOverviewScreen extends StatefulWidget {
  final Course course;

  const CourseOverviewScreen({super.key, required this.course});

  @override
  _CourseOverviewScreenState createState() => _CourseOverviewScreenState();
}

class _CourseOverviewScreenState extends State<CourseOverviewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showTitle = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset > 200 && !_showTitle) {
      setState(() => _showTitle = true);
    } else if (_scrollController.offset <= 200 && _showTitle) {
      setState(() => _showTitle = false);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.4,
            pinned: true,
            elevation: 0,
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.course.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Theme.of(context).primaryColor.withOpacity(0.1),
                        child: Icon(
                          Icons.image_not_supported,
                          size: context.responsiveSize(50),
                          color: Theme.of(context).primaryColor,
                        ),
                      );
                    },
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: context.responsiveSize(48),
                    left: context.responsiveSize(16),
                    right: context.responsiveSize(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.course.title,
                          style: context.textTheme.headlineSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        SizedBox(height: context.responsiveSize(8)),
                        Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              size: context.responsiveSize(16),
                              color: Colors.white70,
                            ),
                            SizedBox(width: context.responsiveSize(4)),
                            Expanded(
                              child: Text(
                                '${widget.course.duration} • ${widget.course.lessonCount} lessons',
                                style: context.textTheme.bodySmall?.copyWith(
                                  color: Colors.white70,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            _buildRatingChip(context),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              title: AnimatedOpacity(
                opacity: _showTitle ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Text(
                  widget.course.title,
                  style: context.textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: _showTitle
                    ? Theme.of(context).primaryColor
                    : Colors.white,
              ),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              Consumer(
                builder: (context, ref, child) {
                  final cartItems = ref.watch(cartProvider);
                  return Stack(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.shopping_cart_outlined,
                          color: _showTitle
                              ? Theme.of(context).primaryColor
                              : Colors.white,
                        ),
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CartScreen(),
                          ),
                        ),
                      ),
                      if (cartItems.isNotEmpty)
                        Positioned(
                          right: context.responsiveSize(8),
                          top: context.responsiveSize(8),
                          child: Container(
                            padding: EdgeInsets.all(context.responsiveSize(2)),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(
                                context.responsiveSize(10),
                              ),
                            ),
                            constraints: BoxConstraints(
                              minWidth: context.responsiveSize(16),
                              minHeight: context.responsiveSize(16),
                            ),
                            child: Text(
                              '${cartItems.length}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: context.responsiveSize(10),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ],
            bottom: TabBar(
              controller: _tabController,
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.grey,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Lessons'),
                Tab(text: 'Reviews'),
              ],
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildOverviewTab(context),
            _buildLessonsTab(context),
            _buildReviewsTab(context),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(context),
    );
  }

  Widget _buildRatingChip(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star, size: 16, color: Colors.white),
          SizedBox(width: 4),
          Text(
            widget.course.rating.toStringAsFixed(1),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildOverviewTab(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(context.responsiveSize(16)),
      children: [
        _buildSectionTitle(context, 'About this course'),
        SizedBox(height: context.responsiveSize(8)),
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
          style: context.textTheme.bodyMedium,
        ),
        SizedBox(height: context.responsiveSize(24)),
        _buildSectionTitle(context, 'What you\'ll learn'),
        SizedBox(height: context.responsiveSize(8)),
        _buildLearningObjectives(context),
        SizedBox(height: context.responsiveSize(24)),
        _buildSectionTitle(context, 'Requirements'),
        SizedBox(height: context.responsiveSize(8)),
        _buildRequirements(context),
      ],
    );
  }

  Widget _buildLessonsTab(BuildContext context) {
    return ListView.builder(
      itemCount: widget.course.lessons.length,
      itemBuilder: (context, index) {
        final lesson = widget.course.lessons[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child:
                  Text('${index + 1}', style: TextStyle(color: Colors.white)),
            ),
            title: Text(lesson.title,
                style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(lesson.duration,
                style: Theme.of(context).textTheme.bodySmall),
            trailing: Icon(Icons.play_circle_outline,
                color: Theme.of(context).primaryColor),
            onTap: () {
              // TODO: Implement lesson navigation
            },
          ),
        );
      },
    );
  }

  Widget _buildReviewsTab(BuildContext context) {
    // TODO: Implement reviews tab
    return Center(child: Text('Reviews coming soon'));
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Text(
      title,
      style: Theme.of(context)
          .textTheme
          .titleLarge
          ?.copyWith(fontWeight: FontWeight.bold),
    );
  }

  Widget _buildLearningObjectives(BuildContext context) {
    final objectives = [
      'Understand the basics of the course topic',
      'Apply learned concepts to real-world scenarios',
      'Develop practical skills through hands-on exercises',
      'Master advanced techniques in the subject area',
    ];

    return Column(
      children: objectives
          .map((objective) => _buildObjectiveItem(context, objective))
          .toList(),
    );
  }

  Widget _buildObjectiveItem(BuildContext context, String objective) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle,
              color: Theme.of(context).primaryColor, size: 20),
          SizedBox(width: 8),
          Expanded(
            child:
                Text(objective, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildRequirements(BuildContext context) {
    final requirements = [
      'Basic understanding of the subject',
      'Access to a computer with internet connection',
      'Willingness to learn and practice',
    ];

    return Column(
      children: requirements
          .map((req) => _buildRequirementItem(context, req))
          .toList(),
    );
  }

  Widget _buildRequirementItem(BuildContext context, String requirement) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.fiber_manual_record,
              color: Theme.of(context).primaryColor, size: 12),
          SizedBox(width: 8),
          Expanded(
            child: Text(requirement,
                style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomBar(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final cartItems = ref.watch(cartProvider);
        final isInCart = cartItems.contains(widget.course);
        
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: context.responsiveSize(20),
            vertical: context.responsiveSize(16),
          ),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          child: SafeArea(
            child: Row(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${widget.course.price.toStringAsFixed(2)}',
                      style: context.textTheme.headlineMedium?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Lifetime Access',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
                SizedBox(width: context.responsiveSize(20)),
                Expanded(
                  child: Container(
                    height: context.responsiveSize(56),
                    child: ElevatedButton(
                      onPressed: () {
                        if (isInCart) {
                          ref.read(cartProvider.notifier).removeFromCart(widget.course);
                        } else {
                          ref.read(cartProvider.notifier).addToCart(widget.course);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: context.responsiveSize(24),
                          vertical: context.responsiveSize(16),
                        ),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          isInCart ? 'Remove from Cart' : 'Add to Cart',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: context.responsiveSize(18),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
