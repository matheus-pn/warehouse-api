# frozen_string_literal: true

module CreateBase
  def many(attribute_ary = [])
    Core::Division.transaction do
      attribute_ary.map { |att| _one(att) }
    end
  end

  def _one(*)
    raise NotImplementedError, "_one"
  end
  protected :_one

  def one(attributes)
    ApplicationRecord.transaction { _one(attributes) }
  end
end
