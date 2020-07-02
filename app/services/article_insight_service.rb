class ArticleInsightService

  def initialize(body)
    @body = body
  end

  def word_count
    @body.split(" ").count
  end

  def vowels_count
    @body.chars.count {|c| c =~ /[aeiou]/i }
  end

  def count_letter_o
    @body.chars.count {|c| c =~ /[o]/i }
  end

  def reading_time
    count = word_count
    mins = count/200
    secs =  (((count/200.to_f%1).round(2) * 0.60).round(2) * 100).round(0)
    return "#{mins}minutes #{secs} seconds"
  end

  # def num_of_paras
  #
  # end

end
