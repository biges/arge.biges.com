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
  
  def vimeo(title, video_id, h_value, app_id=nil)
    app_id = '58479' if app_id.nil?

    out = ['<div class="flash-video"><div>']
    out << '<iframe '
    out << "src=\"https://player.vimeo.com/video/#{video_id}?badge=0&amp;autopause=0&amp;player_id=0&amp;app_id=#{app_id}&amp;h=#{h_value}\" "
    out << 'width="100%" height="100%" frameborder="0" '
    out << 'allow="autoplay; fullscreen; picture-in-picture" allowfullscreen '
    out << "title=\"#{title}\">"
    out << '</iframe>'
    out << '</div>'
    out << '</div>'
    out.join
  end
end
