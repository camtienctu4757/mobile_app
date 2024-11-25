class Urls():
    # Product
    ROOT = "/bookings"
    _create_booking = ROOT #ok
    _update_booking_success = ROOT+"/sucsess/{appoint_id}" #ok
    _update_booking_cancle = ROOT +"/cancle/{appoint_id}" #ok
    _get_all_bookings = ROOT #ok
    _get_booking_byid = ROOT +'/{booking_id}' #ok
    _get_booking_byday = ROOT +'/date/{booking_day}' #ok
    _get_booking_byuser = ROOT + '/user' #ok
    _get_booking_byshop_success = ROOT +'/shop/sucess/{shop_id}'
    _get_booking_byshop_cancle = ROOT +'/shop/cancle/{shop_id}'
    _get_booking_byshop_pending = ROOT +'/shop/pending/{shop_id}'
    _get_booking_byshop = ROOT +"/shop/{shop_id}" #ok
    _get_booking_success = ROOT +"/success" # ok
    _get_booking_cancle = ROOT + "/cancle" #ok
    _get_booking_pendings = ROOT +"/pending" #ok


    #timeslot
    ROOT_TIMESLOT = "/timeslots"
    _create_timeslot = ROOT_TIMESLOT #ok
    _get_timeslot_byservice_available = ROOT_TIMESLOT + "/{service_id}" # ok
    _get_timeslot_service_all = ROOT_TIMESLOT + "/service/{service_id}" # ok
    _get_timeslot_bydate = ROOT_TIMESLOT + "date/{date}" # ok
    _get_timeslot_bydate_available = ROOT_TIMESLOT + "/available/{date}" # ok

