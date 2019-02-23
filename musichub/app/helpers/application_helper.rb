module ApplicationHelper
	def verbose_date(date)
		date.strftime('%B %d %Y')
	end

	def user_avatar(user, size)
		if user.avatar.attached?
		  user.avatar.variant(resize: "#{size}x#{size}!")
		else
		  gravatar_image_url(user.email, size: size)
		end
	end
end
