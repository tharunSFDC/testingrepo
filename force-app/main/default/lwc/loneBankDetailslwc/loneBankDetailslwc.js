import { LightningElement, api, wire } from "lwc";
import { getRecord } from "lightning/uiRecordApi";
import ACCOUNT_NUMBER from "@salesforce/schema/Account.AccountNumber";
import IFSC_CODE from '@salesforce/schema/Account.IFSC_CODE__c';
export default class LoneBankDetailslwc extends LightningElement {
	@api recordId;
	AccountNumber;
	IfscCode;
	copyMessage;

	@wire(getRecord, {
		recordId: '$recordId',
		fields: [ACCOUNT_NUMBER, IFSC_CODE]
	})
	getAccountsdetails({ data, error }) {
		if (data) {
			this.AccountNumber = data.fields.AccountNumber?.value;
			this.IfscCode = data.fields.IFSC_CODE__c?.value;

		} else if (error) {
			alert('Error fetching the data', error.body.message);

		}
	}
	copyAccountNumber() {
		this.copytoclipboard(this.AccountNumber, 'Account Number Copied Successfully');
	}
	copyIFSCCode() {
		this.copytoclipboard(this.IfscCode, 'IFSC Code Copied Successfully');
	}

	copytoclipboard(value, message) {
		if (!value) return;

		navigator.clipboard.writeText(value)
			.then(() => {
				this.copyMessage = message;
				setTimeout(() => this.copyMessage = '', 2000);

			}).catch(error => {
				console.log('Clipboard copy Faild', error.body.message);
				this.copyMessage = '';
			})
	}
}