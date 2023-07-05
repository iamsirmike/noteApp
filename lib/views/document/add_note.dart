// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kngtakehome/core/models/note.dart';
import 'package:kngtakehome/core/viewmodels/note_viewmodel.dart';
import 'package:kngtakehome/utils/colors.dart';
import 'package:kngtakehome/utils/operation_runner.dart';
import 'package:kngtakehome/views/home/widgets/app_bar_button.dart';
import 'package:kngtakehome/views/widgets/KngTextField.dart';
import 'package:kngtakehome/views/widgets/app_bar.dart';
import 'package:kngtakehome/views/widgets/dialog/confirm_alert.dialog.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key, this.note, this.edit = false, this.noteIndex});
  final Note? note;
  final int? noteIndex;
  final bool edit;

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends OperationRunnerState<AddNote> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late NoteViewModel _noteViewModel;

  String? title;
  String? content;

  bool isEditing = false;
  bool userHasSavedNote = false;

  @override
  void initState() {
    super.initState();
    isEditing = widget.edit;
  }

  @override
  Widget build(BuildContext context) {
    _noteViewModel = context.read<NoteViewModel>();

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
                  }

                  if (!_formKey.currentState!.validate()) {
                    return;
                  }
                  _formKey.currentState!.save();

                  saveNote(title: title!, content: content!);
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

                            saveNote(title: title!, content: content!);
                          },
                        )
                      ],
                    )
                  : AppBarButton(
                      key: const Key('editIcon'),
                      icon: Icons.edit,
                      onTap: () {
                        setState(() {
                          isEditing = true;
                        });
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
                      KngTextField(
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
                      KngTextField(
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
  }) async {
    const operation = 'save note';

    await runOperation<void>(
      operation,
      () async {
        if (isEditing && widget.note != null) {
          _noteViewModel.updateNote(
              widget.noteIndex!,
              Note(
                docId: widget.note!.docId,
                title: title,
                content: content,
                colorCode: widget.note!.colorCode,
              ));
          return;
        }
        _noteViewModel.saveNote(
          title,
          content,
        );

        Navigator.pop(context);
      },
    );
  }
}
