import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled1/config/routes/routes.dart';
import 'package:untitled1/config/theme/app_themes.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/article/remote_article_bloc.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/article/remote_article_event.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_bloc.dart';
import 'package:untitled1/features/daily_news/presentation/bloc/local/local_article_event.dart';
import 'package:untitled1/features/daily_news/presentation/pages/home/daily_news.dart';
import 'package:untitled1/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependence();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticleBloc>(
            create: (context) =>
                sl<RemoteArticleBloc>()..add(const GetArticle())),
        BlocProvider<LocalArticlesBloc>(
          create: (context) =>
              sl<LocalArticlesBloc>()..add(const GetSavedArticles()),
        )
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRoutes.onGenerateRoute,
          home: const DailyNews()),
    );
  }
}
