require 'digest/md5'
module CustomHelpers
  def gravatar_for(email)
    hash = Digest::MD5.hexdigest(email.chomp.downcase)
    "http://www.gravatar.com/avatar/#{hash}"
  end
  
  def print_summary(article)
    unless article.summary.nil?
      close_tag = ''
      close_tag = '</p>' if article.body.length > article.summary.length
      "#{article.summary}#{close_tag}"
    end
  end
end
