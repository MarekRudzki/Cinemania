import 'package:flutter/material.dart';

class EpisodePhoto extends StatelessWidget {
  final String photoUrl;

  const EpisodePhoto({
    super.key,
    required this.photoUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width * 0.95,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.27,
        child: photoUrl.contains('No data')
            ? Stack(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/tv_show.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 00,
                    left: 0,
                    right: 0,
                    top: MediaQuery.sizeOf(context).height * 0.22,
                    child: Center(
                      child: Text(
                        'NO IMAGE',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  )
                ],
              )
            : FadeInImage(
                placeholder: const AssetImage(
                  'assets/photo_loading.png',
                ),
                image: NetworkImage(
                  photoUrl,
                ),
                fit: BoxFit.cover,
              ),
      ),
    );
  }
}
