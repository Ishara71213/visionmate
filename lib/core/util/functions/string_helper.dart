String removeGoto(String word) {
  word = word.toLowerCase();
  String replacement = "";
  String substr = "go to ";
  String newStr = word.replaceFirstMapped(substr, (match) => replacement);
  print(newStr);
  return newStr;
}

String removeWord(String word, String removeWord) {
  word = word.toLowerCase();
  String replacement = "";
  String substr = "$removeWord ";
  String newStr = word.replaceFirstMapped(substr, (match) => replacement);
  print(newStr);
  return newStr;
}
