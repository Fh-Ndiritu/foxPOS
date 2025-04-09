class ItemThumbnailComponent < ViewComponent::Base
  DEFAULT_CLASSES = %w[
    item-thumbnail category-thumbnail rounded-lg h-48 w-48 md:h-48 lg:h-48 text-normal text-white hover:text-text-secondary duration-200 bg-bg-secondary hover:bg-bg-tertiary
  ].freeze

  attr_reader :image_url, :title, :count, :svg, :classes, :href, :data

  def initialize(image_url: nil, title:, count:, svg: nil, classes: "", href:, data: {})
    @image_url = image_url
    @title = title
    @count = count
    @svg = svg
    @classes = classes
    @href = href
    @data = data
    @classes = merge_classes(classes)
  end

  private

  def merge_classes(custom_classes)
    # Splitting ensures uniqueness; custom classes override duplicates
    (DEFAULT_CLASSES + custom_classes.split).uniq.join(" ")
  end
end
