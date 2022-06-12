# frozen_string_literal: true

module Dash
  class DashboardController < ApplicationController
    def hello
      render(HelloComponent.new(text: "Hello World"))
    end
  end
end
