import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kngtakehome/core/models/note.dart';
import 'package:kngtakehome/core/viewmodels/note_viewmodel.dart';
import 'package:kngtakehome/utils/colors.dart';
import 'package:kngtakehome/utils/mixins/did_build.dart';
import 'package:kngtakehome/views/document/add_note.dart';
import 'package:kngtakehome/views/home/widgets/app_bar_button.dart';
import 'package:kngtakehome/views/home/widgets/empty_state.dart';
import 'package:kngtakehome/views/home/widgets/note_container.dart';
import 'package:kngtakehome/views/home/widgets/swipe_to_delete_bg.dart';
import 'package:kngtakehome/views/widgets/app_bar.dart';
import 'package:kngtakehome/views/widgets/custom_textfield.dart';

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> with DidBuild {
  final _searchController = TextEditingController();

  bool showSearchBar = false;

  @override
  Widget build(BuildContext context) {
    final noteViewModelProvider = ref.watch(noteViewModel);

    return Scaffold(
      body: Column(
        children: [
          if (showSearchBar) ...[
            Padding(
                padding: const EdgeInsets.fromLTRB(16, 60, 16, 16),
                child: CustomTextField(
                  controller: _searchController,
                  hint: 'Search by the keyword...',
                  filled: true,
                  textStyle: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: AppColors.white,
                  ),
                  hintStyle: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w300,
                    color: Color(0XFFCCCCCC),
                  ),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        showSearchBar = false;
                        _searchController.clear();
                      });
                    },
                    child: const Icon(
                      Icons.close,
                      color: Color(0XFFCCCCCC),
                    ),
                  ),
                ))
          ] else ...[
            CustomeAppBar(
              child: Row(
                children: [
                  Text(
                    'NOTES',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: AppColors.white,
                    ),
                  ),
                  const Spacer(),
                  AppBarButton(
                    key: const Key('searchButton'),
                    icon: Icons.search,
                    onTap: () {
                      setState(() {
                        showSearchBar = true;
                      });
                    },
                  ),
                  const SizedBox(
                    width: 21,
                  ),
                  AppBarButton(
                    key: const Key('infoButton'),
                    icon: Icons.info_outline,
                    onTap: () {},
                  )
                ],
              ),
            )
          ],
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _searchController,
            builder: (context, searchText, _) {
              final enteredText = searchText.text.trim();

              List<Note> notes = noteViewModelProvider.notes;

              if (enteredText.isNotEmpty) {
                final titleSearchResults = notes
                    .where((element) => element.title
                        .toLowerCase()
                        .contains(enteredText.toLowerCase()))
                    .toList();

                final contentSearchResults = notes
                    .where((element) => element.content
                        .toLowerCase()
                        .contains(enteredText.toLowerCase()))
                    .toList();

                //conbine the search results using spread operator
                final combinedResults = [
                  ...titleSearchResults,
                  ...contentSearchResults
                ];

                //Remove duplicates fron the combined search results and assign it to notes
                notes = combinedResults.toSet().toList();
              }

              if (enteredText.isNotEmpty && notes.isEmpty) {
                return const EmptyState(
                  imagePath: "assets/cuate.png",
                  description: "File not found. Try searching again.",
                );
              }

              if (notes.isEmpty) {
                return const EmptyState(
                  imagePath: "assets/rafiki.png",
                  description: "Create your first note!",
                );
              }
              return Expanded(
                child: ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: notes.length,
                  separatorBuilder: (context, index) => const SizedBox(
                    height: 25,
                  ),
                  itemBuilder: (context, index) {
                    final note = notes[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AddNote(
                              note: note,
                              noteIndex: index,
                              edit: false,
                            ),
                          ),
                        );
                      },
                      child: Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          // Remove the item from the data source (hive).
                          ref.read(noteViewModel.notifier).deleteNote(index);

                          // Then show a snackbar.
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'note deleted',
                              ),
                            ),
                          );
                        },
                        background: const SwipeToDeleteBackground(),
                        child: NoteContainer(
                          key: const Key('noteContainer'),
                          title: note.title,
                          colorCode: note.colorCode,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          ),
          const SizedBox(
            height: 25,
          ),
        ],
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNote(
                edit: true,
              ),
            ),
          );
        },
        backgroundColor: AppColors.backgroundColor,
        tooltip: 'addNote',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  void didBuild(BuildContext context) async {
    await ref.read(noteViewModel.notifier).getNotes();
  }
}
