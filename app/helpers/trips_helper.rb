module TripsHelper
  def formated_date(date)
    date&.strftime('%B %d, %Y')
  end
end

def class_for(action)
  action == 'create' ? 'success' : 'primary'
end

def icon_for(action)
  action == 'create' ? 'check' : 'edit'
end
