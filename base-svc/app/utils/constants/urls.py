class Urls():
    # Product
    ROOT = "/products"
    _get_all_product = ROOT
    _get_product_id = ROOT + "/{product_id}"
    _add_product = ROOT
    _update_product = ROOT + "/{product_id}"
    _delete_product = ROOT + "/{product_id}"
    _test = ROOT + "/test/abc"
