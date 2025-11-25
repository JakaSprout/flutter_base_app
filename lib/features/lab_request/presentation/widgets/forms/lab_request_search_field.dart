import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_constants.dart';
import 'package:app_mobile_afms/features/lab_request/presentation/constants/lab_request_design_constants.dart';
import 'package:flutter/material.dart';

/// Search field widget for filtering lab requests.
class LabRequestSearchField extends StatelessWidget {
  /// Creates a new instance of [LabRequestSearchField].
  const LabRequestSearchField({super.key, this.onChanged, this.controller});

  /// Callback when the search text changes.
  final ValueChanged<String>? onChanged;

  /// Controller for the text field.
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: LabRequestDesignConstants.screenHorizontalPadding,
        top: 16,
        right: LabRequestDesignConstants.screenHorizontalPadding,
        bottom: 12,
      ),
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: controller,
          onChanged: onChanged,
          decoration: InputDecoration(
            hintText: LabRequestConstants.hintSearchRequests,
            hintStyle: const TextStyle(
              color: LabRequestDesignConstants.gray60,
              fontSize: 14,
            ),
            prefixIcon: const Padding(
              padding: EdgeInsets.only(left: 12, right: 8),
              child: Icon(
                Icons.search,
                size: 20,
                color: LabRequestDesignConstants.gray60,
              ),
            ),
            prefixIconConstraints: const BoxConstraints(
              minHeight: 20,
              minWidth: 20,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: LabRequestDesignConstants.gray20,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: LabRequestDesignConstants.gray20,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: LabRequestDesignConstants.gray20,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(
                color: LabRequestDesignConstants.gray20,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 8,
            ),
          ),
        ),
      ),
    );
  }
}





