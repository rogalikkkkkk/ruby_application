class WorkController < ApplicationController

  include WorkHelper

  def show_image(theme_id, image_index)
    theme_images = Image.theme_images(theme_id)

    current_user_id = 0
    # TODO: поменять на нормальный айди

    Rails.logger.info "In show_image: current_user_id =  #{current_user_id.inspect} "

    one_image_attr = theme_images[image_index]
    Rails.logger.info "In show_image: one_image_attr =  #{one_image_attr.inspect} "

    image_id = one_image_attr['id']
    Rails.logger.info "In show_image: image_id = #{image_id.inspect} "

    # TODO: с этим не работало, потом поменять
    # user_valued, value = Value.user_valued_exists(current_user_id, image_id)

    # Rails.logger.info "In show_image: user_valued = #{user_valued.inspect} "

    values_qty = Value.all.count.round
    user_valued = 1

    if user_valued == 1
      common_ave_value = Image.find(image_id).ave_value
      Rails.logger.info "In 1show_image: common_ave_value = #{common_ave_value.inspect} "
      common_ave_value = 0 if common_ave_value.blank?
      common_ave_value.round unless common_ave_value.blank?
      Rails.logger.info "In 2show_image: common_ave_value = #{common_ave_value.inspect} "
    else
      common_ave_value = 0
    end

    data = { index: image_index,
             values_qty:,
             current_user_id:,
             theme_id:,
             images_arr_size: theme_images.size,
             image_id:,
             name: one_image_attr['name'],
             file: one_image_attr['file'],
             # user_valued:,
             # value:,
             common_ave_value: }
    Rails.logger.info "In show_image:  data = #{data.inspect} "
    data
  end

  def index
    @images_count = Image.all.count
    @selected_theme = "Select theme to leave your answer"
    # @selected_theme = t(".def_select_theme")
    @selected_image_name = 'радуга'
    @values_qty = Value.all.count
    @current_locale = I18n.locale
    @default_image_name = 'honda.jpg'
    session[:selected_theme_id] = @selected_theme # to display nothing
    theme_id = 2
    data = show_image(theme_id, 0)
    @image_data = image_data(theme_id, data)
  end

  def choose_theme
    @themes = Theme.all.pluck(:name)
    respond_to :js
  end

  # @note: first display_theme and show first image from image array
  def display_theme
    @image_data = {}
    I18n.locale = session[:current_locale]

    current_user_id = current_user.id
    if params[:theme] == "-----" #.blank?
      theme = "Select theme to leave your answer"
      theme_id = 1
      values_qty = Value.all.count.round
      data = { index: 0, name: 'Honda NSX NA2', values_qty: values_qty,
               file: 'honda.jpg', image_id: 1,
               current_user_id: current_user_id, user_valued: false,
               common_ave_value: 0, value: 0 }
    else
      theme = params[:theme]
      theme_id = Theme.find_theme_id(theme)
      data = show_image(theme_id, 0)
    end
    session[:selected_theme_id] = theme_id
    image_data(theme, data)
  end


end
