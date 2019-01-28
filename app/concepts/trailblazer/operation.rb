module Trailblazer
  class Operation
    require 'will_paginate/array'

    def params_to_sym_array(params)
      params&.split(',')&.map(&:to_sym)
    end

    def out_of_range?(page, model)
      page.to_i <= model.total_pages
    end
  end
end
