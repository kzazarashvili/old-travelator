module AdminSearch
  extend ActiveSupport::Concern

  included do
    SEARCH_ATTRIBUTES = [{ name: 'id', method: :exact, type: :integer }]
  end

  def search(model)
    return model if params[:query].blank?

    keywords = {}

    params[:query].split(' ').each_with_index do |keyword, i|
      keywords["like_#{i}".to_sym] = "%#{keyword}%"
      keywords["exact_#{i}".to_sym] = keyword
      parts = []

      self.class::SEARCH_ATTRIBUTES.each do |attr|
        if attr[:type] == :integer
          keywords["exact_#{i}".to_sym] = keyword.to_i
          parts << "#{attr[:name]} = :exact_#{i}"
        else
          case attr[:method]
            when :like
              parts << "#{attr[:name]} ILIKE :like_#{i}"

            when :map
              parts << "#{attr[:name]} = #{attr[:map][keyword]}" if attr[:map].has_key?(keyword)

            else
              parts << "#{attr[:name]} = :exact_#{i}"
          end
        end
      end

      model = model.where(parts.join(' OR '), keywords)
    end

    model
  end
end
