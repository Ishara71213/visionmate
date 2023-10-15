String removeGoto(String word) {
  word = word.toLowerCase();
  String replacement = "";
  String substr = "go to ";
  String newStr = word.replaceFirstMapped(substr, (match) => replacement);
  print(newStr);
  return newStr;
}
