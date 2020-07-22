module LayoutHelper

  def body_class
    # sidebar_or_subnav = content_for?(:nav_sub) ? 'with_subnav' : 'with_sidebar'
    # sidebar_or_subnav = 'fullscreen' if @fullscreen_layout
    # [
    #   (request.path.include?('/admin/') ? 'admin' : nil),
    #   controller.controller_name,
    #   controller.action_name,
    #   sidebar_or_subnav,
    #   (@fullscreen_layout ? 'fullscreen' : ''),
    #   (@formular_layout ? 'formular' : ''),
    #   (@fullscreen_formular_layout ? 'fullscreen_formular' : '')
    # ].compact.join(' ')
    body_html_options_for :class
  end

  def body_html_options(options = {})
    @body_html_options = options
  end

  def body_html_options_for(key)
    @body_html_options ||= {}
    if key == :class
      @body_html_options[:class] = [@body_html_options[:class], "#{controller.controller_name} #{controller.controller_name}__#{controller.action_name}"].compact.join(" ")
    end
    @body_html_options[key]
  end

  def hide_all_sidebars
    @hide_all_sidebars = true
  end

  def hide_footer
    @show_footer = false
  end

  def hide_social_media_buttons
    @show_social_media_buttons = false
  end

  def hide_premium_pois
    @show_premium_pois = false
  end

  def hide_title
    @show_title = false
  end

  def hide_all_sidebars?
    @hide_all_sidebars
  end

  def show_footer?
    @show_footer or @show_footer.nil?
  end

  def show_premium_pois?
    !(@poi and @poi.premium?) and @show_premium_pois or @show_premium_pois.nil?
  end

  def show_social_media_buttons?
    @show_social_media_buttons or @show_social_media_buttons.nil?
  end

  def show_title?
    @show_title or @show_title.nil?
  end



  # def disable_sub_navigation
  #   @disable_sub_navigation = true
  # end
  #
  # def formular
  #   @formular_layout = true
  # end
  #
  # def hide_main_navigation
  #   @hide_main_navigation = true
  # end
  #
  # def hide_flash_messages
  #   @hide_flash_messages_layout = true
  # end
  #
  # def hide_footer
  #   @hide_footer_layout = true
  # end
  #
  # def hide_title
  #   @hide_title_layout = true
  # end
  #
  # def messages
  #   @message_layout = true
  # end
  #
  # def show_main_navigation?
  #   !@hide_main_navigation
  # end

  # def show_fullscreen_formular
  #   hide_main_navigation
  #   hide_flash_messages
  #   hide_title
  #   hide_footer
  #   @fullscreen_formular_layout = true
  # end
  #
  # def show_fullscreen_formular?
  #   !!@fullscreen_formular_layout
  # end
  #
  # def show_flash_messages_layout?
  #   !@hide_flash_messages_layout
  # end
  #
  # def show_footer_layout?
  #   !@hide_footer_layout
  # end
  #
  # def show_title_layout?
  #   !@hide_title_layout
  # end

  # def video
  #   @video = true
  # end
  #
  # def video_layout
  #   @video_layout = true
  # end
  #
  # def widescreen
  #   @widescreen = true
  # end

end
