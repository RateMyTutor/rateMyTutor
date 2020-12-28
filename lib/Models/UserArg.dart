class UserArg{

  String _userID;
  String _userName;
  String _status;

  UserArg(String userID, String userName, String status){
    this._userID = userID;
    this._userName = userName;
    this._status = status;
  }// User

  String getUserID(){
    return this._userID;
  }// getUserID

  String getUserName(){
    return this._userName;
  }// getUserName

  String getStatus(){
    return this._status;
  }// getStatus


}// user class