class City < ApplicationRecord
  validates :name, presence: true

  has_many :metrics

  after_commit :fetch_metrics, on: [:create]

  def current_weather
    metrics.last
  end

  private

  def fetch_metrics
    WeatherMetricsService.delay.fetch(id)
  end
end
