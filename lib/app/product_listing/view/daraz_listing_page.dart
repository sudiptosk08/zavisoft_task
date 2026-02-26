import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:price_updating/app/product_listing/controller/daraz_listing_controller.dart';
import 'package:price_updating/app/product_listing/model/product_model.dart';
import 'package:price_updating/utils/colors/app_colors.dart';

class DarazListingPage extends StatefulWidget {
  const DarazListingPage({super.key});

  @override
  State<DarazListingPage> createState() => _DarazListingPageState();
}

class _DarazListingPageState extends State<DarazListingPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  late final DarazListingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<DarazListingController>();
    _tabController = TabController(length: _controller.tabs.length, vsync: this)
      ..addListener(() {
        if (!_tabController.indexIsChanging) {
          _controller.onTabChanged(_tabController.index);
        }
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleHorizontalSwipe(DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity.abs() < 300) return;

    if (velocity < 0 && _tabController.index < _tabController.length - 1) {
      _tabController.animateTo(_tabController.index + 1);
    } else if (velocity > 0 && _tabController.index > 0) {
      _tabController.animateTo(_tabController.index - 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor: KColors.white,
        body: GestureDetector(
          onHorizontalDragEnd: _handleHorizontalSwipe,
          behavior: HitTestBehavior.translucent,
          child: RefreshIndicator(
            onRefresh: _controller.onRefresh,
            child: CustomScrollView(
              controller: _controller.scrollController,
              slivers: [
                // ── Collapsible header ──────────────────────────────────────
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _HeaderPersistentDelegate(
                    child: _buildHeaderContent(),
                    minHeight: 40,
                    maxHeight: 203,
                  ),
                ),

                // ── Sticky tab bar ──────────────────────────────────────────
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _TabBarHeaderDelegate(
                    TabBar(
                      controller: _tabController,
                      labelColor: KColors.primary,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: KColors.primary,
                      tabs: _controller.tabs
                          .map((t) => Tab(text: t.toUpperCase()))
                          .toList(),
                    ),
                  ),
                ),

                // ── Product list ────────────────────────────────────────────
                Obx(() {
                  final products = _controller.productsForCurrentTab;

                  if (_controller.isLoading.value && products.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }

                  if (products.isEmpty) {
                    return const SliverFillRemaining(
                      child: Center(child: Text('No products found')),
                    );
                  }

                  return SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final p = products[index];
                      return _ProductTile(product: p);
                    }, childCount: products.length),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeaderContent() {
    final user = _controller.user.value;
    return AnimatedContainer(
      // FIX: was Duration(microseconds: 200) — basically no animation
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.fromLTRB(16, 40, 16, 16),
      color: KColors.primary.withOpacity(0.95),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 3),
          if (user != null) ...[
            Text(
              'Hi, ${user.fullName.isEmpty ? user.username : user.fullName}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              user.email,
              style: const TextStyle(color: Colors.white70, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              '${user.street}, ${user.city}',
              style: const TextStyle(color: Colors.white70, fontSize: 12),
            ),
          ] else
            const Text(
              'Loading profile...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
          const SizedBox(height: 5),
          // Search bar
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            height: 40,
            child: const Row(
              children: [
                Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Search products',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Collapsible header delegate
// FIX: replaced Align(heightFactor:...) with OverflowBox so the child always
//      gets maxExtent height to render into — preventing the RenderFlex
//      overflow that occurred when natural content height slightly exceeded
//      the constrained box during scroll.
// ─────────────────────────────────────────────────────────────────────────────
class _HeaderPersistentDelegate extends SliverPersistentHeaderDelegate {
  final Widget child;
  final double minHeight;
  final double maxHeight;

  _HeaderPersistentDelegate({
    required this.child,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: ClipRect(
        child: OverflowBox(
          // Always give the child exactly maxExtent to paint into.
          // ClipRect cuts off whatever falls outside the current visible area.
          minHeight: maxExtent,
          maxHeight: maxExtent,
          alignment: Alignment.bottomCenter,
          child: child,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _HeaderPersistentDelegate oldDelegate) {
    return minHeight != oldDelegate.minHeight ||
        maxHeight != oldDelegate.maxHeight ||
        child != oldDelegate.child;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sticky tab bar delegate (unchanged)
// ─────────────────────────────────────────────────────────────────────────────
class _TabBarHeaderDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar;

  _TabBarHeaderDelegate(this.tabBar);

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(color: Colors.white, child: tabBar);
  }

  @override
  bool shouldRebuild(covariant _TabBarHeaderDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar;
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Product tile (unchanged)
// ─────────────────────────────────────────────────────────────────────────────
class _ProductTile extends StatelessWidget {
  final Product product;

  const _ProductTile({required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 80,
              height: 80,
              child: Image.network(product.image, fit: BoxFit.contain),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.category,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
