module ApplicationHelper

  def profile_avatar_select(user)
    return image_tag user.avatar.url(:medium),
    id: 'image-preview',
    class: 'img-responsive img-circle profile-image' if user.avatar.exists?
      image_tag 'default-avatar.jpg', id: 'image-preview',
      class: 'img-responsive img-circle profile-image'
      end

      def alert_for(flash_type)
        {
          :success => 'alert-success',
          :error => 'alert-danger',
          :alert => 'alert-warning',
          :notice => 'alert-info'
          }[flash_type.to_sym] || flash_type.to_s
        end

        def link_to_image(image_path, target_link,options={})
          link_to(image_tag(image_path, :border => "0"), target_link, options)
        end

      end
