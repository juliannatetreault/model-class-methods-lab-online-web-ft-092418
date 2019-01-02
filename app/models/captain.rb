class Captain < ActiveRecord::Base
  has_many :boats

  def self.catamaran_operators
    all.includes(boats: :classifications).where(classifications: {name: "Catamaran"})
  end

  def self.sailors
    all.includes(boats: :classifications).where(classifications: {name: "Sailboat"}).uniq
  end

  def self.motorboats 
    all.includes(boats: :classifications).where(classifications: {name: "Motorboat"})
  end

  def self.talented_seafarers
    all.where("id IN(?)", sailors.pluck(:id) & motorboats.pluck(:id))
  end

  def self.non_sailors
    all.where.not("id IN (?)", sailors.pluck(:id))
  end
end
