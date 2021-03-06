module StoriesHelper

  def language
    if martian?
      'English'
    else
      'Martian'
    end
  end

  def toggleable_text(text)
    if martian?
      to_martian(text)
    else
      text
    end
  end

  private

  def to_martian(text)
    text.gsub(/[\w']{4,}/i) do |word|
      if word[0].match(/[[:upper:]]/)
        'Boinga'
      else
        'boinga'
      end
    end
  end

  def martian?
    params[:language] == 'Martian'
  end

end
