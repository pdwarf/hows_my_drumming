module ReactionsHelper
    def reaction_stats(reactions)
      reactions.group(:emoji).count
    end
  
    def emoji_for(emoji_key)
      {
        thumbs_up: "👍",
        confetti: "🎉",
        horns: "🤘",
        dancer: "💃",
        thinking_face: "🤔",
        thumbs_down: "👎",
        shushing_face: "🤫",
        person_gesturing_no: "🙅",
        sparkling_heart: "💖"
      }[emoji_key.to_sym]
    end
  end