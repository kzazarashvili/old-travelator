module Admin
  module BaseHelper
    def order_by_link(name, attribute = nil)
      attribute ||= name.parameterize(separator: '_')

      class_name = "-#{order_by_direction(attribute)}" if order_by_direction(attribute).present?

      options = {
        order: attribute,
        direction: order_by_direction(attribute) == 'asc' ? 'desc' : 'asc'
      }

      link_to params.to_unsafe_h.merge(options) do
        safe_join([name, content_tag(:i, nil, class: "fa fa-sort#{class_name}")])
      end
    end

    def paginate(objects, options = {})
      options.reverse_merge!(theme: 'twitter-bootstrap-4')

      super(objects, options)
    end
  end
end
