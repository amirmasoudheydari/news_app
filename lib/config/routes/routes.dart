import 'package:flutter/material.dart';
import 'package:untitled1/core/constant/constants.dart';
import 'package:untitled1/features/daily_news/domain/entities/article.dart';
import 'package:untitled1/features/daily_news/presentation/pages/article_detail/article_detail.dart';
import 'package:untitled1/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:untitled1/features/daily_news/presentation/pages/save_article/save_article.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const DailyNews());
      case articleDetailView:
        return _materialRoute(
            ArticleDetailView(article: settings.arguments as ArticleEntity));
      case saveArticleView:
        return _materialRoute(const SaveArticlePage());
      default:
        return _materialRoute(const DailyNews());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
