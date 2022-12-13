enum SearchType {
  title, description, participants
}

class Globals {
  static List<String> allTypes = ['AVALIADOR', 'AVALIADOR_ADJUNTO', 'TREINADOR'];
  static String searchCharacters = '';
  static SearchType searchType = SearchType.title;
}