final class AppConstants {
  static const String appName = "Lead App", stringPlaceHolder = "-";

  // Database consts
  static const String joinSplitPattern = "`,`";
  static const String tableLead = "lead";
  static const String fieldId = "id",
      fieldName = "name",
      fieldContactNumber = "contact_number",
      fieldPriority = "priority",
      fieldDiscussion = "discussion",
      fieldAddress = "address",
      fieldPhotos = "photos",
      fieldLatitude = "latitude",
      fieldLongitude = "longitude",
      fieldComments = "comment",
      fieldRecording = "recording",
      fieldWebsite = "website",
      fieldVisitingCard = "visiting_card";

  static const String queryCreateLeadTable =
      "CREATE TABLE $tableLead($fieldId INTEGER PRIMARY KEY, "
      "$fieldName TEXT, $fieldContactNumber TEXT, $fieldPriority TEXT, "
      "$fieldDiscussion TEXT, $fieldPhotos TEXT, $fieldLatitude REAL, "
      "$fieldLongitude REAL, $fieldComments TEXT, $fieldRecording TEXT,"
      "$fieldWebsite TEXT, $fieldVisitingCard TEXT, $fieldAddress TEXT)";
}
