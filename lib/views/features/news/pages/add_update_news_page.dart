import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
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
import 'package:ora_news/views/widgets/app_button.dart';
import 'package:ora_news/views/widgets/custom_button.dart';
import 'package:ora_news/views/widgets/custom_dropdown_field.dart';
import 'package:ora_news/views/widgets/custom_field_label.dart';
import 'package:ora_news/views/widgets/custom_form_field.dart';
import 'package:provider/provider.dart';

class AddUpdateNewsPage extends StatefulWidget {
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

  File? _pickedFile;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.newsData?.title ?? '');
    _bodyController = TextEditingController(text: widget.newsData?.content ?? '');
    _imageUrlController = TextEditingController(text: widget.newsData?.imageUrl ?? '');
    _selectedCategory = widget.newsData?.category.id;

    // Ambil data kategori saat halaman dibuka
    Future.microtask(() => context.read<NewsPublicProvider>().fetchCategory());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  /// Fungsi untuk memilih gambar dari file picker
  Future<void> _pickImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );

    if (result != null) {
      setState(() {
        _pickedFile = File(result.files.single.path!);
      });
    } else {
      if (mounted) {
        AppNotif.info(context, message: 'Tidak ada gambar yang dipilih.');
      }
    }
  }

  /// Fungsi untuk submit form, baik tambah maupun update berita
  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    if (_pickedFile == null && _imageUrlController.text.isEmpty) {
      AppNotif.error(
        context,
        message: 'Silakan unggah gambar atau isi url gambar terlebih dahulu',
      );
      return;
    }

    final newsProvider = Provider.of<UserNewsProvider>(context, listen: false);

    bool success = false;
    if (widget.isUpdateMode) {
      success = await newsProvider.updateNews(
        widget.newsData!.id,
        title: _titleController.text,
        content: _bodyController.text,
        categoryId: _selectedCategory!,
        imageUrl: _imageUrlController.text,
        image: _pickedFile,
      );
    } else {
      success = await newsProvider.createNews(
        title: _titleController.text,
        content: _bodyController.text,
        categoryId: _selectedCategory!,
        imageUrl: _imageUrlController.text,
        image: _pickedFile,
      );
    }

    if (mounted) {
      await newsProvider.fetchUserNews();

      // Tampilkan notifikasi error upload gambar jika ada
      if (newsProvider.errorMessageUploadImge != null) {
        AppNotif.error(context, message: newsProvider.errorMessageUploadImge!);
      }

      // Tampilkan notifikasi sukses/gagal
      if (success) {
        AppNotif.success(
          context,
          message:
              widget.isUpdateMode
                  ? "Berita berhasil diperbarui"
                  : "Berita telah berhasil dibuat",
        );
      } else {
        AppNotif.error(context, message: newsProvider.errorMessage ?? "Terjadi kesalahan");
      }
      context.goNamed(RouteNames.myNews);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String pageTitle = widget.isUpdateMode ? 'Update News' : 'Add News';
    final String buttonText = widget.isUpdateMode ? 'Update' : 'Publish';
    final Color buttonColor = widget.isUpdateMode ? AppColors.warning : AppColors.primary;
    final Color buttonTextColor =
        widget.isUpdateMode ? AppColors.textPrimary : AppColors.textLight;

    return Consumer<UserNewsProvider>(
      builder: (context, provider, _) {
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
              pageTitle,
              style: AppTypography.headline2.copyWith(color: AppColors.textPrimary),
            ),
            bottom:
                provider.isLoading
                    ? const PreferredSize(
                      preferredSize: Size.fromHeight(4.0),
                      child: LinearProgressIndicator(
                        backgroundColor: AppColors.primary,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    )
                    : null,
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
                              FieldValidatorBuilder(
                                'Title',
                              ).required().minLength(5).build(),
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
                              FieldValidatorBuilder('Body').required().minLength(5).build(),
                        ),
                        AppSpacing.vsLarge,
                        const CustomFieldLabel(
                          text: 'Pilih salah satu untuk upload gambar',
                        ),
                        const CustomFieldLabel(text: 'Upload Image (Opsional)'),
                        _buildImagePickerField(),
                        const CustomFieldLabel(text: 'Atau'),
                        CustomFormField(
                          labelText: 'Gambar Url (Opsional)',
                          controller: _imageUrlController,
                          hintText: 'Masukkan Url Gambar Berita',
                          boxSize: FormFieldSize.large,
                        ),
                        AppSpacing.vsLarge,
                        const CustomFieldLabel(text: 'Kategori'),
                        Consumer<NewsPublicProvider>(
                          builder: (context, provider, _) {
                            return CustomDropdownField<String>(
                              value: _selectedCategory,
                              hintText: 'Dropdown Kategori',
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
              _buildBottomSection(
                buttonText: buttonText,
                buttonColor: buttonColor,
                buttonTextColor: buttonTextColor,
                isLoading: provider.isLoading,
              ),
            ],
          ),
        );
      },
    );
  }

  /// Widget untuk memilih gambar dari file picker
  Widget _buildImagePickerField() {
    final fileName = _pickedFile?.path.split('/').last ?? 'Pilih gambar...';

    return GestureDetector(
      onTap: _pickImage,
      child: Container(
        height: AppSpacing.boxLarge,
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.m),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppSpacing.roundedMedium),
          border: Border.all(color: AppColors.grey400),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                fileName,
                style:
                    _pickedFile != null
                        ? AppTypography.bodyText1
                        : AppTypography.bodyText1.copyWith(color: AppColors.textSecondary),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const Icon(Icons.file_upload_outlined, color: AppColors.grey600),
          ],
        ),
      ),
    );
  }

  /// Widget bagian bawah untuk tombol submit dan info legal
  Widget _buildBottomSection({
    required String buttonText,
    required Color buttonColor,
    required Color buttonTextColor,
    required bool isLoading,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.m),
      decoration: BoxDecoration(
        color: AppColors.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        children: [
          PrimaryButton(
            onPressed: _submitForm,
            text: buttonText,
            width: double.infinity,
            buttonSize: CustomButtonSize.medium,
            isDisabled: isLoading,
            backgroundColor: buttonColor,
            foregroundColor: buttonTextColor,
          ),
          AppSpacing.vsMedium,
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: AppTypography.caption.copyWith(color: AppColors.textSecondary),
              children: [
                const TextSpan(
                  text: 'Untuk perubahan konten karena alasan hukum, silakan ke ',
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
