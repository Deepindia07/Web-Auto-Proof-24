class InputValidators {
  /// Validates whether the input is a valid email or phone number.
  static String? validateEmailOrPhone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter email or phone number';
    }
    final input = value.trim();
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    if (emailRegex.hasMatch(input)) {
      return null;
    } else if (phoneRegex.hasMatch(input)) {
      return null;
    } else {
      return 'Enter a valid email or phone number';
    }
  }

  /// Validates brand
  static String? validateBrand(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter brand name';
    }
    return null;
  }

  static  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!regex.hasMatch(value)) {
      return 'Enter a valid email';
    }
    return null;
  }

  /// Validates model
  static String? validateModel(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter model';
    }
    return null;
  }

  /// validation for address -
  static String? validateAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Address is required';
    }
    if (value.trim().length < 10) {
      return 'Please enter a more detailed address';
    }
    // Optional: add regex for street name + number + zip
    if (!RegExp(r'^[\w\s\-,.#]{10,}$').hasMatch(value)) {
      return 'Invalid address format';
    }
    return null;
  }

  /// validation for DOB -
  static String? validateDob(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'DOB is required';
    }

    return null;
  }

  /// validation for address -
  static String? validateNationalism(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Nationalism is required';
    }

    return null;
  }

  /// validation for Company name -
  static String? validateCompanyName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Company name is required';
    }
    if (value.trim().length < 10) {
      return 'Please enter a more detailed Company name';
    }
    // Optional: add regex for street name + number + zip
    if (!RegExp(r'^[\w\s\-,.#]{10,}$').hasMatch(value)) {
      return 'Invalid Company name format';
    }
    return null;
  }

  /// validation for Company address -
  static String? validateCompanyAddress(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Company address is required';
    }
    if (value.trim().length < 10) {
      return 'Please enter a more detailed Company address';
    }
    // Optional: add regex for street name + number + zip
    if (!RegExp(r'^[\w\s\-,.#]{10,}$').hasMatch(value)) {
      return 'Invalid Company address format';
    }
    return null;
  }

  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) return 'URL is required';
    final pattern = r'^(https?:\/\/)[\w-]+(\.[\w-]+)+[\w.,@?^=%&:/~+#-]*$';
    if (!RegExp(pattern, caseSensitive: false).hasMatch(value)) {
      return 'Enter a valid URL (starting with http:// or https://)';
    }
    return null;
  }

  static String? validateVAT(String? value) {
    if (value == null || value.isEmpty) return 'URL is required';
    final pattern = "r'\s+|-''";
    if (!RegExp(pattern, caseSensitive: false).hasMatch(value)) {
      return 'Enter a valid URL (starting with http:// or https://)';
    }
    return null;
  }

  static String? validateRegisterNumber(String? val) {
    if (val == null || val.isEmpty) {
      return 'CIN is required';
    }
    final pattern = r'^[LU]\d{5}[A-Z]{2}\d{4}[A-Z]{3}\d{6}$';
    if (!RegExp(pattern).hasMatch(val.trim())) {
      return 'Enter a valid 21‑char CIN (e.g. U12345MH2023PTC000789)';
    }
    return null;
  }

  /// validation for password -
  static String? validatePassword(String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'Please enter password';
    }
    if (password.length < 6) {
      return 'Password must be longer than 6 characters.\n';
    }
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return '• Uppercase letter is missing.\n';
    }
    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return '• Lowercase letter is missing.\n';
    }
    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return '• Digit is missing.\n';
    }
    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#%^&*(),.?":{}|<>]'))) {
      return '• Special character is missing.\n';
    }
    return null;
  }

  /// validation for confirm password -
  static String? validateConfirmPassword(
      String? confirmPassword,
      String originalPassword,
      ) {
    if (confirmPassword == null || confirmPassword.trim().isEmpty) {
      return 'Please confirm your password';
    }
    if (confirmPassword != originalPassword) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// validation for first name -
  static String? validateFirstName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter first name';
    }
    final name = value.trim();
    // Ensure only alphabets (and optionally spaces)
    final nameRegex = RegExp(r'^[A-Za-z\s]+$');
    if (!nameRegex.hasMatch(name)) {
      return 'Only letters are allowed';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  /// validation for last name -
  static String? validateLastName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter last name';
    }
    final name = value.trim();
    // Ensure only alphabets (and optionally spaces)
    final nameRegex = RegExp(r'^[A-Za-z\s]+$');
    if (!nameRegex.hasMatch(name)) {
      return 'Only letters are allowed';
    }
    if (name.length < 2) {
      return 'Name must be at least 2 characters long';
    }
    return null;
  }

  /// validation for phone no. -
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your phone number';
    }
    final phone = value.trim();
    // Allows only 10-digit numbers starting from 6-9
    final phoneRegex = RegExp(r'^[6-9]\d{9}$');
    if (!phoneRegex.hasMatch(phone)) {
      return 'Enter a valid 10-digit phone number';
    }
    return null; // Valid
  }

  /// validation for Authorization number -
  static String? validateAuthorizationNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter authorization number';
    }

    final input = value.trim();
    final numericRegex = RegExp(r'^\d+$');

    if (!numericRegex.hasMatch(input)) {
      return 'Authorization number must be digits only';
    }

    return null;
  }

  /// validation for Approval Number -
  static String? validateApprovalNumber(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter approval number';
    }

    final input = value.trim();
    final numericRegex = RegExp(r'^\d+$');

    if (!numericRegex.hasMatch(input)) {
      return 'Approval number must be digits only';
    }

    return null;
  }
}