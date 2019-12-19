main() {
  String sentence = 'that is fantastic!';
  print (simplify(sentence));
}

String simplify(sentence){
  String newSentence = '';
  for (String word in sentence.split(' ')){
    if (thesaurus.containsKey(word)){
    newSentence += thesaurus[word] + ' ';
    }else{
      newSentence += word + ' ';
    }
  }
  return newSentence;
}

Map  <String,String> thesaurus = {
  'fantastic': 'good',
  'great': 'good',
};