module OffersHelper
  include Pagy::Frontend

  Pagy::Frontend::I18N.load(file: Rails.root.join('config', 'locales', 'de.yml'), language:'de')

  # Pagination for bootstrap: it returns the html with the series of links to the pages
  def pagy_nav_bootstrap(pagy)
    html, link, p_prev, p_next = +'', pagy_link_proc(pagy, 'class="page-link"'), pagy.prev, pagy.next

    html << (p_prev ? %(<li class="page-item prev">#{link.call p_prev, pagy_t('pagy.nav.prev'), 'aria-label="previous"'}</li>)
                    : %(<li class="page-item prev disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.prev')}</a></li>))
    pagy.series.each do |item| # series example: [1, :gap, 7, 8, "9", 10, 11, :gap, 36]
      html << if    item.is_a?(Integer); %(<li class="page-item">#{link.call item}</li>)                                                               # page link
              elsif item.is_a?(String) ; %(<li class="page-item active">#{link.call item}</li>)                                                        # active page
              elsif item == :gap       ; %(<li class="page-item gap disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.gap')}</a></li>) # page gap
              end
    end
    html << (p_next ? %(<li class="page-item next">#{link.call p_next, pagy_t('pagy.nav.next'), 'aria-label="next"'}</li>)
                    : %(<li class="page-item next disabled"><a href="#" class="page-link">#{pagy_t('pagy.nav.next')}</a></li>))
    %(<nav class="pagy-nav-bootstrap pagination" role="navigation" aria-label="pager"><ul class="pagination">#{html}</ul></nav>)
  end
end
