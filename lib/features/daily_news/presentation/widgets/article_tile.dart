import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final bool? isRemovable;
  final void Function(ArticleEntity article)? onRemove;
  final void Function(ArticleEntity)? onArticlePressed;

  const ArticleWidget(
      {super.key,
      this.article,
      this.isRemovable = false,
      this.onRemove,
      this.onArticlePressed});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: _onTap,
        child: Container(
            padding: const EdgeInsetsDirectional.only(
                start: 14, end: 14, top: 7, bottom: 7),
            height: screenWidth / 2.2,
            child: Row(children: [
              _buildImage(context),
              _buildTitleAndImage(context),
              _buildRemovableArea(context)
            ])));
  }

  Widget _buildImage(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return CachedNetworkImage(
        imageUrl: article!.urlToImage != null ? article!.urlToImage! : '',
        imageBuilder: (context, imageProvider) {
          return Padding(
              padding: const EdgeInsets.only(right: 14),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                      width: screenWidth / 3,
                      height: double.maxFinite,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.cover)))));
        },
        progressIndicatorBuilder: (context, url, downloadProgress) => Padding(
            padding: const EdgeInsets.only(right: 14),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: screenWidth / 3,
                  height: double.maxFinite,
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.08)),
                  child: const CupertinoActivityIndicator(),
                ))),
        errorWidget: (context, url, error) => Padding(
            padding: const EdgeInsets.only(right: 14),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                height: double.maxFinite,
                width: screenWidth / 3,
                decoration:
                    BoxDecoration(color: Colors.black.withOpacity(0.08)),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: const Icon(Icons.error)),
              ),
            )));
  }

  Widget _buildTitleAndImage(BuildContext context) {
    return Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // title
                  Text(article!.title ?? '',
                      style: const TextStyle(
                          fontFamily: 'Butler',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87)),

                  // description
                  Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child:
                              Text(article!.description ?? '', maxLines: 2))),
                  // Datetime
                  Row(children: [
                    const Icon(Icons.timeline_outlined, size: 16),
                    const SizedBox(width: 4),
                    Text(article!.publishedAt!,
                        style: const TextStyle(fontSize: 12))
                  ])
                ])));
  }

  Widget _buildRemovableArea(BuildContext context) {
    if (isRemovable!) {
      return GestureDetector(
          onTap: _onRemove,
          child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Icon(Icons.remove_circle_outline, color: Colors.red)));
    }

    return Container();
  }

  void _onTap() {
    if (onArticlePressed != null) {
      onArticlePressed!(article!);
    }
  }

  void _onRemove() {
    if (onRemove != null) {
      onRemove!(article!);
    }
  }
}
