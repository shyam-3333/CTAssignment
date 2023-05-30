<aura:application extends="force:slds" controller="PagingSortingController">
	<aura:attribute type="Product__c[]"    name="allAccounts" />
    <aura:attribute type="Product__c[]"    name="currentList" />
    <aura:attribute type="Integer"      name="pageNumber"		default="1" />
    <aura:attribute type="Integer"      name="maxPage"			default="1" />
    <aura:attribute type="String"       name="sortField" />
    <aura:attribute type="Boolean"		name="sortAsc" />
    <aura:handler name="init"			value="{!this}"			action="{!c.doInit}" />
    <aura:handler name="change"			value="{!v.pageNumber}"	action="{!c.renderPage}" />
    
    <table class="slds-table slds-table--bordered slds-table--cell-buffer">
        <thead>
            <tr class="slds-text-title--caps">
                <th scope="col">
                    <div onclick="{!c.sortByName}"
                         class="slds-truncate"
                         title="Account Name">
                         Name
                        <aura:if isTrue="{!v.sortField=='Name'}">
                            <span>
                            	<aura:if isTrue="{!v.sortAsc}">
                                    &#8593;
                                    <aura:set attribute="else">
                                        &#8595;
                                    </aura:set>
                                </aura:if>
                            </span>
                        </aura:if>
                    </div>
                </th>
                <th scope="col">
                    <div onclick="{!c.sortBySKU}"
                         class="slds-truncate"
                         title="Account Name">
                        SKU
                        <aura:if isTrue="{!v.sortField=='SKU'}">
                            <span>
                            	<aura:if isTrue="{!v.sortAsc}">
                                    &#8593;
                                    <aura:set attribute="else">
                                        &#8595;
                                    </aura:set>
                                </aura:if>
                            </span>
                        </aura:if>
                    </div>
                </th>
                <th scope="col">
                    <div onclick="{!c.sortByCategory}"
                         class="slds-truncate"
                         title="Category">
                        Category
                        <aura:if isTrue="{!v.sortField=='Category'}">
                            <span>
                            	<aura:if isTrue="{!v.sortAsc}">
                                    &#8593;
                                    <aura:set attribute="else">
                                        &#8595;
                                    </aura:set>
                                </aura:if>
                            </span>
                        </aura:if>
                    </div>
                </th>
                <th scope="col">
                    <div onclick="{!c.sortByVendor}"
                         class="slds-truncate"
                         title="Vendor">
                        Vendor
                        <aura:if isTrue="{!v.sortField=='Vendor'}">
                            <span>
                            	<aura:if isTrue="{!v.sortAsc}">
                                    &#8593;
                                    <aura:set attribute="else">
                                        &#8595;
                                    </aura:set>
                                </aura:if>
                            </span>
                        </aura:if>
                    </div>
                </th>
                
            </tr>
        </thead>
        <tbody>
            <aura:iteration items="{!v.currentList}"
                            var="record">
                <tr>
                	<th data-label="Name">
                        <div class="slds-truncate" title="{!record.Name}">
                            {!record.Name}
                        </div>
                    </th>
                	<th data-label="SKU">
                        <div class="slds-truncate" title="{!record.SKU_Code__c}">
                            {!record.SKU_Code__c}
                        </div>
                    </th>
                	<th data-label="Category">
                        <div class="slds-truncate" title="{!record.Product_Category_Taneira__c}">
                            {!record.Product_Category_Taneira__c}
                        </div>
                    </th>
                    <th data-label="Vendor">
                        <div class="slds-truncate" title="{!record.Vendor_Name__c}">
                            {!record.Vendor_Name__c}
                        </div>
                    </th>
                </tr>
            </aura:iteration>
        </tbody>
    </table>

    <c:pagination currentPageNumber="{!v.pageNumber}" 
                        maxPageNumber="{!v.maxPage}" />
</aura:application>