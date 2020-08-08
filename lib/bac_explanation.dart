class BacExplanation {
  static List<String> getBacExplanations(String key) {
    Map<String, List<String>> explanations = {
      '0.02': ['Feeling relaxed', 'Slight sense of euphoria'],
      '0.05': [
        'Emotions are intensified: good moods are better, bad moods are worse',
        'Exaggerated behavior: louder talk, bolder actions',
        'Impaired judgment',
        'Reduced coordination'
      ],
      '0.08': [
        'Legal limit at which one can drive',
        'Slurred speech',
        'More coordination loss',
        'Slower reaction times',
        'Reasoning, judgment, concentration, and memory will be impaired',
        'Beginning to lose balance'
      ],
      '0.12': [
        'Slurred speech',
        'Reduced control and reaction time',
        'Poor ability to coordinate legs and arms'
      ],
      '0.15': [
        'Gross motor impairment and lack of physical control',
        'Severely impaired judgment and perception',
        'Blurred vision and major loss of balance',
        'Vomiting may begin'
      ],
      '0.20': [
        'All mental, physical and sensory functions are severely impaired',
        'Possibility of blacking out',
        'Nausea & vomiting',
        'No sense of pain'
      ],
      '0.30': ['Loss of consciousness'],
      '0.40': ['May be put in a coma', 'Death in some cases'],
    };

    return explanations[key];
  }
}
