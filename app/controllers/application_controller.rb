class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :authenticate_user!

  before_action :set_active_storage_url_options

  after_action :render_flash_if_turbo

  private

  def set_active_storage_url_options
    ActiveStorage::Current.url_options = { host: request.host, protocol: request.protocol.delete_suffix(":"), port: request.port }
  end

  def render_flash_if_turbo
    return unless request.xhr? && turbo_frame_request?

    render "layouts/flash" # This will render the flash Turbo Stream
  end



end
