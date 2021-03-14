// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "ADD_IMAGE" : MessageLookupByLibrary.simpleMessage("Add image"),
    "BELONGS_TO" : MessageLookupByLibrary.simpleMessage("belongs to"),
    "BRANCH" : MessageLookupByLibrary.simpleMessage("Branch"),
    "CHANGE" : MessageLookupByLibrary.simpleMessage("Change"),
    "CHANGE_PASSWORD" : MessageLookupByLibrary.simpleMessage("Change password"),
    "CHANGE_PASSWORD_SCREEN_CHANGE_SUCCESS" : MessageLookupByLibrary.simpleMessage("Change password success"),
    "CHANGE_PASSWORD_SCREEN_CONFIRM_ERROR" : MessageLookupByLibrary.simpleMessage("Confirm password must be the same as new password"),
    "CHANGE_PASSWORD_SCREEN_CONFIRM_PASSWORD" : MessageLookupByLibrary.simpleMessage("Confirm password"),
    "CHANGE_PASSWORD_SCREEN_CURRENT_PASSWORD" : MessageLookupByLibrary.simpleMessage("Current password"),
    "CHANGE_PASSWORD_SCREEN_EMPTY" : MessageLookupByLibrary.simpleMessage("must not be empty"),
    "CHANGE_PASSWORD_SCREEN_NEW_PASSWORD" : MessageLookupByLibrary.simpleMessage("New password"),
    "CHANGE_PASSWORD_SCREEN_PASSWORD_ERROR" : MessageLookupByLibrary.simpleMessage("Current password is wrong"),
    "COMMENTS" : MessageLookupByLibrary.simpleMessage("Comments"),
    "CREATED_ON" : MessageLookupByLibrary.simpleMessage("Created on"),
    "DELETE" : MessageLookupByLibrary.simpleMessage("Delete"),
    "DESCRIPTION" : MessageLookupByLibrary.simpleMessage("Description"),
    "EDIT" : MessageLookupByLibrary.simpleMessage("Edit"),
    "EDIT_VIOLATION" : MessageLookupByLibrary.simpleMessage("Edit violation"),
    "EMAIL" : MessageLookupByLibrary.simpleMessage("Email"),
    "EVIDENCE" : MessageLookupByLibrary.simpleMessage("Evidence"),
    "FAIL" : MessageLookupByLibrary.simpleMessage("fail"),
    "FILTER" : MessageLookupByLibrary.simpleMessage("Filter"),
    "HOME" : MessageLookupByLibrary.simpleMessage("Home"),
    "HOME_LATEST_NOTIFICATION" : MessageLookupByLibrary.simpleMessage("Latest notification"),
    "HOME_REPORT_LIST" : MessageLookupByLibrary.simpleMessage("Report list"),
    "HOME_SEE_ALL" : MessageLookupByLibrary.simpleMessage("See all"),
    "HOME_VIOLATION_LIST" : MessageLookupByLibrary.simpleMessage("Violation list"),
    "LANGUAGE" : MessageLookupByLibrary.simpleMessage("Language"),
    "LANGUAGE_EN" : MessageLookupByLibrary.simpleMessage("English"),
    "LANGUAGE_VN" : MessageLookupByLibrary.simpleMessage("Vietnamese"),
    "LOAD_FAIL" : MessageLookupByLibrary.simpleMessage("load fail!"),
    "LOGIN" : MessageLookupByLibrary.simpleMessage("Log in"),
    "LOGOUT" : MessageLookupByLibrary.simpleMessage("Log out"),
    "MONTH" : MessageLookupByLibrary.simpleMessage("Month"),
    "NEW_VIOLATION" : MessageLookupByLibrary.simpleMessage("New violation"),
    "NO" : MessageLookupByLibrary.simpleMessage("No"),
    "NOTIFICATION" : MessageLookupByLibrary.simpleMessage("Notifications"),
    "OF" : MessageLookupByLibrary.simpleMessage("of"),
    "PASSWORD" : MessageLookupByLibrary.simpleMessage("Password"),
    "POPUP_CREATE_VIOLATION_FAIL" : MessageLookupByLibrary.simpleMessage("CREATE NEW FAIL!"),
    "POPUP_CREATE_VIOLATION_SUBMITTING" : MessageLookupByLibrary.simpleMessage("PROCESSING REQUEST"),
    "POPUP_CREATE_VIOLATION_SUCCESS" : MessageLookupByLibrary.simpleMessage("CREATE NEW SUCCESSFULLY!"),
    "REGULATION" : MessageLookupByLibrary.simpleMessage("Regulation"),
    "REMOVE" : MessageLookupByLibrary.simpleMessage("Remove"),
    "REPORT" : MessageLookupByLibrary.simpleMessage("Report"),
    "REPORT_EDIT_SCREEN_QC_NOTE" : MessageLookupByLibrary.simpleMessage("Comment"),
    "REPORT_SCREEN_NO_REPORTS" : MessageLookupByLibrary.simpleMessage("There are no reports"),
    "SAVE" : MessageLookupByLibrary.simpleMessage("Save"),
    "SETTINGS" : MessageLookupByLibrary.simpleMessage("Settings"),
    "SORT_BY" : MessageLookupByLibrary.simpleMessage("Sort by"),
    "SUBMITTED_BY" : MessageLookupByLibrary.simpleMessage("Submitted by"),
    "SUBMIT_BUTTON" : MessageLookupByLibrary.simpleMessage("Submit"),
    "SUCCESS" : MessageLookupByLibrary.simpleMessage("success"),
    "THERE_IS_NO" : MessageLookupByLibrary.simpleMessage("There is no"),
    "UPDATED_ON" : MessageLookupByLibrary.simpleMessage("Updated on"),
    "VIOLATION" : MessageLookupByLibrary.simpleMessage("Violation"),
    "VIOLATION_CREATE_MODAL_ADD" : MessageLookupByLibrary.simpleMessage("Add"),
    "VIOLATION_CREATE_SCREEN_ADD_VIOLATION_CARD" : MessageLookupByLibrary.simpleMessage("New violation"),
    "VIOLATION_CREATE_SCREEN_DROPDOWN_FIELD" : MessageLookupByLibrary.simpleMessage("Branch"),
    "VIOLATION_SCREEN_CREATE_NEW_BUTTON" : MessageLookupByLibrary.simpleMessage("Create new"),
    "VIOLATION_SCREEN_FETCH_FAIL" : MessageLookupByLibrary.simpleMessage("Fetch fail"),
    "VIOLATION_SCREEN_NO_VIOLATIONS" : MessageLookupByLibrary.simpleMessage("There is no violations"),
    "VIOLATION_SCREEN_RELOAD" : MessageLookupByLibrary.simpleMessage("Reload"),
    "VIOLATION_STATUS" : MessageLookupByLibrary.simpleMessage("Status"),
    "VIOLATION_STATUS_CONFIRMED" : MessageLookupByLibrary.simpleMessage("Confirmed"),
    "VIOLATION_STATUS_EXCUSED" : MessageLookupByLibrary.simpleMessage("Excused"),
    "VIOLATION_STATUS_OPENING" : MessageLookupByLibrary.simpleMessage("Opening"),
    "VIOLATION_STATUS_REJECTED" : MessageLookupByLibrary.simpleMessage("Rejected"),
    "VIOLATION_SUBMITTED" : MessageLookupByLibrary.simpleMessage("Submit"),
    "YES" : MessageLookupByLibrary.simpleMessage("Yes"),
    "title" : MessageLookupByLibrary.simpleMessage("hello")
  };
}
