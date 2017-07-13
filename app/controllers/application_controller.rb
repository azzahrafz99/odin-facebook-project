class ApplicationController < ActionController::Base
  around_filter :render_404
  protect_from_forgery with: :exception
  include SessionsHelper

  private

  def render_404
    yield
  rescue ActiveRecord::RecordNotFound
    render file: "#{Rails.root}/public/404.html", status: 404, layout: false
  end
end
