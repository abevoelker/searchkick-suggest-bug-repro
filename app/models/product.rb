class Product < ActiveRecord::Base
  searchkick suggest: [:title]
end

