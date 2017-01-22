class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
end

#for models/TK class Car << ApplicationRecord 
