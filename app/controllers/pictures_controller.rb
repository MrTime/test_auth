class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @pictures = Picture.all
    respond_with(@pictures)
  end

  def show
    @temp_file = $my_redis['temp_file']

    $my_redis['show_count'] = $my_redis['show_count'] + 1
    #$redis.set('show_count', ($redis.get('show_count').to_i + 1).to_s)

    respond_with(@picture)
  end

  def new
    @picture = Picture.new
    respond_with(@picture)
  end

  def edit
  end

  def create
    original_file = picture_params[:file]

    path = "tmp/image_queue/#{Picture.count + 1}#{File.extname(original_file.original_filename)}"


    f = File.new path, "wb"
    f.binmode
    bin = original_file.read()
    f.write(bin)
    f.flush

    @picture = Picture.new(temp_file_path: path)
    @picture.save

    #Picture.delay.process_file(@picture.id)
    #$redis.rpush('pictures_queue', @picture.id)
    
    $my_redis['created_count'] += 1

    respond_with(@picture)
  end

  def update
    @picture.update(picture_params)
    $my_redis['updated_count'] += 1
    respond_with(@picture)
  end

  def destroy
    @picture.destroy
    $my_redis['destroy_count'] += 1
    respond_with(@picture)
  end

  private
    def set_picture
      @picture = Picture.find(params[:id])
    end

    def picture_params
      params.require(:picture).permit(:file)
    end
end
