class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def formatted_postal_code
    "#{postal_code[0, 2]}.#{postal_code[2, 7]}"
  end
end
