# frozen_string_literal: true

class CardComponent < ViewComponent::Base
  DEFAULT_CLASSES = %w[].freeze
  DEFAULT_ITEM_CLASSES = %w[grid-cols-2].freeze

  attr_accessor :fields, :classes, :item_classes

  def initialize(fields:, classes: "", item_classes: "")
    @fields = fields
    @classes = merge_classes(classes)
    @item_classes = merge_item_classes(item_classes)
  end

  def merge_classes(custom_classes)
    # Splitting ensures uniqueness; custom classes override duplicates
    (DEFAULT_CLASSES + custom_classes.split).uniq.join(" ")
  end

  def merge_item_classes(item_classes)
    (DEFAULT_ITEM_CLASSES + item_classes.split).uniq.join(" ")
  end
end
