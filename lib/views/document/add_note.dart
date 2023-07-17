// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kngtakehome/core/models/note.dart';
import 'package:kngtakehome/core/viewModels/toggleEditViewModel/toggle_eidt_note_viewmodel.dart';
import 'package:kngtakehome/core/viewmodels/noteProviders/note_viewmodel.dart';
import 'package:kngtakehome/utils/colors.dart';
import 'package:kngtakehome/views/home/widgets/app_bar_button.dart';
import 'package:kngtakehome/views/widgets/app_bar.dart';
import 'package:kngtakehome/views/widgets/custom_textfield.dart';
import 'package:kngtakehome/views/widgets/dialog/confirm_alert.dialog.dart';

class AddNote extends ConsumerStatefulWidget {
  const AddNote({super.key, this.note, this.edit = false, this.noteIndex});
  final Note? note;
  final int? noteIndex;
  final bool edit;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddNoteState();
}

class _AddNoteState extends ConsumerState<AddNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? title;
  String? content;

  bool userHasSavedNote = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(editingViewModelProvider.notifier).toggleEditing(widget.edit);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = ref.watch(editingViewModelProvider);
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomeAppBar(
              child: Row(
            children: [
              AppBarButton(
                key: const Key('backArrow'),
                icon: Icons.arrow_back_ios,
                onTap: () async {
                  if ((title == null && content == null) || userHasSavedNote) {
                    Navigator.pop(context);
                    return;
                  }
                  final shouldSave = await showDialog(
                    context: context,
                    builder: (context) {
                      return const ConfirmAlert(
                        title: 'Are your sure you want discard your changes?',
                      );
                    },
                  );
                  if (!shouldSave) {
                    Navigator.pop(context);
                    return;
                  }

                  setState(() {
                    userHasSavedNote = shouldSave;
                  });

                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();

                  saveNote(
                      title: title!, content: content!, isEditing: isEditing);
                  // Navigator.pop(context);
                },
              ),
              const Spacer(),
              isEditing
                  ? Row(
                      children: [
                        AppBarButton(
                          key: const Key('eyeIcon'),
                          icon: Icons.remove_red_eye_outlined,
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 21,
                        ),
                        AppBarButton(
                          key: const Key('saveIcon'),
                          icon: Icons.save,
                          onTap: () async {
                            final shouldSave = await showDialog(
                              context: context,
                              builder: (context) {
                                return const ConfirmAlert(
                                  title: 'Save changes?',
                                );
                              },
                            );
                            setState(() {
                              userHasSavedNote = shouldSave;
                            });

                            if (!shouldSave) {
                              return;
                            }

                            if (!_formKey.currentState!.validate()) {
                              return;
                            }
                            _formKey.currentState!.save();

                            saveNote(
                                title: title!,
                                content: content!,
                                isEditing: isEditing);
                          },
                        )
                      ],
                    )
                  : AppBarButton(
                      key: const Key('editIcon'),
                      icon: Icons.edit,
                      onTap: () {
                        ref
                            .read(editingViewModelProvider.notifier)
                            .toggleEditing(true);
                      },
                    )
            ],
          )),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      CustomTextField(
                        key: const Key('titleTextField'),
                        hint: 'Title',
                        isRequired: true,
                        readOnly: !isEditing,
                        textStyle: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                        ),
                        hintStyle: const TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFF9A9A9A),
                        ),
                        initialValue:
                            widget.note != null ? widget.note!.title : null,
                        onChanged: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            title = value;
                          });
                        },
                      ),
                      CustomTextField(
                        key: const Key('contentTextField'),
                        hint: 'Type something...',
                        isRequired: false,
                        readOnly: !isEditing,
                        textStyle: TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w300,
                          color: AppColors.white,
                        ),
                        hintStyle: const TextStyle(
                          fontSize: 23,
                          fontWeight: FontWeight.w400,
                          color: Color(0XFF9A9A9A),
                        ),
                        initialValue:
                            widget.note != null ? widget.note!.content : null,
                        onChanged: (value) {
                          setState(() {
                            content = value;
                          });
                        },
                        onSaved: (value) {
                          setState(() {
                            content = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void saveNote({
    required String title,
    required String content,
    required bool isEditing,
  }) async {
    if (isEditing && widget.note != null) {
      ref.read(noteViewModelProvider.notifier).updateNote(
          widget.noteIndex!,
          Note(
            docId: widget.note!.docId,
            title: title,
            content: content,
            colorCode: widget.note!.colorCode,
          ));
      return;
    }
    await ref.read(noteViewModelProvider.notifier).saveNote(title, content);

    Navigator.pop(context);
  }
}
