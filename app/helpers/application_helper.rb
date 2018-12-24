module ApplicationHelper

  def gravatar_for(user, options = { size: 80, styles: "" })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    additional_styles = options[:styles]

    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: user.username, class: "rounded-circle #{additional_styles}")
  end
end
