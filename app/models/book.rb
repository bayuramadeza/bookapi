class Book < ApplicationRecord
    belongs_to :author
    validates :author_id, presence: true
end
