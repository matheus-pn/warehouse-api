# frozen_string_literal: true

module ProductRelation
  module Create
    module_function
    extend CreateBase

    def _one(attributes)
      relation = Core::ProductRelation.create(attributes)
      rollback_if_insanity(relation)
    end

    # Sanity checks
    def rollback_if_insanity(relation)
      parent = relation.parent
      rollback_if_parent_equals_child(relation)
      rollback_if_parent_has_more_than_one_alias(parent)
      rollback_if_parent_has_composition_and_alias(parent)
      rollback_if_relation_achieves_recursion_limit(parent)
    end

    def rollback_if_parent_equals_child(relation)
      is_equal = relation.parent_id == relation.child_id

      raise NotImplementedError, "Bruh?" if is_equal
    end

    def rollback_if_parent_has_more_than_one_alias(parent)
      has_more_than_one = Core::ProductRelation.alias.where(parent:).count > 1

      raise NotImplementedError, "Bruh??" if has_more_than_one
    end

    def rollback_if_parent_has_composition_and_alias(parent)
      has_composition = Core::ProductRelation.component.exists?(parent:)
      has_alias = Core::ProductRelation.alias.exists?(parent:)

      raise NotImplementedError, "Bruh???" if has_composition && has_alias
    end

    def rollback_if_relation_achieves_recursion_limit(parent)
      raise NotImplementedError, "Bruh????" if parent.recursion_limit?
    end
  end
end
