class ApplicationController < ActionController::Base
  include SessionsHelper

  def index
    @image_data =
      render :template => "layouts/application"
  end

  before_action :set_locale

  def extr_locale_in_accept_lang
    locale = params[:locale]
    logger.info "In extr_locale_in_accept_lang: locale =
 #{locale}"
  end

  private

  def set_locale_from_params
    if params[:locale]
      extr_locale_in_accept_lang
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
        logger.info flash.now[:notice]
      else
        flash.now[:alarm] = " #{params[:locale]} Перевод страницы отсутствует"
        logger.error flash.now[:alarm]
      end
      params[:locale]
    end
  end

  def set_locale
    I18n.locale = set_locale_from_params || I18n.default_locale
    Rails.application.routes.default_url_options[:locale] = I18n.locale
  end

  def pages_of(data, records_per_pages)
    unless data.kind_of?(Array)
      data.page(params[:page]).per(records_per_pages)
    else
      Kaminari.paginate_array(data).page(params[:page]).per(records_per_pages)
    end
  end

end
