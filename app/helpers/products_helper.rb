module ProductsHelper
  def cache_key_for_products
    count = @products
    max_updated_at = @products.maximum(:updated_at).try(:utc).try(:to_s, :number)
    "products/all-#{count}-#{max_updated_at}"
  end
end