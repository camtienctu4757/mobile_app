class Urls():
    ROOT_User = "/users"
    _get_me = ROOT_User
    _create_user = ROOT_User
    _delete_user = ROOT_User
    _update_user = ROOT_User + '/{user_id}'
    _update_user_pass = ROOT_User + '/pass/{user_id}'
    ROOT_Employee = "/employees"
    _create_absence_employee = ROOT_Employee

    ROOT_Notification = "/notifications"
    _get_token = ROOT_Notification



    

    