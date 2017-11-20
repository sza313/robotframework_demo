*** Variables ***
${el.mainNavigation}    xpath=//nav[contains(@class,'top-navigation-header')]
${el.corporateNews}    xpath=//a[text()='Corporate news']/ancestor::section[@class='featured']
${el.myNews}      xpath=//section[@class='mynews']
${el.engage}      xpath=//section[@class='engagepart']
${el.myNewsModal}    xpath=//div[@id="modal_editmyNews"]
${el.myNewsCogButton}    xpath=//section[@class="mynews"]//h1[@class="sectionTitle"]//a[@class="edit"]
${el.myNewsModalTabs}    xpath=//div[@id="modal_editmyNews"]//ul[@class="nav nav-tabs"]
${el.myNewsModalFilters}    xpath=//div[@id="modal_editmyNews"]//div[@class="newsFilters"]
