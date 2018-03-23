class Ability
  include CanCan::Ability

  def initialize(user)

    can :manage, MediaGallery::ImageScratch do |scratch|
      !user.nil? && !user.disabled?
    end

    can :manage, MediaGallery::Gallery do |gallery|
      !user.nil? && !user.disabled? && (user.admin? || (!user.admin? && user == gallery.ownable))
    end

    can :manage, MediaGallery::ImageInfo do |image_info|
      !user.nil? && !user.disabled? && (user.admin? || (!user.admin? && user == image_info.gallery.ownable))
    end

  end

end
