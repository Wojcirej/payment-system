class Paginator
  class DataNotPaginable < StandardError; end

  attr_accessor :data, :page, :per_page

  PAGE = 1
  PER_PAGE = 25

  def initialize(data, page = nil, per_page = nil)
    @data = data
    @page = page || PAGE
    @per_page = per_page || PER_PAGE
  end

  def self.call(data, page, per_page)
    new(data, page, per_page).call
  end

  def call
    fail DataNotPaginable unless paginable?
    pagination_base.page(page).per(per_page)
  end

  private

  def pagination_base
    @pagination_base ||= data.is_a?(Array) ? Kaminari.paginate_array(data) : data
  end

  def paginable?
    data && (data.is_a?(Array) || data.is_a?(ActiveRecord::Relation))
  end
end
