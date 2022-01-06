import { LightningElement, api, track, wire } from 'lwc';
import getAccounts from '@salesforce/apex/ExternalAccountsREST.getAccounts';
import getRecords from '@salesforce/apex/ExternalAccountsREST.getRecords';
import Type from '@salesforce/schema/Account.Type';

export default class ExternalAccountsREST extends LightningElement {
    @track
    tableData;
    records;
    size = 10;
    names = [];

    columns = [
        {label: 'Account Number', fieldName: 'AccountNumber'},
        {label: 'Name', fieldName: 'Name'},
        {label: 'Account Type', fieldName: 'Type'}
    ];

    @wire(getAccounts,{size : '$size'})
    wiredGetAcc({data,error}){
        if(data){
            this.records = JSON.parse(data);
            this.records.forEach((element) =>{
                console.log('🌻', element.Name);
                this.names.push(element.Name);
            });
            console.log('🌱',this.names);
            this.handleGetrecords();
        }else if(error){
            console.log('data.error ⭕⭕⭕');
            console.error(error);
        }
    }

    handleGetrecords(){
        getRecords({names : this.names})
        .then(result => {
            console.log('🍔', result);
            this.names = [];
            this.tableData = result;
        })
        .catch(error => {
            console.log('data.error ⭕⭕⭕');
            console.error(error);
        });
    }

    updateSize(event) {
        this.size = this.template.querySelector('lightning-input').value;
    }

}