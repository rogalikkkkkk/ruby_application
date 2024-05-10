# frozen_string_literal: true

class ApiController < ApplicationController
  include WorkImage

  def next_image
    helpers = ActionController::Base.helpers
    current_index = params[:index].to_i
    theme_id = params[:theme_id].to_i
    length = Image.theme_images(theme_id).size

    new_image_index = next_index(current_index, length)
    next_image_data = show_image(theme_id, new_image_index)

    respond_to do |format|
      if new_image_index.blank?
        format.html { render nothing: true, status: :unprocessable_entity }
        format.json {}
      else
        format.json do
          render json: {
            new_image_index: next_image_data[:index],
            name: next_image_data[:name],
            file: helpers.image_path(next_image_data[:file]),
            image_id: next_image_data[:image_id],
            user_valued: next_image_data[:user_valued],
            common_ave_value: next_image_data[:common_ave_value],
            value: next_image_data[:value],
            status: :ok,
            notice: 'Successfully listed to next'
          }
        end
        format.html do
          render display_theme_path, status: :ok
        end
      end
    end
  end

  def prev_image
    helpers = ActionController::Base.helpers
    current_index = params[:index].to_i
    theme_id = params[:theme_id].to_i
    length = Image.theme_images(theme_id).size

    new_image_index = prev_index(current_index, length)
    next_image_data = show_image(theme_id, new_image_index)

    respond_to do |format|
      if new_image_index.blank?
        format.html { render nothing: true, status: :unprocessable_entity }
        format.json {}
      else
        format.json do
          render json: {
            new_image_index: next_image_data[:index],
            name: next_image_data[:name],
            file: helpers.image_path(next_image_data[:file]),
            image_id: next_image_data[:image_id],
            user_valued: next_image_data[:user_valued],
            common_ave_value: next_image_data[:common_ave_value],
            value: next_image_data[:value],
            status: :ok,
            notice: 'Successfully listed to next'
          }
        end
        format.html do
          render display_theme_path, status: :ok
        end
      end
    end
  end
  def next_index(index, length)
    new_index = index
    index < length - 1 ? new_index += 1 : new_index = 0
    new_index
  end

  def prev_index(index, length)
    new_index = index
    index.positive? ? new_index -= 1 : new_index = length - 1
    new_index
  end
end
