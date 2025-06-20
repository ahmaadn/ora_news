import 'dart:developer';

// import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ora_news/app/config/app_color.dart';
import 'package:ora_news/app/config/app_spacing.dart';
import 'package:ora_news/app/config/app_typography.dart';
import 'package:ora_news/app/constants/route_names.dart';
import 'package:ora_news/app/utils/app_notif.dart';
import 'package:ora_news/app/utils/field_validator_builder.dart';
import 'package:ora_news/data/models/news_models.dart';
import 'package:ora_news/data/models/user_models.dart';
import 'package:ora_news/data/provider/news_public_provider.dart';
import 'package:ora_news/data/provider/user_news_provider.dart';
import 'package:ora_news/views/widgets/custom_button.dart';
import 'package:ora_news/views/widgets/custom_dropdown_field.dart';
import 'package:ora_news/views/widgets/custom_field_label.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class AddUpdateNewsPage extends StatefulWidget {
  // Jika newsData tidak null, maka ini adalah mode update
  final MyNewsArticle? newsData;

  const AddUpdateNewsPage({super.key, this.newsData});

  bool get isUpdateMode => newsData != null;

  @override
  State<AddUpdateNewsPage> createState() => _AddUpdateNewsPageState();
}

class _AddUpdateNewsPageState extends State<AddUpdateNewsPage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _bodyController;
  late final TextEditingController _imageUrlController;

  // PlatformFile? _selectedImageFile;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.newsData?.title ?? '');
    _bodyController = TextEditingController(text: widget.newsData?.content ?? '');
    _imageUrlController = TextEditingController(text: widget.newsData?.imageUrl ?? '');
    _selectedCategory = widget.newsData?.category.id;

    Future.microtask(() => context.read<NewsPublicProvider>().fetchCategory());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  // Future<void> _pickImage() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.custom,
  //     allowedExtensions: ['jpg', 'png', 'jpeg'],
  //   );

  //   if (result != null) {
  //     setState(() {
  //       _selectedImageFile = result.files.single;
  //     });
  //   } else {}
  // }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      // if (_selectedImageFile == null && !widget.isUpdateMode) {
      //   AppNotif.error(context, message: 'Silakan unggah gambar terlebih dahulu');
      //   return;
      // }

      log('Title: ${_titleController.text}');
      log('Body: ${_bodyController.text}');
      log('Category: $_selectedCategory');
      log('Image Path: ${_imageUrlController.text}');

      final newsProvider = Provider.of<UserNewsProvider>(context, listen: false);

      if (widget.isUpdateMode) {
        log('Updating news...');
      } else {
        log('Create News ...');
        final bool success = await newsProvider.createNews(
          title: _titleController.text,
          content: _bodyController.text,
          categoryId: _selectedCategory!,
          imageUrl: _imageUrlController.text,
        );

        if (success) {
          if (mounted) {
            AppNotif.success(context, message: "Berita telah berhasil di buat");
            await newsProvider.fetchUserNews();
            context.goNamed(RouteNames.myNews);
          }
        } else {
          if (mounted) {
            AppNotif.error(
              context,
              message: newsProvider.errorMessage ?? "Terjadi kesalahan ",
            );
            context.goNamed(RouteNames.myNews);
          }
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: AppColors.surface,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.isUpdateMode ? 'Update News' : 'Add News',
          style: AppTypography.headline2.copyWith(color: AppColors.textPrimary),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.m),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomFormField(
                      labelText: 'Title',
                      controller: _titleController,
                      hintText: 'Masukkan Judul Berita',
                      boxSize: FormFieldSize.large,
                      validator:
                          FieldValidatorBuilder('Title').required().minLength(5).build(),
                    ),
                    AppSpacing.vsLarge,
                    CustomFormField(
                      labelText: 'Body',
                      controller: _bodyController,
                      hintText: 'Masukkan content berita',
                      maxLines: null,
                      minLines: 3,
                      keyboardType: TextInputType.multiline,
                      validator:
                          FieldValidatorBuilder('Boody').required().minLength(5).build(),
                    ),

                    AppSpacing.vsLarge,
                    // const CustomFieldLabel(text: 'Upload Image'),
                    // _buildImagePickerField(),
                    CustomFormField(
                      labelText: 'Gambar Url',
                      controller: _imageUrlController,
                      hintText: 'Masukkan Url Gambar Berita',
                      boxSize: FormFieldSize.large,
                      validator:
                          FieldValidatorBuilder(
                            'Image Url',
                          ).required().minLength(5).build(),
                    ),
                    AppSpacing.vsLarge,
                    const CustomFieldLabel(text: 'Kategory'),
                    Consumer<NewsPublicProvider>(
                      builder: (context, provider, _) {
                        return CustomDropdownField<String>(
                          value: _selectedCategory,
                          hintText: 'Dropdown Kategory',
                          items:
                              provider.categories.map((CategoryNews category) {
                                return DropdownMenuItem<String>(
                                  value: category.id,
                                  child: Text(category.name),
                                );
                              }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCategory = newValue;
                            });
                          },
                          validator:
                              (value) =>
                                  value == null ? 'Kategori tidak boleh kosong' : null,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
          _buildBottomSection(),
        ],
      ),
    );
  }

  // Widget _buildImagePickerField() {
  //   final fileName = _selectedImageFile?.name ?? 'Choose an image...';

  //   return GestureDetector(
  //     onTap: _pickImage,
  //     child: Container(
  //       height: AppSpacing.boxLarge, // Sesuaikan tinggi agar sama dengan dropdown
  //       padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
  //       decoration: BoxDecoration(
  //         color: Colors.transparent,
  //         borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
  //         border: Border.all(color: AppColors.grey400),
  //       ),
  //       child: Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //         children: [
  //           Expanded(
  //             child: Text(
  //               fileName,
  //               style:
  //                   _selectedImageFile != null
  //                       ? AppTypography.bodyText1
  //                       : AppTypography.bodyText1.copyWith(color: AppColors.textSecondary),
  //               overflow: TextOverflow.ellipsis,
  //             ),
  //           ),
  //           const Icon(Icons.file_upload_outlined, color: AppColors.grey600),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildBottomSection() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomButton(
            onPressed: _submitForm,
            text: widget.isUpdateMode ? 'Update' : 'Publish',
            width: double.infinity,
            buttonSize: CustomButtonSize.medium,
            backgroundColor: widget.isUpdateMode ? AppColors.warning : AppColors.primary,
            foregroundColor:
                widget.isUpdateMode ? AppColors.textPrimary : AppColors.textLight,
          ),
          AppSpacing.vsMedium,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
              children: [
                const TextSpan(
                  text: 'For content changes for legal reasons, please go to ',
                ),
                TextSpan(
                  text: 'Legal Help',
                  style: AppTypography.caption.copyWith(color: AppColors.info),
                  recognizer:
                      TapGestureRecognizer()
                        ..onTap = () {
                          log('Navigate to Legal Help');
                        },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
