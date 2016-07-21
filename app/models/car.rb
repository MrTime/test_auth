class Car < ActiveRecord::Base
  puts "asdsad"

  has_many :details

  monetize :price_kopiykas

  default_scope { main }

  scope :main, -> { where(deleted_at: nil) }
  scope :only_deleted, -> { where("deleted_at IS NOT NULL") }
  scope :by_year, -> (start, finish) { where(year: start..finish) }
  scope :by_title, -> (title) { 
    val = "%#{title}%"
    joins(:details).where("title LIKE ? OR details.value LIKE ? OR details.kind LIKE ?", val, val, val) 
  }

  #scope :by_exactly, -> { where(title: params[:q]) } 
  #scope :by_exactly, -> { where("title = #{params[:q]}") } 
  
  accepts_nested_attributes_for :details, allow_destroy: true

  def destroy
    update_attributes(deleted_at: Time.now)
  end

  searchable do
    text :title
    text :details do
      details.map {|d| [d.kind, d.value].join(' ') }
    end
    integer :year
  end
end
