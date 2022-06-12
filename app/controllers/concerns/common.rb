# frozen_string_literal: true

module Common
  def without_timestamps(model)
    model.as_json(except: %i[created_at updated_at])
  end
end
