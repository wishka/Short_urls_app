class UrlsController < ApplicationController
  before_create :generate_short_url
  
  def create
    original_url = params[:original_url]
    short_url = generate_short_url

    url = Url.new(original_url: original_url, short_url: short_url)
    if url.save
      render json: { short_url: url.short_url }, status: :created
    else
      render json: { errors: url.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    url = Url.find_by(short_url: params[:short_url])
    if url
      url.increment!(:clicks_count)
      redirect_to url.original_url
    else
      render json: { error: "URL not found" }, status: :not_found
    end
  end

  def stats
    url = Url.find_by(short_url: params[:short_url])

    if url
      render json: { clicks_count: url.clicks_count }
    else
      render json: { error: "URL not found" }, status: :not_found
    end
  end

  private

  def generate_short_url
    self.short_url = SecureRandom.hex(4) # Генерируем краткий URL из случайных символов
  end
end