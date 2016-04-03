class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def render_400
    respond_to do |format|
      format.html { render file: Rails.root.join("public", "400"), layout: false, status: 400 }
      format.json { render_failed_json I18n.t("server.bad_request"), status: 400 }
    end
  end

  def render_403
    if (request.format && request.format.json?) || request.xhr?
      render_failed_json I18n.t("server.forbidden"), status: 403
    else
      render file: Rails.root.join("public", "403"), layout: false, status: 403
    end
  end

  def render_404
    if (request.format && request.format.json?) || request.xhr?
      render_failed_json I18n.t("server.not_found"), status: 404
    else
      render file: Rails.root.join("public", "404"), layout: false, status: 404
    end
  end

  def render_500
    respond_to do |format|
      format.html { render file: Rails.root.join("public", "500"), layout: false, status: 500 }
      format.json { render_failed_json I18n.t("server.generic_error"), status: 500 }
    end
  end
end
