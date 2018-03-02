MediaGallery::ApplicationController.class_eval do

  def current_user
    User.find_by_token(request.headers['token'])
  end

  def create_ability(user)
    Ability.new(user)
  end
end
