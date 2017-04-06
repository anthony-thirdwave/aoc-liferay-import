class CNWOnline
  attr_accessor :banner, :cover_image, :title, :intro, :contributors, :author, :content, :date, :id, :file, :all_images, :rotator

  def initialize(params)
    @banner = params[0]
    @cover_image = params[1]
    @title = params[2]
    @author = params[3]
    @content = params[4]
    @intro = params[5]
    @contributors = params[6]
    @date = params[7]
    @id = params[8]
    @file = params[9]
    @all_images = params[10]
    @rotator = params[11]
  end
end
