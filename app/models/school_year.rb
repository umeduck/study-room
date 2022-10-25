class SchoolYear < ActiveHash::Base
  self.data = [
    { id: 1, year: '---' },
    { id: 2, year: '中学１年生' },
    { id: 3, year: '中学２年生' },
    { id: 4, year: '中学３年生' },
    { id: 5, year: '高校１年生' },
    { id: 6, year: '高校２年生' },
    { id: 7, year: '高校３年生' }
  ]

  include ActiveHash::Associations
  has_many :users
end
