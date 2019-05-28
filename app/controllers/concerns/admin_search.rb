module AdminSearch
  extend ActiveSupport::Concern

  included do
    SEARCH_ATTRIBUTES = [{ name: 'id', method: :exact, type: :integer }].freeze

    helper_method :order_by_direction
  end

  # @param model [ActiveRecord::Base]
  def search(model)
    return model if params[:query].blank?

    keywords = {}

    params[:query].split(' ').each_with_index do |keyword, i|
      keywords["like_#{i}".to_sym] = "%#{keyword}%"
      keywords["exact_#{i}".to_sym] = keyword
      parts = []

      self.class::SEARCH_ATTRIBUTES.each do |attribute|
        if attribute[:type] == :integer
          keywords["exact_#{i}".to_sym] = keyword.to_i
          parts << "#{attribute[:name]} = :exact_#{i}"

        else
          parts << part_for(attribute, i)
        end
      end

      model = model.where(parts.join(' OR '), keywords)
    end

    model
  end

  def order_by_direction(attribute)
    order_by[:attribute] == attribute ? order_by[:direction] : nil
  end

  def order_by
    if params[:order] && params[:direction]
      {
        attribute: params[:order],
        direction: params[:direction],
        value: "#{params[:order]} #{params[:direction].upcase}"
      }

    else
      { attribute: 'id', direction: 'desc', value: { id: :desc } }
    end
  end

  private

  def part_for(attribute, index)
    case attribute[:method]
    when :like
      "#{attribute[:name]} ILIKE :like_#{index}"
    else
      "#{attribute[:name]} = :exact_#{index}"
    end
  end
end
