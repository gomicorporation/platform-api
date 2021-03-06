module Api
  module V1
    class ProductCollectionsController < BaseController
      before_action :authenticate_request!
      before_action :set_product_collection, only: %i[show update destroy]

      # GET /api/v1/product_collections
      # GET /api/v1/product_collections.json
      def index
        @product_collections = decorator_class.decorate_collection(ProductCollection.all)

        render json: @product_collections, status: :ok
      end

      # GET /api/v1/product_collections/1
      # GET /api/v1/product_collections/1.json
      def show
        render json: @product_collection
      end

      # POST /api/v1/product_collections
      # POST /api/v1/product_collections.json
      def create
        @product_collection = ProductCollection.new(product_collection_params)

        if @product_collection.save
          render json: decorator_class.decorate(@product_collection), status: :created
        else
          render json: @product_collection.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/product_collections/1
      # PATCH/PUT /api/v1/product_collections/1.json
      def update
        if @product_collection.update(product_collection_params)
          render json: @product_collection, status: :ok
        else
          render json: @product_collection.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/product_collections/1
      # DELETE /api/v1/product_collections/1.json
      def destroy
        @product_collection.destroy
      end

      protected

      def default_decorator_name
        'ProductCollections::DefaultDecorator'
      end

      private
      # Use callbacks to share common setup or constraints between actions.
      def set_product_collection
        @product_collection = decorator_class.decorate(ProductCollection.find(params[:id]))
      end

      # Only allow a list of trusted parameters through.
      def product_collection_params
        params.fetch(:product_collection, {})
      end
    end
  end
end
