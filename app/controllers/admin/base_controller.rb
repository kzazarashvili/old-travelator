module Admin
  class BaseController < ApplicationController
    include AdminSearch
    layout 'admin'
  end
end
