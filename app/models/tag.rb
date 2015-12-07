class Tag < ActiveRecord::Base
  has_and_belongs_to_many :posts

  def self.get_tag_by_name(name)
    tag = Tag.where(:name => name).first
    if !tag
      tag = Tag.create(:name => name)
    end
    return tag
  end

  def self.unlink_tag_from_post(post, tag)
    post.tags.delete(tag)
    if tag.posts.empty?
      tag.destroy
    end
  end
end
