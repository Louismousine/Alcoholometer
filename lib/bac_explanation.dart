class BacExplanation {

  var explanations = {
    '.02': ['Feeling relaxed', 'Slight sense of euphoria'],
    '.05': ['Emotions are intensified: good moods are better, bad moods are worse', 'Exaggerated behavior: louder talk, bolder actions', 'Impaired judgment', 'Reduced coordination'],
    '.08': ['Legal limit at which one can drive', 'Slurred speech', 'More coordination loss', 'Slower reaction times', 'Reasoning, judgment, concentration, and memory will be impaired', 'Beginning to lose balance'],
    '.12': ['Slurred speech', 'Reduced control and reaction time', 'Poor ability to coordinate legs and arms'],
    '.15': ['Gross motor impairment and lack of physical control', 'Severely impaired judgment and perception', 'Blurred vision and major loss of balance', 'Vomiting may begin'],
    '.20': ['All mental, physical and sensory functions are severely impaired', 'Possibility of blacking out', 'Nausea & vomiting', 'No sense of pain'],
    '.30': ['Loss of consciousness'],
    '.40': ['May be put in a coma', 'Death in some cases'],
  }

  List<String> getBacExplanations(String key) {
    return explanations[key];
  }
}