module Api::PreDataSerializer
  extend ActiveSupport::Concern

  DEFAULT_ROOT = :data

  def render(args)
    return super if args[:skip_pagination]

    collection = Paginator.call(args[:json], params[:page], params[:per_page])
    super collection_args_for_render(default_render_args(args), collection)
  rescue Paginator::DataNotPaginable
   super default_render_args(args)
  end

  private

  def default_render_args(args)
    @default_render_args ||= args.merge(root: args[:root] || DEFAULT_ROOT)
  end

  def collection_args_for_render(args, collection)
    meta = collection_meta(collection, args[:meta] || {})
    args.merge(json: collection, meta: meta)
  end

  def collection_meta(collection, extra_meta = {})
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.prev_page,
      total_pages: collection.total_pages,
      total_count: collection.total_count
    }.merge(extra_meta)
  end
end
