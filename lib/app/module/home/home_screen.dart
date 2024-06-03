import 'package:firebase_auth_project/app/core/view/custom/custom_app_bar_widget.dart';
import 'package:firebase_auth_project/app/core/view/custom/custom_loader_widget.dart';
import 'package:firebase_auth_project/app/module/home/home_bloc/all_hero_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../core/services/toast_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    setupScrollController();
    _getHeroes(reload: false);
    super.initState();
  }

  @override
  void dispose() {
    _controller.removeListener(scrollListener);
    _controller.dispose();
    super.dispose();
  }

  void setupScrollController() {
    _controller = ScrollController();
    _controller.addListener(scrollListener);
  }

  void scrollListener() {
    if (_controller.offset >= _controller.position.maxScrollExtent) {
      _getHeroes(reload: false);
    }
  }

  Future<void> _getHeroes({bool reload = true}) async {
    context.read<AllHeroBloc>().add(GetHero(reload));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar("Home"),
      body: BlocListener<AllHeroBloc, AllHeroState>(
        listener: _allHeroBlocListener,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: BlocBuilder<AllHeroBloc, AllHeroState>(
              builder: (context, state) {
                if (state is AllHeroSuccess) {
                  return RefreshIndicator(
                    onRefresh: _getHeroes,
                    child: ListView.separated(
                        controller: _controller,
                        itemBuilder: (context, index) {
                          return index + 1 >= state.hero.length
                              ? Container(
                                  margin: const EdgeInsets.only(bottom: 20),
                                  child: const LoadingWidget(
                                      height: 50, width: 50),
                                )
                              : Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 16),
                                  elevation: 8,
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage(
                                        state.hero[index]['images']['lg'],
                                      ),
                                    ),
                                    title: Text(
                                        state.hero[index]['name'].toString()),
                                    trailing: Text(
                                        "Strength: ${state.hero[index]['powerstats']['strength']}"),
                                  ),
                                );
                        },
                        separatorBuilder: (context, index) => const Gap(5),
                        itemCount: state.hero.length),
                  );
                }
                if (state is AllHeroFailure) {
                  return Center(
                    child: Container(
                      color: Colors.red,
                      child: Text(
                        state.msg,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                }
                return const Center(
                    child: LoadingWidget(height: 200, width: 200));
              },
            )),
          ],
        ),
      ),
    );
  }

  void _allHeroBlocListener(BuildContext context, AllHeroState state) {
    if (state is AllHeroLoading) {}
    if (state is AllHeroSuccess) {
      ToastUtils.success(state.msg);
    }
    if (state is AllHeroFailure) {
      ToastUtils.failure(state.msg);
    }
  }
}
