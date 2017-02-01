class Notification
  
  attr_accessor :header, :body, :icon, :link

  @header
  @body
  @link
  @icon

  def initialize(header, body, link, icon)
    @header = header
    @body = body
    @link = link
    @icon = icon
  end

  def generate_html_body()
    "#{@body}<br><a href='#{@link}'>View on Gitlab</a>"
  end
end