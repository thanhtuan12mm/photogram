module ApplicationHelper
  def form_image_select(post)
    return image_tag post.image.url(:medium),
                     id: 'image-preview',
                     class: 'img-fluid' if post.image.exists?
    image_tag '323399.jpg', id: 'image-preview', class: 'img-fluid'
  end

  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium),
                     id: 'image-preview',
                     class: 'img-responsive img-circle profile-image' if user.avatar.exists?
    image_tag 'default-avatar.png', id: 'image-preview',
                                    class: 'img-responsive img-circle profile-image'
  end
end
