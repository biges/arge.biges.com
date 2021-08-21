require 'digest/md5'
module CustomHelpers
  def gravatar_for(email)
    hash = Digest::MD5.hexdigest(email.chomp.downcase)
    "http://www.gravatar.com/avatar/#{hash}"
  end
  
  def print_summary(article, **options)
    p_class = ""
    p_class = " class=\"#{options[:class]}\"" if options[:class]
    keep_tags = options[:keep_tags] || []

    unless article.summary.nil?
      text = remove_tags(article.summary, *keep_tags)
      "<p#{p_class}>#{text}</p>"
    end
  end
  
  def remove_tags(text, *keep_tags)
    keep_tags = ['code', 'strong'] if keep_tags.empty?
    Sanitize.fragment(text, elements: keep_tags).chomp
  end
end
