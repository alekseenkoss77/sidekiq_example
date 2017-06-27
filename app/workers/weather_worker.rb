class WeatherWorker
  include Sidekiq::Worker

  def perform
    City.find_each { |c| WeatherMetricsService.fetch(c.id) }
  end
end
