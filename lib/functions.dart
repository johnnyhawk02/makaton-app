String insideBrackets(String s) => s.split("(")[1].split(")")[0];

String beforeBrackets(String s) => s.split("(")[0];

String afterBrackets(String s) {
  if (s.split(")").length > 0) {
    return s.split(")")[1];
  } else {
    return '';
  }
}

String XXspaceToUnderscore(String s) => s.replaceAll(' ', '_');

String spaceToWebSpace(String s) => s.replaceAll(' ', '%20');


String XXunderscoreToSpace(String s) => s.replaceAll('_', ' ');

String removeDash(String s)=> s.replaceAll('-', '');

String removeIllegalCharacters(String n) {
  const String allowed =
      "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_ ";
  String newString = "";

  for (int i = 0; i < n.length; i++) {
    if (allowed.contains(n[i])) {
      newString += n[i];
    }
  }
  return newString;
}

