import 'package:cinemania/common/custom_snackbar.dart';
import 'package:cinemania/features/tv_seasons/view/widgets/episode_info.dart';
import 'package:cinemania/features/tv_seasons/view/widgets/season_picker.dart';
import 'package:cinemania/features/tv_seasons/viewmodel/bloc/tv_seasons_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

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
    final selectedSeason = useState(1);
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (
            BuildContext context,
            bool innerBoxIsScrolled,
          ) {
            return [
              SliverAppBar(
                elevation: 5,
                backgroundColor: const Color.fromARGB(255, 45, 15, 50),
                forceElevated: innerBoxIsScrolled,
                centerTitle: true,
                title: Text(
                  showTitle,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                ),
                bottom: PreferredSize(
                  preferredSize: Size.fromHeight(
                    context
                        .read<TVSeasonsBloc>()
                        .getSeasonsBarHeight(seasonsNumber: seasonsNumber),
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
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [
                  Color.fromARGB(255, 45, 15, 50),
                  Color.fromARGB(255, 87, 25, 98),
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
                      backgroundColor: Colors.red,
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
                                    Column(
                                      children: [
                                        Text(
                                          overview,
                                          textAlign: TextAlign.justify,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],
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
    );
  }
}
