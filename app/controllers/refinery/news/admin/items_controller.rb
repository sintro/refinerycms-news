module Refinery
  module News
    module Admin
      class ItemsController < ::Refinery::AdminController

        crudify :'refinery/news/item', :order => "publish_date DESC"

        private

          def item_params
            params[:item][:images_attributes]={} if params[:item][:images_attributes].nil?
            params.require(:item).permit(:title,
                                          :body,
                                          :content,
                                          :source,
                                          :publish_date,
                                          :expiration_date,
                                          images_attributes: [:id, :caption]
                                          )
          end

      end
    end
  end
end
