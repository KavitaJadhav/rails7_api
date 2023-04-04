class Email < ApplicationRecord
  scope :some_complex_scope, -> { where("SELECT true FROM pg_sleep(1)").limit(10) }
end
