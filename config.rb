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
      no_punc_word = word.chomp(word[-1]) if has_punctuation?(word)
      num_to_highlight = get_amount_to_highlight(no_punc_word || word)
      first_half = word[0, num_to_highlight]
      second_half = word[num_to_highlight..]
      bionic_array.push("<strong>#{first_half}</strong>#{second_half}")
    end
    bionic_array.join(' ')
  end

  def has_punctuation?(word)
    word[-1] =~ /\p{P}/ ? true : false
  end

  def get_amount_to_highlight(word)
    (word.length / 2).ceil
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

# configure :build do
#   activate :minify_css
#   activate :minify_javascript
# end
