import { LightningElement, api, wire, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';
import getOpportunitiesForAccount from '@salesforce/apex/AccountOpportunityController.getOpportunitiesForAccount';
import getOpportunityCount from '@salesforce/apex/AccountOpportunityController.getOpportunityCount';
import updateOpportunityStage from '@salesforce/apex/AccountOpportunityController.updateOpportunityStage';

const COLUMNS = [
    {
        label: 'Opportunity Name',
        fieldName: 'opportunityUrl',
        type: 'url',
        typeAttributes: {
            label: { fieldName: 'Name' },
            target: '_blank'
        },
        sortable: true
    },
    {
        label: 'Stage',
        fieldName: 'StageName',
        type: 'text',
        editable: true,
        sortable: true
    },
    {
        label: 'Amount',
        fieldName: 'Amount',
        type: 'currency',
        sortable: true,
        cellAttributes: { alignment: 'left' }
    },
    {
        label: 'Close Date',
        fieldName: 'CloseDate',
        type: 'date',
        sortable: true
    },
    {
        label: 'Probability (%)',
        fieldName: 'Probability',
        type: 'percent',
        sortable: true,
        cellAttributes: { alignment: 'left' }
    },
    {
        label: 'Type',
        fieldName: 'Type',
        type: 'text',
        sortable: true
    },
    {
        label: 'Lead Source',
        fieldName: 'LeadSource',
        type: 'text',
        sortable: true
    },
    {
        label: 'Owner',
        fieldName: 'OwnerName',
        type: 'text',
        sortable: true
    }
];

export default class AccountOpportunityTable extends LightningElement {
    @api recordId; // Account ID passed from record page
    @track opportunities = [];
    @track columns = COLUMNS;
    @track sortBy;
    @track sortDirection;
    @track isLoading = false;
    @track opportunityCount = 0;
    @track draftValues = [];

    wiredOpportunitiesResult;
    wiredCountResult;

    @wire(getOpportunitiesForAccount, { accountId: '$recordId' })
    wiredOpportunities(result) {
        this.wiredOpportunitiesResult = result;
        if (result.data) {
            this.opportunities = result.data.map(opp => {
                return {
                    ...opp,
                    opportunityUrl: `/lightning/r/Opportunity/${opp.Id}/view`,
                    OwnerName: opp.Owner ? opp.Owner.Name : ''
                };
            });
        } else if (result.error) {
            this.showToast('Error', 'Error loading opportunities: ' + result.error.body.message, 'error');
        }
    }

    @wire(getOpportunityCount, { accountId: '$recordId' })
    wiredCount(result) {
        this.wiredCountResult = result;
        if (result.data) {
            this.opportunityCount = result.data;
        } else if (result.error) {
            console.error('Error loading opportunity count:', result.error);
        }
    }

    get hasOpportunities() {
        return this.opportunities && this.opportunities.length > 0;
    }

    get tableTitle() {
        return `Related Opportunities (${this.opportunityCount})`;
    }

    handleSort(event) {
        const { fieldName: sortedBy, sortDirection } = event.detail;
        const cloneData = [...this.opportunities];

        cloneData.sort(this.sortBy(sortedBy, sortDirection === 'asc' ? 1 : -1));
        this.opportunities = cloneData;
        this.sortDirection = sortDirection;
        this.sortBy = sortedBy;
    }

    sortBy(field, reverse) {
        const key = function (x) {
            return x[field];
        };

        return function (a, b) {
            a = key(a);
            b = key(b);
            return reverse * ((a > b) - (b > a));
        };
    }

    async handleSave(event) {
        this.isLoading = true;
        const updatedFields = event.detail.draftValues;

        try {
            // Update each record
            const updatePromises = updatedFields.map(record => {
                return updateOpportunityStage({
                    opportunityId: record.Id,
                    newStage: record.StageName
                });
            });

            await Promise.all(updatePromises);

            // Clear draft values
            this.draftValues = [];

            // Refresh the data
            await refreshApex(this.wiredOpportunitiesResult);
            await refreshApex(this.wiredCountResult);

            this.showToast('Success', 'Opportunities updated successfully', 'success');

        } catch (error) {
            this.showToast('Error', 'Error updating opportunities: ' + error.body.message, 'error');
        } finally {
            this.isLoading = false;
        }
    }

    handleCancel() {
        this.draftValues = [];
    }

    refreshData() {
        this.isLoading = true;
        return Promise.all([
            refreshApex(this.wiredOpportunitiesResult),
            refreshApex(this.wiredCountResult)
        ]).finally(() => {
            this.isLoading = false;
        });
    }

    showToast(title, message, variant) {
        const evt = new ShowToastEvent({
            title: title,
            message: message,
            variant: variant
        });
        this.dispatchEvent(evt);
    }
}
