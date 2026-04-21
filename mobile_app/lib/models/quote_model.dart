class QuoteModel {
  final String quoteId;
  final String text;
  final String author;
  final String category;
  final int popularityScore;
  final DateTime? createdAt;

  QuoteModel({
    required this.quoteId,
    required this.text,
    required this.author,
    required this.category,
    this.popularityScore = 0,
    this.createdAt,
  });

  factory QuoteModel.fromMap(Map<String, dynamic> map) {
    return QuoteModel(
      quoteId: map['quote_id'] ?? '',
      text: map['text'] ?? '',
      author: map['author'] ?? 'Unknown',
      category: map['category'] ?? 'Motivation',
      popularityScore: map['popularity_score'] ?? 0,
      createdAt: map['created_at'] != null 
          ? DateTime.fromMillisecondsSinceEpoch(map['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quote_id': quoteId,
      'text': text,
      'author': author,
      'category': category,
      'popularity_score': popularityScore,
      'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }

  // Curated Psychological Quote Dataset - Production Local Cache Fallback
  static List<QuoteModel> get initialList => [
        // Resilience & Stoicism
        QuoteModel(quoteId: 'q_res_1', text: 'You have power over your mind - not outside events. Realize this, and you will find strength.', author: 'Marcus Aurelius', category: 'Resilience', popularityScore: 420),
        QuoteModel(quoteId: 'q_res_2', text: 'He who has a why to live for can bear almost any how.', author: 'Friedrich Nietzsche', category: 'Resilience', popularityScore: 385),
        QuoteModel(quoteId: 'q_res_3', text: 'The gem cannot be polished without friction, nor man perfected without trials.', author: 'Seneca', category: 'Resilience', popularityScore: 310),
        QuoteModel(quoteId: 'q_res_4', text: 'Hardships often prepare ordinary people for an extraordinary destiny.', author: 'C.S. Lewis', category: 'Resilience', popularityScore: 295),
        QuoteModel(quoteId: 'q_res_5', text: 'The impediment to action advances action. What stands in the way becomes the way.', author: 'Marcus Aurelius', category: 'Resilience', popularityScore: 440),
        QuoteModel(quoteId: 'q_res_6', text: 'Our greatest glory is not in never falling, but in rising every time we fall.', author: 'Confucius', category: 'Resilience', popularityScore: 360),
        QuoteModel(quoteId: 'q_res_7', text: 'Rock bottom became the solid foundation on which I rebuilt my life.', author: 'J.K. Rowling', category: 'Resilience', popularityScore: 395),
        QuoteModel(quoteId: 'q_res_8', text: 'The oak fought the wind and broke, the willow bent when it must and survived.', author: 'Robert Jordan', category: 'Resilience', popularityScore: 280),
        QuoteModel(quoteId: 'q_res_9', text: 'Persistence and resilience only come from having been given the chance to work through difficult problems.', author: 'Gabor Maté', category: 'Resilience', popularityScore: 315),
        QuoteModel(quoteId: 'q_res_10', text: 'Turn your wounds into wisdom.', author: 'Oprah Winfrey', category: 'Resilience', popularityScore: 410),

        // Focus & Productivity
        QuoteModel(quoteId: 'q_foc_1', text: 'Starve your distractions, feed your focus.', author: 'Daniel Goleman', category: 'Focus', popularityScore: 450),
        QuoteModel(quoteId: 'q_foc_2', text: 'The successful warrior is the average man, with laser-like focus.', author: 'Bruce Lee', category: 'Focus', popularityScore: 500),
        QuoteModel(quoteId: 'q_foc_3', text: 'Concentrate all your thoughts upon the work at hand. The sun\'s rays do not burn until brought to a focus.', author: 'Alexander Graham Bell', category: 'Focus', popularityScore: 330),
        QuoteModel(quoteId: 'q_foc_4', text: 'Lack of direction, not lack of time, is the problem. We all have twenty-four hour days.', author: 'Zig Ziglar', category: 'Focus', popularityScore: 410),
        QuoteModel(quoteId: 'q_foc_5', text: 'Focus is a matter of deciding what things you\'re not going to do.', author: 'John Carmack', category: 'Focus', popularityScore: 390),
        QuoteModel(quoteId: 'q_foc_6', text: 'What you focus on expands, and when you focus on the goodness in your life, you create more of it.', author: 'Deepak Chopra', category: 'Focus', popularityScore: 355),
        QuoteModel(quoteId: 'q_foc_7', text: 'Energy is the essence of life. Every day you decide how you’re going to use it by knowing what you want and what it takes to reach that goal.', author: 'Oprah Winfrey', category: 'Focus', popularityScore: 320),
        QuoteModel(quoteId: 'q_foc_8', text: 'It is those who concentrate on but one thing at a time who advance in this world.', author: 'Og Mandino', category: 'Focus', popularityScore: 275),
        QuoteModel(quoteId: 'q_foc_9', text: 'Multitasking is a lie.', author: 'Gary Keller', category: 'Focus', popularityScore: 480),
        QuoteModel(quoteId: 'q_foc_10', text: 'Your goal should be to be out of the rat race, not to win it.', author: 'Naval Ravikant', category: 'Focus', popularityScore: 520),

        // Mindfulness & Peace
        QuoteModel(quoteId: 'q_min_1', text: 'Peace comes from within. Do not seek it without.', author: 'Buddha', category: 'Mindfulness', popularityScore: 520),
        QuoteModel(quoteId: 'q_min_2', text: 'Worry does not empty tomorrow of its sorrow. It empties today of its strength.', author: 'Corrie Ten Boom', category: 'Mindfulness', popularityScore: 480),
        QuoteModel(quoteId: 'q_min_3', text: 'Smile, breathe and go slowly.', author: 'Thich Nhat Hanh', category: 'Mindfulness', popularityScore: 390),
        QuoteModel(quoteId: 'q_min_4', text: 'The present moment is the only time over which we have dominion.', author: 'Thích Nhất Hạnh', category: 'Mindfulness', popularityScore: 345),
        QuoteModel(quoteId: 'q_min_5', text: 'Mindfulness is deliberate. It is an act of training.', author: 'Sharon Salzberg', category: 'Mindfulness', popularityScore: 310),
        QuoteModel(quoteId: 'q_min_6', text: 'The soul always knows what to do to heal itself. The challenge is to silence the mind.', author: 'Caroline Myss', category: 'Mindfulness', popularityScore: 430),
        QuoteModel(quoteId: 'q_min_7', text: 'Quiet the mind, and the soul will speak.', author: 'Ma Jaya Sati Bhagavati', category: 'Mindfulness', popularityScore: 395),
        QuoteModel(quoteId: 'q_min_8', text: 'Meditation is not a way of making your mind quiet. It is a way of entering into the quiet that is already there.', author: 'Deepak Chopra', category: 'Mindfulness', popularityScore: 370),
        QuoteModel(quoteId: 'q_min_9', text: 'Your calm mind is the ultimate weapon against your challenges.', author: 'Bryant McGill', category: 'Mindfulness', popularityScore: 415),
        QuoteModel(quoteId: 'q_min_10', text: 'Breathe. Letting go is exactly what is happening.', author: 'Elizabeth Gilbert', category: 'Mindfulness', popularityScore: 290),

        // Growth Mindset
        QuoteModel(quoteId: 'q_gro_1', text: 'The only limit to our realization of tomorrow will be our doubts of today.', author: 'Franklin D. Roosevelt', category: 'Growth', popularityScore: 375),
        QuoteModel(quoteId: 'q_gro_2', text: 'Anyone who has never made a mistake has never tried anything new.', author: 'Albert Einstein', category: 'Growth', popularityScore: 510),
        QuoteModel(quoteId: 'q_gro_3', text: 'It does not matter how slowly you go as long as you do not stop.', author: 'Confucius', category: 'Growth', popularityScore: 490),
        QuoteModel(quoteId: 'q_gro_4', text: 'The mind is just like a muscle - the more you exercise it, the stronger it gets and the more it can expand.', author: 'Idowu Koyenikan', category: 'Growth', popularityScore: 280),
        QuoteModel(quoteId: 'q_gro_5', text: 'Become the person who can achieve the goals you set.', author: 'Jim Rohn', category: 'Growth', popularityScore: 425),
        QuoteModel(quoteId: 'q_gro_6', text: 'The hand that will not perform is the hand that will not provide.', author: 'Proverb', category: 'Growth', popularityScore: 210),
        QuoteModel(quoteId: 'q_gro_7', text: 'Everything you’ve ever wanted is on the other side of fear.', author: 'George Addair', category: 'Growth', popularityScore: 505),
        QuoteModel(quoteId: 'q_gro_8', text: 'The only way to do great work is to love what you do.', author: 'Steve Jobs', category: 'Growth', popularityScore: 530),
        QuoteModel(quoteId: 'q_gro_9', text: 'If you want to be happy, do not dwell in the past, do not worry about the future, focus on living fully in the present.', author: 'Roy T. Bennett', category: 'Growth', popularityScore: 365),
        QuoteModel(quoteId: 'q_gro_10', text: 'Your time is limited, so don\'t waste it living someone else\'s life.', author: 'Steve Jobs', category: 'Growth', popularityScore: 475),

        // Success & Leadership
        QuoteModel(quoteId: 'q_suc_1', text: 'Success is not final, failure is not fatal: it is the courage to continue that counts.', author: 'Winston Churchill', category: 'Success', popularityScore: 580),
        QuoteModel(quoteId: 'q_suc_2', text: 'Leadership is not about being in charge. It is about taking care of those in your charge.', author: 'Simon Sinek', category: 'Leadership', popularityScore: 410),
        QuoteModel(quoteId: 'q_suc_3', text: 'I find that the harder I work, the more luck I seem to have.', author: 'Thomas Jefferson', category: 'Success', popularityScore: 395),
        QuoteModel(quoteId: 'q_suc_4', text: 'Do not go where the path may lead, go instead where there is no path and leave a trail.', author: 'Ralph Waldo Emerson', category: 'Success', popularityScore: 450),
        QuoteModel(quoteId: 'q_suc_5', text: 'The goal of a leader is not to create more followers, but to create more leaders.', author: 'Tom Peters', category: 'Leadership', popularityScore: 380),
        QuoteModel(quoteId: 'q_suc_6', text: 'Success is walking from failure to failure with no loss of enthusiasm.', author: 'Winston Churchill', category: 'Success', popularityScore: 420),
        QuoteModel(quoteId: 'q_suc_7', text: 'The best way to predict your future is to create it.', author: 'Abraham Lincoln', category: 'Success', popularityScore: 540),
        QuoteModel(quoteId: 'q_suc_8', text: 'To lead people, walk beside them.', author: 'Lao Tzu', category: 'Leadership', popularityScore: 310),
        QuoteModel(quoteId: 'q_suc_9', text: 'Action is the foundational key to all success.', author: 'Pablo Picasso', category: 'Success', popularityScore: 335),

        // Wisdom & Courage
        QuoteModel(quoteId: 'q_wis_1', text: 'The only true wisdom is in knowing you know nothing.', author: 'Socrates', category: 'Wisdom', popularityScore: 490),
        QuoteModel(quoteId: 'q_wis_2', text: 'Courage is not the absence of fear, but rather the assessment that something else is more important than fear.', author: 'Franklin D. Roosevelt', category: 'Courage', popularityScore: 415),
        QuoteModel(quoteId: 'q_wis_3', text: 'Knowing yourself is the beginning of all wisdom.', author: 'Aristotle', category: 'Wisdom', popularityScore: 505),
        QuoteModel(quoteId: 'q_wis_4', text: 'Fortune favors the bold.', author: 'Virgil', category: 'Courage', popularityScore: 360),
        QuoteModel(quoteId: 'q_wis_5', text: 'Wisdom begins in wonder.', author: 'Socrates', category: 'Wisdom', popularityScore: 340),
        QuoteModel(quoteId: 'q_wis_6', text: 'Courage is being scared to death, but saddling up anyway.', author: 'John Wayne', category: 'Courage', popularityScore: 310),
        QuoteModel(quoteId: 'q_wis_7', text: 'Be kind, for everyone you meet is fighting a hard battle.', author: 'Plato', category: 'Wisdom', popularityScore: 485),
        QuoteModel(quoteId: 'q_wis_8', text: 'Out of clutter, find simplicity.', author: 'Albert Einstein', category: 'Wisdom', popularityScore: 420),
        QuoteModel(quoteId: 'q_wis_9', text: 'He who is brave is free.', author: 'Seneca', category: 'Courage', popularityScore: 380),
        QuoteModel(quoteId: 'q_wis_10', text: 'The journey of a thousand miles begins with one step.', author: 'Lao Tzu', category: 'Wisdom', popularityScore: 550),
      ];
}
