# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def convert_to_bionic(words)
    words_array = words.split(' ')
    bionic_array = []
    words_array.each do |word|
      bionic_word = ''
      if has_punctuation?(word) && has_hyphen?(word)
        updated_word = word.chomp(word[-1])
        bionic_word = handle_hyphen(updated_word)
      elsif has_hyphen?(word)
        bionic_word = handle_hyphen(word)
      elsif has_punctuation?(word)
        updated_word = word.chomp(word[-1])
        num_to_highlight = get_amount_to_highlight(updated_word)
        bionic_word = highlight_word(word, num_to_highlight)
      else
        num_to_highlight = get_amount_to_highlight(word)
        bionic_word = highlight_word(word, num_to_highlight)
      end
      # no_punc_word = word.chomp(word[-1]) if has_punctuation?(word)

      # num_to_highlight = get_amount_to_highlight(no_punc_word || word)
      # bionic_word = highlight_word(word, num_to_highlight)
      bionic_array.push(bionic_word)
    end
    bionic_array.join(' ')
  end

  def has_hyphen?(word)
    word.include?('-')
  end

  def handle_hyphen(word)
    word_array = word.split('-')
    word_array.each.map do |word|
      num_to_highlight = get_amount_to_highlight(word)
      highlight_word(word, num_to_highlight)
    end.join('-')
  end

  def highlight_word(word, num_to_highlight)
    first_half = word[0, num_to_highlight]
    second_half = word[num_to_highlight..]
    return "<strong>#{first_half}</strong>#{second_half}"
  end

  def has_punctuation?(word)
    word[-1] =~ /\p{P}/ ? true : false
  end

  def get_amount_to_highlight(word)
    (word.length.to_f / 2).ceil
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
