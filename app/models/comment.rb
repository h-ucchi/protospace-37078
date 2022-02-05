class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :prototype

  validates :content, presence: true  #presence: trueは入力必須ということ

end
