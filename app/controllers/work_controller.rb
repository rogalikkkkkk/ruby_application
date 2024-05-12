class WorkController < ApplicationController
  require 'json'
  include WorkImage
  include WorkHelper

  skip_before_action :verify_authenticity_token

  def index
    @images_count = Image.all.count
    @selected_theme = "Select theme to leave your answer"
    @selected_image_name = 'Honda NSX NA2'
    @values_qty = Value.all.count
    @current_locale = I18n.locale
    @themes = Theme.all.pluck(:name)
    @default_image_name = 'honda.jpg'

    session[:selected_theme_id] = @selected_theme
  end

  def choose_theme
    @themes = Theme.all.pluck(:name)
    logger.info "In WorkController#choose_theme @themes = #{@themes}"
    respond_to :js
  end

  # @note: first display_theme and show first image from image array
  def display_theme
    logger.info "In work#display_theme"
    @image_data = {}
    I18n.locale = session[:current_locale]

    current_user_id = current_user.id
    if params[:theme] == "-----" #.blank?
      theme = "-----"
      theme_id = 1
      values_qty = Value.all.count.round
      data = { index: 0, name: 'Honda NSX NA2', values_qty: values_qty,
               file: 'honda.jpg', image_id: 1,
               current_user_id: current_user_id, user_valued: false,
               common_ave_value: 0, value: 0, theme_id: theme_id }
    else
      theme = params[:theme]
      theme_id = Theme.find_theme_id(theme)
      data = show_image(theme_id, 0)
    end
    session[:selected_theme_id] = theme_id

    image_data(theme, data)
  end

  def get_stats
    @selected_theme_id = session[:selected_theme_id]

    current_user_id = current_user.id
    res_composite_diag = Image.joins(:value)
      .select("images.name, images.created_at, images.file, values.value as user_value, values.created_at as mark_date, images.ave_value")
      .where("images.theme_id = :theme_id AND values.user_id = :user_id AND value <= images.ave_value + 25 AND value >= images.ave_value - 25", { theme_id: @selected_theme_id, user_id: current_user_id } )
      .order("value DESC")
    Rails.logger.info res_composite_diag
    composite_results_size = res_composite_diag.size

    @composite_results = res_composite_diag.take(composite_results_size)
    @composite_results_paged = pages_of(@composite_results, 10)
  end



  def results_list
    helpers = ActionController::Base.helpers
    images = Image.all
    image_stats = []

    images.each do |image|
      rated_by_user = Value.where(image_id: image.id, user_id: current_user.id).size != 0
      if rated_by_user
        user_value = Value.where(image_id: image.id, user_id: current_user.id)[0].value
      image_stats.push({
                         id: image.id,
                         theme: Theme.where(id: image.theme_id)[0].name,
                         imageAvgValue: Value.where(image_id: image.id).average(:value).to_f,
                         userValue: user_value,
                         name: image.name,
                         file: helpers.image_path(image.file),
                         created_at: image.created_at
                       })
      else
      end
    end

    respond_to do |format|
      format.html { render :results_list }
      format.json { render json: image_stats }
    end


  end


end
