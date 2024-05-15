import 'package:flutter/material.dart';
import 'package:helios_test/core/model/navigation_arguments/detail_page_arguments.dart';
import 'package:helios_test/core/model/user.dart';
import 'package:helios_test/core/use_case/get_user_usecase.dart';
import 'package:helios_test/data/repository/users_repository.dart';
import 'package:helios_test/presentation/detail_page.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  final String title;
  final UsersRepository usersRepository;

  const MyHomePage({super.key, required this.title, required this.usersRepository});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const _pageSize = 20;

  final PagingController<int, User> _pagingController =
  PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final List<User> users = await GetUsersUseCase(usersRepository: widget.usersRepository).execute();
      final isLastPage = users.length < _pageSize;
      if (isLastPage) {
        _pagingController.appendLastPage(users);
      } else {
        final nextPageKey = pageKey + users.length;
        _pagingController.appendPage(users, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: PagedListView<int, User>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate<User>(
          itemBuilder: (context, item, index) => UserListItem(
            user: item,
          ),
        ),
      )
    );
  }
}

class UserListItem extends StatelessWidget {
  final User user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pushNamed(DetailPage.routeName, arguments: DetailPageArguments(user)),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 24.0),
          child: Row(
            children: [
              Text(user.name.first),
              const SizedBox(width: 10),
              Text(user.name.last),
              const Divider(height: 2),
            ],
          ),
        ),
      ),
    );
  }
}
