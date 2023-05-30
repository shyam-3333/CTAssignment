import { LightningElement } from 'lwc';

export default class BusinessCardParentComponent extends LightningElement {
    userDetails= [
        {
            name:'Yash Patil',
            title:'Finance Head',
            company: 'Harvard University, example',
            buttontext: 'Contact',
            imageUrl: 'https://www.w3schools.com/w3images/team1.jpg'
        },
        {
            name:'Tejas Patil',
            title:'General Head',
            company: 'Harvard University, example',
            buttontext: 'Contact',
            imageUrl: 'https://www.w3schools.com/w3images/team1.jpg'
        },
        {
            name:'Sachin Patil',
            title:'Support Head',
            company: 'Harvard University, example',
            buttontext: 'Contact',
            imageUrl: 'https://www.w3schools.com/w3images/team1.jpg'
        }
    ]
}