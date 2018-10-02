# frozen_string_literal: true

class SimplifyAdminGenerator < Rails::Generators::NamedBase
  include Rails::Generators::Actions

  source_root File.expand_path('templates', __dir__)
  class_option :layout_name, type: :string, default: 'application'
  class_option :options, type: :string, default: []

  def import_assets
    css_file_path = "#{Rails.root}/app/assets/stylesheets/#{layout_name}.css"
    File.rename(css_file_path, "#{layout_name}.css.scss") if File.exist?(css_file_path)

    css_file_names = %w(bootstrap-sprockets bootstrap font-awesome simplify_admin)
    File.open("#{css_file_path}.scss", 'a') do |f|
      css_file_names.each do |n|
        next if File.read(f).match(/@import "#{n}";/)
        f.puts <<~css
          @import "#{n}";
        css
      end
    end

    js_file_path = "#{Rails.root}/app/assets/javascripts/#{layout_name}.js"
    File.open(js_file_path, 'a') do |f|
      f.puts("//= require simplify_admin") unless File.read(f).match(/simplify_admin/)
    end
  end
  
  def create_layout
    layout_html_path = "#{Rails.root}/app/views/layouts/#{layout_name}.html.erb"
    File.rename(layout_html_path, "#{options["layout_name"]}.html.slim") if File.exist?(layout_html_path)
    layout_path = "#{Rails.root}/app/views/layouts/#{layout_name}.html.slim"

    helper_methods_exist?(%w(body_id body_class))

    File.truncate(layout_path, 0) if File.exist?(layout_path)
    File.open(layout_path, 'w') do |f|
      f.puts <<~slim
        doctype html
        html
          head
            meta content=("text/html; charset=UTF-8") http-equiv="Content-Type" /
            = yield :tb_before_cache
            title
              | #{title}
            = csrf_meta_tags
            = action_cable_meta_tag
            = stylesheet_link_tag    "#{layout_name}", media: 'all', 'data-turbolinks-track': 'reload'
            = javascript_include_tag "#{layout_name}", 'data-turbolinks-track': 'reload'
            = javascript_pack_tag    "#{layout_name}"

          body id=body_id class=body_class
            .wrapper
              = render 'shared/header'
              = render 'shared/sidebar'
              .main-container
                .padding-md
                  = yield :breadcrumb
                  = yield
            a.scroll-to-top.hidden-print href='#'
              i.fa.fa-chevron-up.fa-lg
      slim
    end
  end

  def create_simplify_admin_header
    return if file_name != 'layout'

    create_file 'app/views/shared/_header.html.slim' do
      <<~header_partial
        header.top-nav
          .top-nav-inner
            .nav-header
              button#sidebarToggleSM.navbar-toggle.pull-left.sidebar-toggle type="button"
                span.icon-bar
                span.icon-bar
                span.icon-bar
              a.brand href='#'
                i.fa.fa-database
                span.brand-name
                  | #{title}

            .nav-container
              button#sidebarToggleLG.navbar-toggle.pull-left.sidebar-toggle type='button'
                span.icon-bar
                span.icon-bar
                span.icon-bar
              .pull-right.m-right-sm
                .user-block.hidden-xs
                  a#userToggle data-toggle='dropdown' href='#'
                    #user-detail.user-detail.inline-block
                      #user-avatar
                        / - if current_user.avatar.blank?
                        /   = image_tag 'avatar-default.png'
                        / - else
                        /   = image_tag current_user.avatar.url
                      / span.ml5 = current_user&.name
                      i.fa.fa-angle-down.m-left-xs

                  .panel.border.dropdown-menu.user-panel style="left: -20px;"
                    .panel-body.paddingTB-sm
                      ul
                        li
                          = link_to nil do
                            i.fa.fa-cog.fa-lg
                            span.m-left-xs 个人设置
                        li
                          = link_to nil, method: 'delete' do
                            i.fa.fa-power-off.fa-lg
                            span.m-left-xs 登出
      header_partial
    end
  end

  def create_simplify_admin_sidebar
    return if file_name != 'layout'

    helper_methods_exist?(%w(render_active render_open display_block))

    create_file 'app/views/shared/_sidebar.html.slim' do
      <<~sidebar_partial
        aside.sidebar-menu.fixed
          .sidebar-inner.scrollable-sidebar
            .main-menu
              ul#test.accordion
                li.menu-header
                  | Main Menu

                li.bg-palette1 class=render_active(['dashboard'])
                  = link_to nil do
                    span.menu-content.block
                      span.menu-icon
                        i.block.fa.fa-home.fa-lg
                      span.text.m-left-sm 主页
                    span.menu-content-hover.block
                      | 主页

                li.openable.bg-palette2 class=render_active(['foo'])
                  = link_to nil do
                    span.menu-content.block
                      span.menu-icon
                        i.block.fa.fa-list.fa-lg
                      span.text.m-left-sm Lorem Ipsum
                      span.submenu-icon
                    span.menu-content-hover.block
                      | Lorem Ipsum
                  ul.submenu.bg-palette2 style=display_block(['foo'])
                    li class=render_active(['foo'], 'index', 'new', 'edit')
                      = link_to nil do
                        span.submenu-label Lorem Ipsum
      sidebar_partial
    end
  end

  def create_dashboard_controller
    create_file "#{prefix('c')}/dashboard_controller.rb" do
      <<~dashboard_controller
          # frozen_string_literal: true

          class DashboardController < ApplicationController
            def index
            end
          end
      dashboard_controller
    end

    route "root 'dashboard#index'"
  end

  def create_dashboard_view
    create_file "#{prefix('v')}/dashboard/index.html.slim" do
      <<~dashboard_page
        .row.m-bottom-md
          .col-sm-6
            .page-title
              | Dashboard
            .page-sub-header
              | Welcome come back🙂
      dashboard_page
    end
  end

  private

  def helper_methods_exist?(methods)
    methods.each do |m|
      raise "Missing #{ m } method, please init KTemplate first!" unless app_helper_code.match(/def #{ m }/)
    end
  end

  def app_helper_code
    if !File.exist?("#{ Rails.root }/app/helpers/application_helper.rb")
      raise 'Missing application_helper.rb, please generate KTemplate first!'
    end
    File.read("#{ Rails.root }/app/helpers/application_helper.rb")
  end

  def layout_name
    options["layout_name"]
  end

  def prefix(t)
    t = case t
        when 'm' then 'models'
        when 'v' then 'views'
        when 'c' then 'controllers'
        end
    layout_name == 'application' ? "app/#{t}/" : "app/#{t}/#{ layout_name }"
  end

  def title
    attrs.fetch(:title)
  end

  def attrs
    options["options"].split(' ').map { |ele| ele.split(':') }.to_h.symbolize_keys
  end
end
