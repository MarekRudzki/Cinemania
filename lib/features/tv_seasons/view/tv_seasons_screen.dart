// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// Project imports:
import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/common/no_network_screen.dart';
import 'package:cinemania/features/main/viewmodel/internet_connection_provider.dart';
import 'package:cinemania/features/tv_seasons/view/widgets/episode_info.dart';
import 'package:cinemania/features/tv_seasons/view/widgets/season_picker.dart';
import 'package:cinemania/features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart';

class TVSeasonsScreen extends HookWidget {
  final int seasonsNumber;
  final int tvShowId;
  final String showTitle;

  const TVSeasonsScreen({
    super.key,
    required this.seasonsNumber,
    required this.tvShowId,
    required this.showTitle,
  });

  @override
  Widget build(BuildContext context) {
    final _hasInternet =
        context.watch<InternetConnectionProvider>().hasInternet;

    final selectedSeason = useState(1);
    return _hasInternet
        ? DefaultTabController(
            length: 2,
            child: SafeArea(
              child: Scaffold(
                body: NestedScrollView(
                  headerSliverBuilder: (
                    BuildContext context,
                    bool innerBoxIsScrolled,
                  ) {
                    return [
                      SliverAppBar(
                        elevation: 5,
                        backgroundColor: Theme.of(context).colorScheme.surface,
                        centerTitle: true,
                        title: Text(
                          showTitle,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                          ),
                        ),
                        leading: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        ),
                        bottom: PreferredSize(
                          preferredSize: Size.fromHeight(
                            context.read<TVSeasonsBloc>().getSeasonsBarHeight(
                                seasonsNumber: seasonsNumber),
                          ),
                          child: SeasonPicker(
                            callback: (seasonNumber) {
                              selectedSeason.value = seasonNumber;
                              context.read<TVSeasonsBloc>().add(
                                    FetchSeason(
                                      id: tvShowId,
                                      seasonNumber: seasonNumber,
                                    ),
                                  );
                            },
                            seasonsNumber: seasonsNumber,
                            selectedSeason: selectedSeason.value,
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.surface,
                          Theme.of(context).colorScheme.onSurface,
                        ],
                      ),
                    ),
                    child: BlocConsumer<TVSeasonsBloc, TVSeasonsState>(
                      listener: (context, state) {
                        if (state is TVSeasonsError) {
                          ScaffoldMessenger.of(context).clearSnackBars();
                          ScaffoldMessenger.of(context).showSnackBar(
                            CustomSnackbar.showSnackBar(
                              message: state.errorMessage,
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                            ),
                          );
                        }
                      },
                      builder: (context, state) {
                        if (state is TVSeasonsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is TVSeasonsSuccess) {
                          final String overview = state.season.overview;
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: state.season.episodes.length,
                                    itemBuilder: (context, index) => Column(
                                      children: [
                                        if (index == 0)
                                          if (overview.isNotEmpty &&
                                              overview != 'No data')
                                            Padding(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    overview,
                                                    textAlign:
                                                        TextAlign.justify,
                                                    style: TextStyle(
                                                      color: Theme.of(context)
                                                          .colorScheme
                                                          .primary,
                                                    ),
                                                  ),
                                                  const SizedBox(height: 20),
                                                ],
                                              ),
                                            ),
                                        EpisodeInfo(
                                          episode: state.season.episodes[index],
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
              ),
            ),
          )
        : const NoNetworkScreen();
  }
}
