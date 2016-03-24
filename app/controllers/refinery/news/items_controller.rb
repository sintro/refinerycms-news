module Refinery
  module News
    class ItemsController < ::ApplicationController
      before_filter :find_page
      before_filter :find_published_news_items, :only => [:index]
      before_filter :find_news_item, :find_latest_news_items, :only => [:show]
      before_filter :include_images, :only => [:show, :index]

      def index
        # render 'index'
      end

      def show
        # render 'show'
      end

      def archive
        if params[:month].present?
          @archive_for_month = true
          @archive_date = Time.parse("#{params[:month]}/#{params[:year]}")
          @items = Item.archived.translated.by_archive(@archive_date).page(params[:page])
        else
          @archive_date = Time.parse("01/#{params[:year]}")
          @items = Item.archived.translated.by_year(@archive_date).page(params[:page])
        end
      end

      protected

      def find_latest_news_items
        @items = Item.latest.translated
      end

      def find_published_news_items
        @items = Item.published.page(params[:page])
      end

      def include_images
        if Item.method_defined? :images
          @items = @items.includes(:images, images: :translations)
        end
      end

      def find_news_item
        @item = Item.published.translated.friendly.find(params[:id])

        @item_images = nil
        if Item.method_defined? :images
          @item_images = @item.images.includes(:translations)
        end   
      end

      def find_page
        @page = ::Refinery::Page.find_by_link_url("/news") if defined?(::Refinery::Page)
      end

    end
  end
end
