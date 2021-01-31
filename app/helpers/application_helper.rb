module ApplicationHelper
  def is_friend(id1,id2) #checking already friend or request sent or recieved
    (Friendship.where(sent_by_id:id1,sent_to_id:id2,status:true).exists?) || (
        Friendship.where(sent_to_id:id1,sent_by_id:id2,status:true).exists?) 
  end
  def is_request_sent(id1,id2) #checking already friend or request sent or recieved
      (Friendship.where(sent_by_id:id1,sent_to_id:id2).exists?) || (
          Friendship.where(sent_to_id:id1,sent_by_id:id2).exists?) 
  end
end
