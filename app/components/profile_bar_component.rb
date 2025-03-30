# frozen_string_literal: true

class ProfileBarComponent < ViewComponent::Base
  attr_accessor :heading_content, :current_user, :return_path

  def initialize(heading_content:, current_user:, return_path: nil)
    @heading_content = heading_content
    @current_user = current_user
    @return_path = return_path
  end
end
