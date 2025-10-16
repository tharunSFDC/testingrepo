import { LightningElement, wire } from "lwc";
import returnoppos from '@salesforce/apex/Opportuintytriggerforecast.returnoppos'
import { exportCSVFile } from "c/utilits"
export default class DemoCsvfileGeneration extends LightningElement {

    opposdata;
    oppoheader={
        Id:'ID',
        Name:'Name',
        Amount:'Amount',
        StageName:'StageName',
        CloseDate:'CloseDate'
    }
    @wire(returnoppos)
    oppos ({data,error}){
        if(data)
        {
            console.log(data)
            this.opposdata=data
        }
        if(error)
        {
            console.log(error)
        }
    }
    handleclick()
    {
        exportCSVFile(this.oppoheader,this.opposdata,'Opportunity CSV')

    }
}