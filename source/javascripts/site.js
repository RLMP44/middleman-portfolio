function modifyText() {
  const textToModify = document.querySelectorAll(".bionic-target");

  textToModify.forEach((block) => {
    if (block.innerHTML.includes("<strong>")) {
      // reset to original
      block.textContent = block.textContent
    } else {
      var bionicText = convertToBionic(block.textContent);
      block.innerHTML = bionicText;
    }
  })
}

function convertToBionic(words) {
  var wordsArray = words.split(' ');
  var bionicArray = [];
  wordsArray.forEach((word) => {
    bionicWord = '';
    if (hasPunctuation(word) && hasHyphen(word)) {
      updatedWord = word.slice(0, -1);
      bionicWord = handleHyphen(updatedWord, word);
    } else if (hasHyphen(word)) {
      bionicWord = handleHyphen(null, word);
    } else if (hasPunctuation(word)) {
      updatedWord = word.slice(0, -1);
      numToHighlight = getAmountToHighlight(updatedWord);
      bionicWord = highlightWord(word, numToHighlight);
    } else {
      numToHighlight = getAmountToHighlight(word);
      bionicWord = highlightWord(word, numToHighlight);
    }
    bionicArray.push(bionicWord);
  })
  return bionicArray.join(' ');
};

function hasHyphen(word) {
  return word.includes('-');
};

function handleHyphen(noPuncWord, originalWord) {
  var wordArray = noPuncWord ? noPuncWord.split('-') : originalWord.split('-');
  var newWord = wordArray.map((word) => {
    const numToHighlight = getAmountToHighlight(word);
    return highlightWord(word, numToHighlight);
  }).join('-');
  return noPuncWord ? (newWord + originalWord.slice(-1)) : newWord;
};

function highlightWord(word, numToHighlight) {
  const firstHalf = word.slice(0, numToHighlight);
  const secondHalf = word.slice(numToHighlight);
  return `<strong>${firstHalf}</strong>${secondHalf}`;
};

function hasPunctuation(word) {
  return /\p{P}/u.test(word.slice(-1));
};

function getAmountToHighlight(word) {
  return Math.ceil(word.length / 2);
};
