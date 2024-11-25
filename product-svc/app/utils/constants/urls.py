class Urls():
    # Product
    ROOT = "/products"
    _get_all_product = ROOT 
    _search_products = ROOT +"/search"
    _get_product_id = ROOT + "/{product_id}"
    _get_product_shopid = ROOT + "/shop/{shop_id}"
    _get_product_catalog = ROOT + "/catalog"
    _add_product = ROOT
    _update_product = ROOT
    _delete_product = ROOT + "/{product_id}"
    _test = ROOT + "/test/abc"
