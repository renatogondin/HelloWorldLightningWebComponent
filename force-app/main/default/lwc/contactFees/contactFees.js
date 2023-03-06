import { LightningElement, api, wire, track } from 'lwc';
import getContactCostsByAccount from '@salesforce/apex/ContactFeeService.getContactCostsByAccount';

export default class ContactFees extends LightningElement {

    @api recordId;
    error;
    contact;

    @track columns = [{
        label: 'Identifier',
        fieldName: 'Id',
        type: 'text',
        sortable: true
    },
    {
        label: 'Name',
        fieldName: 'name',
        type: 'text',
        sortable: true
    },
    {
        label: 'Cost per Calendar Month',
        fieldName: 'calendar',
        type: 'text',
        sortable: true
    },
    {
        label: 'ATM Fee in other currencies',
        fieldName: 'fee',
        type: 'text',
        sortable: true
    },
    {
        label: 'Card Replacement Cost',
        fieldName: 'card',
        type: 'text',
        sortable: true
    }
];

    @wire(getContactCostsByAccount, {accountId: '$recordId'}) 
    wireContact({error, data}){
        if(data){
            this.contact = data;
            this.error = undefined;
        }else{
            this.contact = undefined;
            this.error = error;
        }
    }
}