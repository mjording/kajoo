class Comment < ActiveRecord::Base
  belongs_to :issue
end
