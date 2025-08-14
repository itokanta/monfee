module ApplicationHelper
  def get_back_path(referer, student)
    return student_path(student) if referer.blank?
    
    # refererのパスを取得
    begin
      referer_uri = URI.parse(referer)
      referer_path = referer_uri.path
      
      # 各パターンに応じて戻り先を決定
      case referer_path
      when /^\/$/                          # ルートページ（/）
        root_path
      when /^\/students\/\d+$/ # 生徒詳細ページ
        student_path(student)
      else
        student_path(student) # デフォルトは生徒詳細ページ
      end
    rescue URI::InvalidURIError
      student_path(student) # エラーの場合はデフォルト
    end
  end
end
