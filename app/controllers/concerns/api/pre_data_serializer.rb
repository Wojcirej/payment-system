module Api::PreDataSerializer
  extend ActiveSupport::Concern

  DEFAULT_ROOT = :data

  def render(args)
    super default_render_args(args)
  end

  private

  def default_render_args(args)
    @default_render_args ||= args.merge(root: args[:root] || DEFAULT_ROOT)
  end
end
