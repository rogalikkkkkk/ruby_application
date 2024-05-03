module WorkHelper
  def image_data(theme, data)
    @image_data = {}
    @image_data[:values_qty] = data[:values_qty]
    @image_data[:theme] = theme
    @image_data[:current_user_id] = data[:current_user_id]
    @image_data[:theme_id] = data[:theme_id]
    @image_data[:index] = data[:index]
    @image_data[:images_arr_size]  = data[:images_arr_size]
    @image_data[:image_id]  = data[:image_id]
    @image_data[:name]  = data[:name]
    @image_data[:file]  = data[:file]
    @image_data[:user_valued]  = data[:user_valued]
    @image_data[:value]  = data[:value]
    @image_data[:common_ave_value]  = data[:common_ave_value]
    @image_data
  end
end
