module ApplicationHelper
	def titlize(title='')
		base_title = "DemoBlog"
		if title.blank?
			base_title
		else
			title + "|" + base_title
		end
	end

end
