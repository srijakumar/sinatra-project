class Tenant < ActiveRecord::Base
  has_many :requests

  has_secure_password

  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
    Tenant.all.find{|tenant| tenant.slug == slug}
  end

end
