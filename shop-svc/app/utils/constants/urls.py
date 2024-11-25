class Urls():
    # Product
    ROOT = "/shops"
    _get_shopby_userid = ROOT + "/owner"
    _get_shop_id = ROOT + "/{shop_id}"
    _delete_shop = ROOT + "/{shop_id}"
    _get_nearby_shop = ROOT + "/location"
    _create_shop = ROOT
    _update_shop = ROOT
