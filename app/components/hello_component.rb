# frozen_string_literal: true

class HelloComponent < ViewComponent::Base
  def initialize(text:)
    @text = text
  end

end
