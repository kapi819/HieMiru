# frozen_string_literal: true

# ApplicationHelper provides helper methods that can be used across views in the application.
# These methods can be used to encapsulate complex logic, making the views simpler and easier to maintain.

module ApplicationHelper
  def page_title(title = '')
    base_title = 'Hie Miru'
    title.present? ? "#{title} | #{base_title}" : base_title
  end

  def default_meta_tags
    {
      site: 'HieMiru',
      title: 'あなたの冷え性改善をサポート',
      reverse: true,
      charset: 'utf-8',
      description: 'HieMiruを使えば診断から始める冷え性の見える化で、冷え性の見える化をサポートします。',
      keywords: '冷え性、冷え症、冷え、診断、不調、末端',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('logo.png'), # 配置するパスやファイル名によって変更すること
        local: 'ja-JP'
      },
      # Twitter用の設定を個別で設定する
      twitter: {
        card: 'summary_large_image', # Twitterで表示する場合は大きいカードにする
        image: image_url('ogp.png') # 配置するパスやファイル名によって変更すること
      }
    }
  end
end
