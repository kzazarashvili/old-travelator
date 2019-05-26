module Admin::BaseHelper
  def order_by_link(name, attribute = nil)
    attribute ||= name.parameterize(separator: '_')

    link_to params.to_unsafe_h.merge({ order: attribute, direction: order_by_direction(attribute) == 'asc' ? 'desc' : 'asc' }) do
      raw name +
          content_tag(:i, nil, class: "fa fa-sort#{"-#{order_by_direction(attribute)}" unless order_by_direction(attribute).blank?}")
    end
  end
end
