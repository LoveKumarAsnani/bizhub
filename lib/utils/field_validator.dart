class TextFieldValidators {
  dynamic firstNameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter First Name';
    } else if (value.length > 30) {
      return 'First Name length Should be less than 30';
    } else if (value.length < 3) {
      return 'First Name must at least 3 characters';
    }
    return null;
  }

  dynamic lastNameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Last Name';
    } else if (value.length > 30) {
      return 'Last Name length Should be less than 30';
    } else if (value.length < 3) {
      return 'Last Name must at least 3 characters';
    }
    return null;
  }

  dynamic uniqueTokenErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Code';
    } else if (value.length != 4) {
      return 'Code must be 4 characters';
    }
    return null;
  }

  dynamic nameErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Name';
    } else if (value.length > 60) {
      return 'Name length Should be less than 60';
    } else if (value.length < 3) {
      return 'Name must at least 3 characters';
    }

    return null;
  }

  dynamic titleErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Title';
    } else if (value.length > 60) {
      return 'Title length Should be less than 60';
    } else if (value.length < 4) {
      return 'Title must at least 4 characters';
    }

    return null;
  }

  dynamic budgetRangeErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Budget';
    }
    if (int.parse(value) < 5) {
      return 'Budget Must Be Greater than \$5';
    }
    if (value.length >= 7) {
      return 'Budget Must be less then or equal to 6 digits';
    }

    return null;
  }

  dynamic noOfPeopleNeededErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Number of People Needed';
    }
    if (value.length > 2) {
      return 'Number of People Must be in 2 digits';
    }

    return null;
  }

  dynamic descriptionErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Description';
    } else if (value.length > 500) {
      return 'Description length Should be less than 500';
    } else if (value.length < 5) {
      return 'Description must at least 5 characters';
    }
    return null;
  }

  dynamic emailErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Enter your Email address';
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Enter a Valid Email address';
    }
    return null;
  }

  dynamic emailErrorGetterOptional(
    String value,
  ) {
    // if (value.isEmpty) {
    //   return 'Enter your Email address (optional)';
    // } else if (!RegExp(
    //         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
    //     .hasMatch(value)) {
    //   return 'Enter a Valid Email address';
    // }
    // return null;

    if (value.isEmpty) {
      return null;
    }

    if (value.isNotEmpty) {
      if (!RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value)) {
        return 'Enter a Valid Email address';
      }
      return null;
    }
  }

//   String validateLastName(String value,{bool isOptional = false})) {
//   if(isOptional && (value==null || value.isEmpty)){
//     return null;
//   }
//   if (value.isNotEmpty) {
//     if (value.length > 20) {
//       return 'Maksimal 20 karakter';
//     }
//     return null;
//   }
//   return null;
// }

  dynamic passwordErrorGetter(String value) {
    if (value.isEmpty) {
      return 'PLease Enter Password';
    }
    if (value.length < 8) {
      return 'Password Should be at least 8 characters';
    }
    return null;
  }

  dynamic confirmPasswordErrorGetter(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return 'PLease Enter Confirm Password';
    } else if (confirmPassword.trim() != password.trim()) {
      return 'Confirm Password Should be Same as Password';
    }
    return null;
  }

  // dynamic phoneNumberErrorGetter(String value) {
  //   if (value.isEmpty) {
  //     return 'PLease Enter Phone Number';
  //   }
  //   if (value.length < 9) {
  //     return 'Phone Number Should be at least 9 characters';
  //   }
  //   return null;
  // }

  dynamic phoneNumberErrorGetter(String value) {
    if (value.isEmpty) {
      return 'Please Enter Phone Number';
    }
    if (value.length != 11) {
      return 'Mobile Number must be of 11 digit';
    }
    return null;
  }

  // dynamic phoneNumberErrorGetter(String value) {
  //   // Define a regex pattern for a US phone number starting with "1" (followed by 9 digits)
  //   final RegExp regex = RegExp(r'^1\d{10}$');

  //   if (value.isEmpty) {
  //     return 'Please enter a phone number.';
  //   } else if (!regex.hasMatch(value)) {
  //     return 'Invalid Phone Number (must start with 1 and have 11 digits).';
  //   }

  //   return null;
  // }

  dynamic phoneNumberErrorGetter2(String value) {
    // Define a regex pattern for a phone number with optional "1" in front and hyphens
    // final RegExp regex = RegExp(r'^(1-)?\d{3}-\d{3}-\d{4}$');

    if (value.isEmpty) {
      return 'Please enter a phone number.';
    }
    //else if (!regex.hasMatch(value)) {
    else if (value.length < 10) {
      // return 'Invalid Phone Number (should have the format 1-212-456-7890).';
      return 'Invalid Phone Number (Length should be greater than 10 digits ).';
    } else if (value.length > 15) {
      return 'Invalid Phone Number (Length should be less than 15 digits ).';
    }
    return null;
  }

  dynamic phoneNumberErrorGetter2Optional(String value) {
    if (value.isNotEmpty) {
      if (value.length < 10) {
        // return 'Invalid Phone Number (should have the format 1-212-456-7890).';
        return 'Invalid Phone Number (Length should be greater than 10 digits ).';
      } else if (value.length > 15) {
        return 'Invalid Phone Number (Length should be less than 15 digits ).';
      }
    }
    return null;
  }

  // String urlPattern =
  //     r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?";
  // // var match = RegExp( , caseSensitive: false)
  // //     .firstMatch('https://www.google.com');
  // var match = RegExp(urlPattern);

  dynamic urlErrorGetter(String value) {
    if (!RegExp(
            r"([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?")
        .hasMatch(value)) {
      return 'Enter Valid Url';
    }
    return null;
  }
}
