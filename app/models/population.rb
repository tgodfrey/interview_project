class Population < ApplicationRecord

  YEAR_INCREMENT = 10
  PREDICTED_GROWTH_RATE = 0.09
  MAX_PREDICTION_YEAR = 2500

  def self.min_year
    Population.order(year: :asc).first.year.year
  end

  def self.max_year
    Population.order(year: :desc).first.year.year
  end

  def self.get(year)
    year = year.to_i

    return 0 if year < min_year

    # return Population.find_by_year(Date.new(max_year)).population if year > max_year

    if year > max_year
      year = MAX_PREDICTION_YEAR if year > MAX_PREDICTION_YEAR
      max_population = Population.find_by_year(Date.new(max_year)).population
      num_years = year - max_year
      return (max_population * Math.exp(PREDICTED_GROWTH_RATE * num_years)).round
    end


    pop = nil
    year_last_digit = year % YEAR_INCREMENT

    # This assumes the data will always be in increments of 10 years.
    if year_last_digit == 0
      pop = Population.find_by_year(Date.new(year)).population
    else
      pop_1 = Population.find_by_year(Date.new(year - year_last_digit))
      pop_2 = Population.find_by_year(Date.new(year + (YEAR_INCREMENT - year_last_digit)))
      num_years = (pop_1.year.year - pop_2.year.year).abs

      pop = pop_1.population + (growth_rate(pop_1.population, pop_2.population, num_years) * year_last_digit).to_i
    end

    return pop if pop

    nil
  end

  def self.growth_rate(pop_1, pop_2, num_years)
    (pop_2 - pop_1) / num_years
  end

end
