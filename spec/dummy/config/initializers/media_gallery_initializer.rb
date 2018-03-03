MediaGallery::ApplicationController.class_eval do

  def create_ability(user)
    Ability.new(user)
  end
end
