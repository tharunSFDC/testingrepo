import { LightningElement, api } from "lwc";
import {updateRecord} from 'lightning/uiRecordApi'
import STAGENAME_FIELD from '@salesforce/schema/Opportunity.StageName'
import ID_FIELD from '@salesforce/schema/Opportunity.Id'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ClosedActionOpportunity extends LightningElement {
	@api recordId;
	@api
	invoke() {
		const fields={}
        fields[ID_FIELD.fieldApiName]=this.recordId
        fields[STAGENAME_FIELD.fieldApiName]='Closed Won'
        const recordInput ={ fields }
       // console.log(this.recordId)
        console.log(fields.STAGENAME_FIELD)
        console.log(fields.ID_FIELD)

        updateRecord(recordInput).then(()=>{
            this.showToast('Success!!','Opportunity is Closed Won','success')

        }).catch((error)=>{
            this.showToast('error!!',error.body.message,'error')

        })
	}

    showToast(title, message, type)
    {
        this.dispatchEvent(new ShowToastEvent({
            title:title,
            message:message,
            variant:type
        }))
    }
}