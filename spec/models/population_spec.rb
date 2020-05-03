require 'rails_helper'

RSpec.describe Population, type: :model do

  it "should accept a year we know and return the correct population" do
    aggregate_failures do
      expect(Population.get(1900)).to eq(76_212_168)
      expect(Population.get(1990)).to eq(248_709_873)
    end
  end

  it "should accept a year we don't know and return the previous known population" do
    aggregate_failures do
      expect(Population.get(1902)).to eq(79_415_432)
      expect(Population.get(1908)).to eq(89_025_224)
    end
  end

  it "should accept a year that is before earliest known and return zero" do
    aggregate_failures do
      expect(Population.get(1800)).to eq(0)
      expect(Population.get(0)).to eq(0)
      expect(Population.get(-1000)).to eq(0)
    end
  end

  it "should accept a year that is after latest known and return a predictive result" do
    aggregate_failures do
      expect(Population.get(2000)).to eq(611_727_577)
      expect(Population.get(2045)).to eq(35_111_607_348)
    end
  end

  it "should return the value for year Population::MAX_PREDICTION_YEAR for larger years" do
    aggregate_failures do
      expect(Population.get(Population::MAX_PREDICTION_YEAR)).to eq(21_370_257_002_448_594_707_431_817_216)
      expect(Population.get(Population::MAX_PREDICTION_YEAR + 1)).to eq(21_370_257_002_448_594_707_431_817_216)

    end
  end

  context "growth_rate" do
    it "should calculate positive growth rate if pop_2 is larger than pop_1" do
      expect(Population.growth_rate(10, 100, 5)).to be > 0
    end

    it "should calculate negative growth rate if pop_1 is larger than pop_2" do
      expect(Population.growth_rate(100, 10, 5)).to be < 0
    end

    it "should calculate the slope of a simple regression between to populations" do
      expect(Population.growth_rate(10, 100, 5)).to eq(18)
    end
  end
end
