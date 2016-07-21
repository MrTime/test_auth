class Picture < ActiveRecord::Base
  has_attached_file :file, 
    styles: { thumb: '100x100>', medium: '300x300>' }, 
    default_url: '/test.jpg'
  validates_attachment_content_type :file, content_type: /\Aimage\/.*\Z/

  def temp_file_path=(val)
    Rails.logger.debug " =================== CALLED WITH #{val}"
    $redis.set('temp_file_path', val)
  end

  def temp_file_path
    $redis.get('temp_file_path')
  end

  def self.process_file(id)
    Rails.logger.debug "pricessing started"

    p = Picture.find(id)
    path = p.temp_file_path
    p.file = File.new(path, 'rb')
    p.temp_file_path = nil
    p.save

    FileUtils.remove_file(path)

    Rails.logger.debug "pricessing finished"
  end

end
