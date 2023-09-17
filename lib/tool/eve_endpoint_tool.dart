
const _eveImageServerUrl = 'https://images.evetech.net/';

String getCharactersImage(String charactersId) {
  return '${_eveImageServerUrl}characters/$charactersId/portrait';
}

