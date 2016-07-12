class BorrowMailer < ApplicationMailer
  default from: 'no-reply@doocracy.com'

  def ask_owner(item)
    @item = item

    mail to: item.inventory.user.email,
         subject: "#{@item.borrowed_by.last.user_name.capitalize} wants to borrow #{@item.title}"
  end

  def recipient_access(recipient_email)
    mail to: recipient_email, subject: request_answer
  end

  def recipient_deny(recipient_email)
    mail to: recipient_email, subject: request_answer
  end

  private

  def request_answer
    "Request to borrow"
  end
end
