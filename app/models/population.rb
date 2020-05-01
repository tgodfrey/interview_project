class Population < ApplicationRecord

  def self.min_year
    Population.order(year: :asc).first.year.year
  end

  def self.max_year
    Population.order(year: :desc).first.year.year
  end

  def self.get(year)
    year = year.to_i

    return 0 if year < min_year

    if year > max_year
      return Population.find_by_year(Date.new(max_year)).population
    end

    pop = nil
    until pop
      pop = Population.find_by_year(Date.new(year))
      year = year - 1
    end

    return pop.population if pop

    nil
  end

end
